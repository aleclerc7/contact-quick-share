// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';

import '../../l10n/app_localizations.dart';
import '../utils/vcard_parameter_token.dart';

/// Internal platform definition for the app's curated social platform list.
/// Decouples our UI from flutter_contacts' SocialMediaLabel enum.
class AppSocialPlatform {
  const AppSocialPlatform({
    required this.id,
    this.contactLabel,
    required this.displayLabel,
    required this.urlTemplate,
  });

  final String id;
  final SocialMediaLabel? contactLabel;
  /// Display-only label for dropdown/UI. Storage and matching use [id].
  final String displayLabel;
  /// Full URL template with a `{username}` placeholder (without a leading `@`).
  /// User input is normalized by stripping leading `@` before substitution; templates
  /// that need `@` in the path use `@{username}` (e.g. TikTok, YouTube, Mastodon).
  final String urlTemplate;
}

/// Resolver between the app's curated social platform list and flutter_contacts.
/// Maps contact data to our list when reading, and our selection to contact
/// storage when writing. Best-effort preservation of official vs custom labels.
class SocialPlatformResolver {
  SocialPlatformResolver._();

  // Platform selection rationale: We include only ID/username-based platforms.
  // Phone-based platforms (WhatsApp, WeChat, Signal) are excluded because the
  // vCard TEL field already carries the phone number. Storing them again under
  // social media would duplicate data. The social section is for platforms that
  // require a distinct identifier: @username, LINE ID, VK user ID, etc.
  static const appPlatforms = [
    AppSocialPlatform(
      id: 'twitter',
      contactLabel: SocialMediaLabel.twitter,
      displayLabel: 'X',
      urlTemplate: 'https://x.com/{username}',
    ),
    AppSocialPlatform(
      id: 'linkedin',
      contactLabel: SocialMediaLabel.linkedIn,
      displayLabel: 'LinkedIn',
      urlTemplate: 'https://linkedin.com/in/{username}',
    ),
    AppSocialPlatform(
      id: 'facebook',
      contactLabel: SocialMediaLabel.facebook,
      displayLabel: 'Facebook',
      urlTemplate: 'https://facebook.com/{username}',
    ),
    AppSocialPlatform(
      id: 'instagram',
      contactLabel: null,
      displayLabel: 'Instagram',
      urlTemplate: 'https://instagram.com/{username}',
    ),
    AppSocialPlatform(
      id: 'tiktok',
      contactLabel: null,
      displayLabel: 'TikTok',
      urlTemplate: 'https://tiktok.com/@{username}',
    ),
    AppSocialPlatform(
      id: 'youtube',
      contactLabel: null,
      displayLabel: 'YouTube',
      urlTemplate: 'https://youtube.com/@{username}',
    ),
    AppSocialPlatform(
      id: 'telegram',
      contactLabel: null,
      displayLabel: 'Telegram',
      urlTemplate: 'https://t.me/{username}',
    ),
    AppSocialPlatform(
      id: 'line',
      contactLabel: null,
      displayLabel: 'LINE',
      urlTemplate: 'https://line.me/ti/p/~{username}',
    ),
    AppSocialPlatform(
      id: 'vk',
      contactLabel: null,
      displayLabel: 'VK',
      urlTemplate: 'https://vk.com/{username}',
    ),
    AppSocialPlatform(
      id: 'mastodon',
      contactLabel: null,
      displayLabel: 'Mastodon',
      urlTemplate: 'https://mastodon.social/@{username}',
    ),
    AppSocialPlatform(
      id: 'bluesky',
      contactLabel: null,
      displayLabel: 'Bluesky',
      urlTemplate: 'https://bsky.app/profile/{username}',
    ),
    AppSocialPlatform(
      id: 'skype',
      contactLabel: SocialMediaLabel.skype,
      displayLabel: 'Skype',
      urlTemplate: 'https://join.skype.com/{username}',
    ),
    AppSocialPlatform(
      id: 'pinterest',
      contactLabel: null,
      displayLabel: 'Pinterest',
      urlTemplate: 'https://pinterest.com/{username}',
    ),
    AppSocialPlatform(
      id: 'reddit',
      contactLabel: null,
      displayLabel: 'Reddit',
      urlTemplate: 'https://reddit.com/u/{username}',
    ),
    AppSocialPlatform(
      id: 'github',
      contactLabel: null,
      displayLabel: 'GitHub',
      urlTemplate: 'https://github.com/{username}',
    ),
    AppSocialPlatform(
      id: 'snapchat',
      contactLabel: null,
      displayLabel: 'Snapchat',
      urlTemplate: 'https://snapchat.com/add/{username}',
    ),
    AppSocialPlatform(
      id: 'medium',
      contactLabel: null,
      displayLabel: 'Medium',
      urlTemplate: 'https://medium.com/@{username}',
    ),
    AppSocialPlatform(
      id: 'qq',
      contactLabel: SocialMediaLabel.qq,
      displayLabel: 'QQ',
      urlTemplate: 'https://qm.qq.com/{username}',
    ),
    AppSocialPlatform(
      id: 'sinaweibo',
      contactLabel: SocialMediaLabel.sinaWeibo,
      displayLabel: 'Sina Weibo',
      urlTemplate: 'https://weibo.com/{username}',
    ),
  ];

