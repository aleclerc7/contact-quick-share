// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';

import '../../l10n/app_localizations.dart';
import 'social_platform_resolver.dart';

/// Single source of truth for vCard label options: curated lists, display names, defaults.
/// URLs have no label (vCard does not support it).
class VcardLabelOptions {
  VcardLabelOptions._();

  // --- Curated lists (order matters for dropdown) ---

  static const phoneLabels = [
    PhoneLabel.mobile,
    PhoneLabel.work,
    PhoneLabel.home,
    PhoneLabel.main,
    PhoneLabel.other,
    PhoneLabel.custom,
  ];

  static const emailLabels = [
    EmailLabel.home,
    EmailLabel.work,
    EmailLabel.other,
    EmailLabel.custom,
  ];

  static const addressLabels = [
    AddressLabel.home,
    AddressLabel.work,
    AddressLabel.other,
    AddressLabel.custom,
  ];

  // Social labels: use SocialPlatformResolver.appPlatforms instead.
  // socialDisplayName kept as fallback for unknown/custom labels.

  // --- Defaults for new entries ---

  static const defaultPhoneLabel = PhoneLabel.mobile;
  static const defaultEmailLabel = EmailLabel.home;
  static const defaultAddressLabel = AddressLabel.home;

  // --- Display names (AppLocalizations for i18n; null = English fallback for initState) ---

  static String _phoneDisplayNameEn(PhoneLabel label) => switch (label) {
    PhoneLabel.mobile => 'Mobile',
    PhoneLabel.work => 'Work',
    PhoneLabel.home => 'Home',
    PhoneLabel.main => 'Main',
    PhoneLabel.other => 'Other',
    PhoneLabel.custom => 'Custom',
    _ => label.name[0].toUpperCase() + label.name.substring(1),
  };

  static String phoneDisplayName(PhoneLabel label, AppLocalizations? loc, [String? customLabel]) {
    if (label == PhoneLabel.custom && customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }
    return loc != null ? switch (label) {
      PhoneLabel.mobile => loc.phoneLabelMobile,
      PhoneLabel.work => loc.phoneLabelWork,
      PhoneLabel.home => loc.phoneLabelHome,
      PhoneLabel.main => loc.phoneLabelMain,
      PhoneLabel.other => loc.phoneLabelOther,
      PhoneLabel.custom => loc.phoneLabelCustom,
      _ => label.name[0].toUpperCase() + label.name.substring(1),
    } : _phoneDisplayNameEn(label);
  }

  static String _emailDisplayNameEn(EmailLabel label) => switch (label) {
    EmailLabel.home => 'Home',
    EmailLabel.work => 'Work',
    EmailLabel.other => 'Other',
    EmailLabel.custom => 'Custom',
    _ => label.name[0].toUpperCase() + label.name.substring(1),
  };

  static String emailDisplayName(EmailLabel label, AppLocalizations? loc, [String? customLabel]) {
    if (label == EmailLabel.custom && customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }
    return loc != null ? switch (label) {
      EmailLabel.home => loc.emailLabelHome,
      EmailLabel.work => loc.emailLabelWork,
      EmailLabel.other => loc.emailLabelOther,
      EmailLabel.custom => loc.emailLabelCustom,
      _ => label.name[0].toUpperCase() + label.name.substring(1),
    } : _emailDisplayNameEn(label);
  }

  static String _addressDisplayNameEn(AddressLabel label) => switch (label) {
    AddressLabel.home => 'Home',
    AddressLabel.work => 'Work',
    AddressLabel.other => 'Other',
    AddressLabel.custom => 'Custom',
    _ => label.name[0].toUpperCase() + label.name.substring(1),
  };

  static String addressDisplayName(AddressLabel label, AppLocalizations? loc, [String? customLabel]) {
    if (label == AddressLabel.custom && customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }
    return loc != null ? switch (label) {
      AddressLabel.home => loc.addressLabelHome,
      AddressLabel.work => loc.addressLabelWork,
      AddressLabel.other => loc.addressLabelOther,
      AddressLabel.custom => loc.addressLabelCustom,
      _ => label.name[0].toUpperCase() + label.name.substring(1),
    } : _addressDisplayNameEn(label);
  }

  static String socialDisplayName(SocialMediaLabel label, AppLocalizations loc, [String? customLabel]) {
    if (label == SocialMediaLabel.custom && customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }
    return SocialPlatformResolver.socialMediaLabelDisplayName(label, loc, customLabel);
  }

  // --- Map unknown labels to Custom + customLabel on load ---

  static (PhoneLabel, String?) normalizePhoneLabel(PhoneLabel label, String? customLabel, [AppLocalizations? loc]) {
    if (phoneLabels.contains(label)) {
      return (label, customLabel);
    }
    return (PhoneLabel.custom, phoneDisplayName(label, loc, customLabel));
  }

  static (EmailLabel, String?) normalizeEmailLabel(EmailLabel label, String? customLabel, [AppLocalizations? loc]) {
    if (emailLabels.contains(label)) {
      return (label, customLabel);
    }
    return (EmailLabel.custom, emailDisplayName(label, loc, customLabel));
  }

  static (AddressLabel, String?) normalizeAddressLabel(AddressLabel label, String? customLabel, [AppLocalizations? loc]) {
    if (addressLabels.contains(label)) {
      return (label, customLabel);
    }
    return (AddressLabel.custom, addressDisplayName(label, loc, customLabel));
  }
}
