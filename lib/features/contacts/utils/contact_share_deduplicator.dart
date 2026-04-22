// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter_contacts/flutter_contacts.dart';

/// Builds an in-memory deduplicated contact copy for the contact share flow.
///
/// This is intentionally local to share-field selection to avoid side effects
/// in other features that read raw device contact data.
Contact toShareDedupedContact(Contact source) {
  return source.copyWith(
    phones: _dedupeByKey(source.phones, (p) => _normalizePhone(p.number)),
    emails: _dedupeByKey(source.emails, (e) => e.address.trim().toLowerCase()),
    organizations: _dedupeByKey(source.organizations, (o) {
      return _normalizeText('${o.name ?? ''}|${o.departmentName ?? ''}|${o.jobTitle ?? ''}');
    }),
    addresses: _dedupeByKey(source.addresses, (a) {
      final formatted = (a.formatted ?? '').trim();
      if (formatted.isNotEmpty) return _normalizeText(formatted);
      return _normalizeText(
        '${a.street ?? ''}|${a.city ?? ''}|${a.state ?? ''}|'
        '${a.postalCode ?? ''}|${a.country ?? ''}',
      );
    }),
    websites: _dedupeByKey(source.websites, (w) => w.url.trim().toLowerCase()),
    socialMedias: _dedupeByKey(source.socialMedias, (s) {
      return _normalizeText(
        '${s.label.label.name}|${s.label.customLabel ?? ''}|${s.username}',
      );
    }),
    notes: _dedupeByKey(source.notes, (n) => _normalizeText(n.note)),
  );
}

List<T> _dedupeByKey<T>(List<T> source, String Function(T item) keyOf) {
  if (source.length < 2) return List<T>.from(source);

  final seen = <String>{};
  final out = <T>[];
  for (final item in source) {
    final key = keyOf(item);
    if (seen.add(key)) {
      out.add(item);
    }
  }
  return out;
}

String _normalizePhone(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) return '';

  final sb = StringBuffer();
  var hasLeadingPlus = false;
  for (var i = 0; i < trimmed.length; i++) {
    final ch = trimmed[i];
    final code = ch.codeUnitAt(0);
    final isDigit = code >= 48 && code <= 57;
    if (isDigit) {
      sb.write(ch);
      continue;
    }
    if (!hasLeadingPlus && sb.isEmpty && ch == '+') {
      hasLeadingPlus = true;
    }
  }
  final digits = sb.toString();
  return hasLeadingPlus ? '+$digits' : digits;
}

String _normalizeText(String input) {
  final trimmed = input.trim().toLowerCase();
  if (trimmed.isEmpty) return '';
  return trimmed.replaceAll(RegExp(r'\s+'), ' ');
}
