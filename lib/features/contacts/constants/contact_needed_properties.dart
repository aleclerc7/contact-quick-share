// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';

/// App-specific set of contact properties to fetch for display, search, and share.
/// Adapts to platform: iOS has no notes property. Includes events (e.g. birthday).
Set<ContactProperty> get neededProperties => Platform.isIOS
    ? {
        ContactProperty.name,
        ContactProperty.phone,
        ContactProperty.email,
        ContactProperty.address,
        ContactProperty.organization,
        ContactProperty.website,
        ContactProperty.socialMedia,
        ContactProperty.event,
        ContactProperty.photoThumbnail,
      }
    : {
        ContactProperty.name,
        ContactProperty.phone,
        ContactProperty.email,
        ContactProperty.address,
        ContactProperty.organization,
        ContactProperty.website,
        ContactProperty.socialMedia,
        ContactProperty.event,
        ContactProperty.note,
        ContactProperty.favorite,
        ContactProperty.photoThumbnail,
      };
