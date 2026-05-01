// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/social_platform_resolver.dart';
import '../../../core/constants/vcard_label_options.dart';
import '../../../l10n/app_localizations.dart';

/// Displays Tier 3 vCard data: birthday, nickname, phones, emails, URLs, social, note.
/// Used in the expandable section under the QR code.
/// [summaryDisplayName] is the same string shown above the fold; nickname is omitted when
/// it only repeats that name. Phones/emails skip the first entry (already shown as primary).
class VcardDataDisplay extends StatelessWidget {
  const VcardDataDisplay({
    super.key,
    required this.contact,
    required this.textColor,
    required this.summaryDisplayName,
  });

  final Contact contact;
  final Color textColor;
  final String summaryDisplayName;

  /// True if there is at least one extra row after hiding what the QR summary already shows.
  static bool hasExpandableData(
    Contact contact, {
    required String summaryDisplayName,
  }) {
    final summaryName = summaryDisplayName.trim();
    final hasBday = contact.events.any(
      (e) => e.label.label == EventLabel.birthday,
    );
    final nn = (contact.name?.nickname ?? '').trim();
    final hasNickname = nn.isNotEmpty && nn != summaryName;
    final hasMultiplePhones = contact.phones.length > 1;
    final hasMultipleEmails = contact.emails.length > 1;
    final hasWebsites = contact.websites.isNotEmpty;
    final hasSocial = contact.socialMedias.isNotEmpty;
    final hasNote =
        contact.notes.isNotEmpty &&
        (contact.notes.first.note).trim().isNotEmpty;
    return hasBday ||
        hasNickname ||
        hasMultiplePhones ||
        hasMultipleEmails ||
        hasWebsites ||
        hasSocial ||
        hasNote;
  }

  static const _labelSize = 11.0;
  static const _valueSize = 13.0;
  static const _sectionSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sections = <Widget>[];

    final bday = contact.events
        .where((e) => e.label.label == EventLabel.birthday)
        .firstOrNull;
    if (bday != null) {
      sections.add(_buildSection('Birthday', _formatBirthday(bday)));
    }

    final nickname = contact.name?.nickname?.trim();
    if (nickname != null &&
        nickname.isNotEmpty &&
        nickname != summaryDisplayName.trim()) {
      sections.add(_buildSection('Nickname', nickname));
    }

    final extraPhones = contact.phones.skip(1).toList();
    if (extraPhones.isNotEmpty) {
      final items = extraPhones.map((p) {
        final label = VcardLabelOptions.phoneDisplayName(
          p.label.label,
          loc,
          p.label.customLabel,
        );
        return '$label: ${p.number}';
      }).toList();
      sections.add(_buildSection('Phone numbers', items.join('\n')));
    }

    final extraEmails = contact.emails.skip(1).toList();
    if (extraEmails.isNotEmpty) {
      final items = extraEmails.map((e) {
        final label = VcardLabelOptions.emailDisplayName(
          e.label.label,
          loc,
          e.label.customLabel,
        );
        return '$label: ${e.address}';
      }).toList();
      sections.add(_buildSection('Email addresses', items.join('\n')));
    }

    if (contact.websites.isNotEmpty) {
      final urls = contact.websites.map((w) => w.url).toList();
      sections.add(_buildSection('URLs', urls.join('\n')));
    }

    if (contact.socialMedias.isNotEmpty) {
      final items = contact.socialMedias.map((s) {
        final (platform, customLabel) = SocialPlatformResolver.resolveForRead(
          s,
          loc,
        );
        final label = platform != null
            ? SocialPlatformResolver.displayName(platform)
            : VcardLabelOptions.socialDisplayName(
                s.label.label,
                loc,
                s.label.customLabel,
              );
        return '$label: ${s.username}';
      }).toList();
      sections.add(_buildSection('Social media', items.join('\n')));
    }

    final note = contact.notes.isNotEmpty ? contact.notes.first.note : null;
    if (note != null && note.trim().isNotEmpty) {
      sections.add(_buildSection('Note', note.trim()));
    }

    if (sections.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          sections
              .expand((s) => [s, const SizedBox(height: _sectionSpacing)])
              .toList()
            ..removeLast(),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _labelSize,
            color: textColor.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          content,
          style: TextStyle(
            fontSize: _valueSize,
            color: textColor.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  String _formatBirthday(Event event) {
    final date = DateTime(event.year ?? 2000, event.month, event.day);
    final locale = WidgetsBinding.instance.platformDispatcher.locale.toString();
    return event.year != null
        ? DateFormat.yMMMd(locale).format(date)
        : DateFormat.MMMd(locale).format(date);
  }
}
