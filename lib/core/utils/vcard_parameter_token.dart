// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

/// Produces a single safe token for vCard 3.0 property parameters (e.g. `TYPE=`).
///
/// Spaces and punctuation would require quoting in parameters; [vcard_dart] does
/// not quote spaces in parameter values, so we normalize user-facing labels
/// here for export only.
String vCardSafeTypeToken(String? raw) {
  final trimmed = raw?.trim() ?? '';
  if (trimmed.isEmpty) return 'x-custom';

  final lower = trimmed.toLowerCase();
  final chars = <String>[];
  for (final unit in lower.runes) {
    final isAlnum =
        (unit >= 0x30 && unit <= 0x39) || (unit >= 0x61 && unit <= 0x7a);
    if (isAlnum) {
      chars.add(String.fromCharCode(unit));
    } else {
      chars.add('-');
    }
  }
  var s = chars.join().replaceAll(RegExp(r'-+'), '-');
  s = s.replaceFirst(RegExp(r'^-+'), '');
  s = s.replaceFirst(RegExp(r'-+$'), '');
  if (s.isEmpty) return 'x-custom';
  return s;
}