  /// Returns (platform, customLabel). If platform != null, use it for dropdown.
  /// If platform == null, customLabel is the display string for custom entry.
  /// [loc] is optional; when provided, Other/Custom are translated.
  static (AppSocialPlatform?, String?) resolveForRead(SocialMedia s, [AppLocalizations? loc]) {
    final label = s.label.label;
    final customLabel = s.label.customLabel;

    if (label == SocialMediaLabel.custom) {
      final raw = customLabel?.trim() ?? '';
      if (raw.isEmpty) return (null, socialMediaLabelDisplayName(label, loc, null));
      final matched = _findById(raw);
      if (matched != null) return (matched, null);
      return (null, raw);
    }

    final matched = _findByContactLabel(label);
    if (matched != null) return (matched, null);
    return (null, socialMediaLabelDisplayName(label, loc, customLabel));
  }

  /// Display name for SocialMediaLabel. Uses appPlatforms where possible; fallbacks for Other/Custom.
  /// [loc] is optional; when null, Other/Custom use English fallback.
  static String socialMediaLabelDisplayName(
    SocialMediaLabel label,
    AppLocalizations? loc, [
    String? customLabel,
  ]) {
    final platform = _findByContactLabel(label);
    if (platform != null) return platform.displayLabel;
    if (label == SocialMediaLabel.custom && customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }
    return switch (label) {
      SocialMediaLabel.other => loc?.socialLabelOther ?? 'Other',
      SocialMediaLabel.custom => loc?.socialLabelCustom ?? 'Custom',
      _ => label.name[0].toUpperCase() + label.name.substring(1),
    };
  }

  /// Returns Label to store in SocialMedia. platform may be null for Custom.
  static Label<SocialMediaLabel> resolveForWrite(
    AppSocialPlatform? platform,
    String? customLabel,
  ) {
    if (platform != null) {
      if (platform.contactLabel != null) {
        return Label(platform.contactLabel!);
      }
      return Label(SocialMediaLabel.custom, platform.id);
    }

    final raw = customLabel?.trim() ?? '';
    if (raw.isEmpty) return const Label(SocialMediaLabel.custom);
    final matchedEnum = _tryMatchCustomLabelToEnum(raw);
    if (matchedEnum != null) return Label(matchedEnum);
    return Label(SocialMediaLabel.custom, raw);
  }

  /// Display name for dropdown/UI. Platform names are NOT translated — same in all languages.
  static String displayName(AppSocialPlatform platform) {
    return platform.displayLabel;
  }

  /// When user types a string in Custom, try to match to official enum for best interoperability.
  static SocialMediaLabel? _tryMatchCustomLabelToEnum(String customLabel) {
    final lower = customLabel.trim().toLowerCase();
    for (final value in SocialMediaLabel.values) {
      if (value == SocialMediaLabel.custom) continue;
      if (value.name.toLowerCase() == lower) return value;
    }
    return null;
  }

  static AppSocialPlatform? _findByContactLabel(SocialMediaLabel label) {
    for (final p in appPlatforms) {
      if (p.contactLabel == label) return p;
    }
    return null;
  }

  static AppSocialPlatform? _findById(String label) {
    final lower = label.trim().toLowerCase();
    for (final p in appPlatforms) {
      if (p.id.toLowerCase() == lower) return p;
    }
    return null;
  }

  /// Strips leading whitespace and any leading `@` characters (common user habit).
  static String _normalizeSocialUsername(String raw) {
    var s = raw.trim();
    while (s.startsWith('@')) {
      s = s.substring(1).trimLeft();
    }
    return s;
  }

  /// Returns (url, type) for known platforms; (null, null) for unknown.
  static (String?, String?) socialMediaToUrlAndType(SocialMedia s) {
    final username = _normalizeSocialUsername(s.username);
    if (username.isEmpty) return (null, null);

    AppSocialPlatform? platform;
    final (p, customLabel) = resolveForRead(s);
    if (p != null) {
      platform = p;
    } else {
      final raw = customLabel?.trim() ?? '';
      if (raw.isNotEmpty) {
        platform = _findById(raw);
      }
    }

    if (platform == null) return (null, null);

    final template = platform.urlTemplate;
    final url = template.replaceAll('{username}', username);
    final type = platform.id;
    return (url, type);
  }

  /// True when the platform will be encoded as X-SOCIALPROFILE (no URL template).
  static bool isEncodedAsCustomProperty(
    AppSocialPlatform? platform,
    String? customLabel,
  ) {
    if (platform != null) return false;
    final raw = customLabel?.trim() ?? '';
    if (raw.isEmpty) return true;
    return _findById(raw) == null;
  }

  /// Returns (type, value) for X-SOCIALPROFILE when URL is null.
  static (String type, String value)? socialMediaToCustomPropertyTypeAndValue(
    SocialMedia s,
  ) {
    final username = s.username.trim();
    if (username.isEmpty) return null;

    final (_, customLabel) = resolveForRead(s);
    final raw = customLabel?.trim() ?? '';
    final type = vCardSafeTypeToken(raw);
    return (type, username);
  }

}
