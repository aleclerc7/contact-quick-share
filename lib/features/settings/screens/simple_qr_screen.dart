// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../qr_code/models/simple_qr_payload.dart';
import '../../qr_code/utils/qr_decoration_factory.dart';
import '../../qr_code/utils/qr_share_actions.dart';
import '../../qr_code/widgets/qr_action_menu.dart';
import '../../qr_code/widgets/qr_close_button.dart';
import '../../qr_code/widgets/qr_layout_shell.dart';
import '../../qr_code/widgets/qr_raw_data_dialog.dart';
import '../providers/settings_notifier.dart';
import '../services/default_appearance_resolver.dart';

/// Generic Simple QR screen: displays a QR code with payload-based content.
/// For URL: Copy button with truncated URL. Tap on QR opens the same action
/// menu pattern as contact/card QR (share image, view data, open link).
/// Architecture ready for future types (vCard, WiFi).
class SimpleQrScreen extends ConsumerWidget {
  const SimpleQrScreen({
    super.key,
    required this.payload,
  });

  final SimpleQrPayload payload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSettings = ref.watch(settingsNotifierProvider);
    return asyncSettings.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (settings) {
        final resolver = DefaultAppearanceResolver(
          settings: settings,
          colorScheme: Theme.of(context).colorScheme,
        );
        return _SimpleQrContent(
          ref: ref,
          payload: payload,
          resolver: resolver,
        );
      },
    );
  }
}

class _SimpleQrContent extends StatefulWidget {
  const _SimpleQrContent({
    required this.ref,
    required this.payload,
    required this.resolver,
  });

  final WidgetRef ref;
  final SimpleQrPayload payload;
  final DefaultAppearanceResolver resolver;

  @override
  State<_SimpleQrContent> createState() => _SimpleQrContentState();
}

class _SimpleQrContentState extends State<_SimpleQrContent> {
  static const _border = 15.0;
  static const _urlButtonMaxWidth = 280.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _playBriefCelebration();
    });
  }

  void _onClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onHorizontalDragEnd(BuildContext context, DragEndDetails details) {
    const threshold = 100.0;
    final velocity = details.primaryVelocity ?? 0;
    if (velocity > threshold) {
      _onClose(context);
    }
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    await Clipboard.setData(ClipboardData(text: widget.payload.data));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.copiedToClipboard)),
      );
    }
  }

  void _openQrActionMenu(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final dataType = detectQrDataType(widget.payload.data);
    QrActionMenu.show(
      context,
      onShareAsImage: () {
        QrShareActions.shareSimpleAsImageWithFeedback(
          context,
          widget.ref,
          widget.payload,
          widget.resolver,
          shareCaption: loc.appTitle,
        );
      },
      onShareAsVCard: null,
      onViewQrDataAsText: () {
        QrRawDataDialog.show(context, widget.payload.data);
      },
      trailing: dataType == QrDataType.url
          ? QrActionMenuTrailingItem(
              label: loc.openLink,
              icon: Icons.open_in_new,
              onTap: () {
                _openUrl(context, widget.payload.data);
              },
            )
          : null,
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final loc = AppLocalizations.of(context)!;
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !uri.hasScheme) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
      return;
    }
    try {
      final didLaunch = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (!didLaunch && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.couldNotOpenLink)),
        );
      }
    }
  }

  void _playBriefCelebration() {
    if (!mounted) return;
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _CelebrationBurst(
        onFinished: () {
          entry.remove();
        },
      ),
    );
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.resolver.resolveBackgroundColor(widget.payload.backgroundColor);
    final textColor = widget.resolver.resolveTextColor(widget.payload.textColor);
    final decoration =
        QrDecorationFactory.forSimplePayload(widget.payload, widget.resolver);
    final dataType = detectQrDataType(widget.payload.data);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onClose(context);
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: GestureDetector(
          onHorizontalDragEnd: (d) => _onHorizontalDragEnd(context, d),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: QrLayoutShell(
                        border: _border,
                        qrBuilder: (context, qrSize) => _QrCodeArea(
                          size: qrSize,
                          data: widget.payload.data,
                          decoration: decoration,
                          onTap: () => _openQrActionMenu(context),
                        ),
                        contentBuilder: (context, {required bool isLandscape}) =>
                            _buildContentSection(
                          context,
                          dataType: dataType,
                          backgroundColor: backgroundColor,
                          textColor: textColor,
                          isPortrait: !isLandscape,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QrCloseButton(
                backgroundColor: backgroundColor,
                iconColor: textColor,
                onTap: () => _onClose(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(
    BuildContext context, {
    required QrDataType dataType,
    required Color backgroundColor,
    required Color textColor,
    required bool isPortrait,
  }) {
    if (dataType == QrDataType.url) {
      final button = FilledButton.icon(
        onPressed: () => _copyToClipboard(context),
        style: FilledButton.styleFrom(
          backgroundColor: textColor,
          foregroundColor: backgroundColor,
        ),
        icon: const Icon(Icons.copy, size: 20),
        label: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _urlButtonMaxWidth),
          child: Text(
            widget.payload.data,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
      return Align(
        alignment: isPortrait ? Alignment.topCenter : Alignment.center,
        child: button,
      );
    }
    return const SizedBox.shrink();
  }
}

class _QrCodeArea extends StatelessWidget {
  const _QrCodeArea({
    required this.size,
    required this.data,
    required this.decoration,
    required this.onTap,
  });

  final double size;
  final String data;
  final PrettyQrDecoration decoration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: PrettyQrView.data(
          data: data,
          decoration: decoration,
          errorCorrectLevel: QrErrorCorrectLevel.H,
        ),
      ),
    );
  }
}

class _CelebrationBurst extends StatefulWidget {
  const _CelebrationBurst({required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<_CelebrationBurst> createState() => _CelebrationBurstState();
}

class _CelebrationBurstState extends State<_CelebrationBurst> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.play();
      Future<void>.delayed(const Duration(milliseconds: 4200), () {
        if (!mounted) return;
        widget.onFinished();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox.expand(
        child: IgnorePointer(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: -1.5708,  // -pi / 2
              emissionFrequency: 0.00,
              numberOfParticles: 50,
              maxBlastForce: 50,
              minBlastForce: 20,
              gravity: 0.7,
              colors: const [
                Color(0xFFE8C547),
                Color(0xFF4A90D9),
                Color(0xFFD94A7A),
                Color(0xFF6BCB77),
                Color(0xFFB388FF),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
