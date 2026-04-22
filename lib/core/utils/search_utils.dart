// SPDX-FileCopyrightText: © 2026 Alexandre Leclerc
//
// SPDX-License-Identifier: MPL-2.0

import 'package:diacritic/diacritic.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../features/business_cards/models/business_card.dart';
import '../../features/contacts/models/search_hit.dart';

/// Normalizes text for case- and accent-insensitive search.
String normalizeForSearch(String s) => removeDiacritics(s.toLowerCase());

/// Returns true if [text] contains [query] (case- and accent-insensitive).
bool containsMatch(String text, String query) {
  if (query.isEmpty) return true;
  return normalizeForSearch(text).contains(normalizeForSearch(query));
}

/// Finds the match range in [text] for [query] (accent-insensitive).
/// Returns (start, end) in original [text] indices, or null if no match.
/// Handles length changes from removeDiacritics (e.g. "œ" → "oe").
({int start, int end})? findMatchRangeAccentInsensitive(String text, String query) {
  if (query.isEmpty || text.isEmpty) return null;
  final normQuery = normalizeForSearch(query);
  if (normQuery.isEmpty) return null;

  // Build normalized text and mapping from normalized index -> original (start, end)
  final mapping = <({int start, int end})>[];
  final buffer = StringBuffer();
  var i = 0;
  while (i < text.length) {
    final char = text[i];
    final normChar = removeDiacritics(char);
    final start = i;
    i++;
    for (var j = 0; j < normChar.length; j++) {
      mapping.add((start: start, end: i));
    }
    buffer.write(normChar);
  }
  final normText = buffer.toString().toLowerCase();

  final idx = normText.indexOf(normQuery);
  if (idx < 0) return null;

  final endIdx = idx + normQuery.length;
  if (endIdx > mapping.length) return null;

  final startMap = mapping[idx];
  final endMap = mapping[endIdx - 1];
  return (start: startMap.start, end: endMap.end);
}

/// Extracts a snippet around the match in [note], with ellipsis if truncated.
/// Returns (snippet, matchStartInSnippet, matchEndInSnippet).
({String snippet, int matchStart, int matchEnd}) buildNoteSnippet(
  String note,
  String query, {
  int contextChars = 30,
}) {
  if (note.isEmpty || query.isEmpty) {
    return (snippet: note, matchStart: 0, matchEnd: 0);
  }
  final range = findMatchRangeAccentInsensitive(note, query);
  if (range == null) return (snippet: note, matchStart: 0, matchEnd: 0);

  final matchStart = range.start;
  final matchEnd = range.end;

  final snippetStart = (matchStart - contextChars).clamp(0, matchStart);
  final snippetEnd = (matchEnd + contextChars).clamp(matchEnd, note.length);

  final prefix = snippetStart > 0 ? '…' : '';
  final suffix = snippetEnd < note.length ? '…' : '';
  final snippet = '$prefix${note.substring(snippetStart, snippetEnd)}$suffix';
  final matchStartInSnippet = prefix.length + (matchStart - snippetStart);
  final matchEndInSnippet = prefix.length + (matchEnd - snippetStart);
  return (snippet: snippet, matchStart: matchStartInSnippet, matchEnd: matchEndInSnippet);
}

/// Tries to find a match in [text]; returns SearchHit if found.
SearchHit? _tryMatch(String text, String query) {
  final range = findMatchRangeAccentInsensitive(text, query);
  if (range == null) return null;
  return SearchHit(displayText: text, matchStart: range.start, matchEnd: range.end);
}

/// Tries to find a match in [note]; returns SearchHit with snippet if found.
SearchHit? _tryMatchNote(String note, String query, {bool includeNotes = true}) {
  if (!includeNotes || note.isEmpty) return null;
  final range = findMatchRangeAccentInsensitive(note, query);
  if (range == null) return null;
  final result = buildNoteSnippet(note, query, contextChars: 30);
  return SearchHit(
    displayText: result.snippet,
    matchStart: result.matchStart,
    matchEnd: result.matchEnd,
  );
}

/// Returns the first search hit in [contact], or null.
SearchHit? findFirstHitInContact(Contact contact, String query, {bool includeNotes = true}) {
  if (query.isEmpty) return null;

  final displayName = contact.displayName ?? '';
  var hit = _tryMatch(displayName, query);
  if (hit != null) return hit;

  final n = contact.name;
  if (n != null) {
    for (final part in [n.first, n.last, n.prefix, n.middle, n.suffix, n.nickname]) {
      final s = part ?? '';
      if (s.isEmpty) continue;
      hit = _tryMatch(s, query);
      if (hit != null) return hit;
    }
  }

  for (final p in contact.phones) {
    hit = _tryMatch(p.number, query);
    if (hit != null) return hit;
  }
  for (final e in contact.emails) {
    hit = _tryMatch(e.address, query);
    if (hit != null) return hit;
  }
  for (final a in contact.addresses) {
    final formatted = a.formatted ?? '';
    if (formatted.isEmpty) continue;
    hit = _tryMatch(formatted, query);
    if (hit != null) return hit;
  }
  for (final o in contact.organizations) {
    for (final part in [o.name, o.jobTitle, o.departmentName]) {
      final s = part ?? '';
      if (s.isEmpty) continue;
      hit = _tryMatch(s, query);
      if (hit != null) return hit;
    }
  }
  for (final w in contact.websites) {
    hit = _tryMatch(w.url, query);
    if (hit != null) return hit;
  }
  for (final s in contact.socialMedias) {
    hit = _tryMatch(s.username, query);
    if (hit != null) return hit;
  }
  if (includeNotes && contact.notes.isNotEmpty) {
    final note = contact.notes.first.note;
    hit = _tryMatchNote(note, query, includeNotes: true);
    if (hit != null) return hit;
  }

  return null;
}

/// Returns the first search hit in [card], or null.
SearchHit? findFirstHitInBusinessCard(BusinessCard card, String query, {bool includeNotes = true}) {
  if (query.isEmpty) return null;

  var hit = _tryMatch(card.cardName, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.displayFullName, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.displayOrg, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.displayTitle, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.displaySubtitle, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.primaryPhone, query);
  if (hit != null) return hit;

  hit = _tryMatch(card.primaryEmail, query);
  if (hit != null) return hit;

  return findFirstHitInContact(card.contact, query, includeNotes: includeNotes);
}
