// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';

/// Utilities for checking which fields a contact has.
/// Single source of truth for "contact has shareable data" logic.
class ContactFieldPresence {
  ContactFieldPresence._();

  /// Returns true if the contact has at least one shareable field:
  /// name, phones, emails, organizations, addresses, websites, socialMedias, or notes.
  static bool hasAnyData(Contact contact) {
    return contact.name != null ||
        contact.phones.isNotEmpty ||
        contact.emails.isNotEmpty ||
        contact.organizations.isNotEmpty ||
        contact.addresses.isNotEmpty ||
        contact.websites.isNotEmpty ||
        contact.socialMedias.isNotEmpty ||
        contact.notes.isNotEmpty;
  }
}
