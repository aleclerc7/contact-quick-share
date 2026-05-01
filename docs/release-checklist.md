# Release checklist — Contact Quick Share

Use this list for every store build or tagged release. **Version source of truth:** `pubspec.yaml` (`MAJOR.MINOR.PATCH+BUILD`). Android and iOS pick it up via Flutter tooling (no manual `Info.plist` / Gradle version edits for normal releases).

## 1. Quality gate

- [ ] `flutter analyze` (no new issues you intend to ship with)
- [ ] Tests you rely on: `flutter test`
- [ ] Quick smoke on a device or emulator (create card, QR, share path you care about)

## 2. Version and changelog

- [ ] Bump `pubspec.yaml` `version:` (semver for `PATCH`/`MINOR`/`MAJOR`; increment `+BUILD` for every Play upload requirement)
- [ ] Add a dated section to [`CHANGELOG.md`](../CHANGELOG.md) for the new version (Keep a Changelog style)
- [ ] Update changelog footer compare links: `[Unreleased]` → `compare/vLAST_TAG...HEAD`; add `[X.Y.Z]:` link to `releases/tag/vX.Y.Z`

## 3. Store and marketing text

- [ ] Update [`docs/release_notes.txt`](release_notes.txt) for **each** locale you ship (`<en-US>`, `<de-DE>`, …) — short “what’s new” for Play / App Store
- [ ] Optional: refresh [`README.md`](../README.md) feature bullets if the public story changed
- [ ] Optional: bump **Version** in [`docs/prd.md`](prd.md) if you track product doc version there

## 4. Builds

- [ ] **Clean before store builds:** run `flutter clean`, then `flutter pub get`. This is worth doing on **both Android and iOS** (including from Windows for Android) so stale outputs under `build/` are not mixed into a release. **iOS:** if you recently ran on the **simulator**, skipping a clean before archiving can leave **simulator-marked** native frameworks in a device/IPA bundle and cause **App Store validation** to fail (known issue on some Flutter versions with **native assets**, e.g. `sqlite3.framework` from the dependency graph).
- [ ] Android: `flutter build appbundle --release & flutter build apk --release`
- [ ] iOS: `flutter build ipa --release`

## 5. After upload

- [ ] Git tag: `vX.Y.Z` (match `CHANGELOG` / release)
- [ ] GitHub Release: paste notes from `CHANGELOG` or `docs/release_notes.txt`
- [ ] Play Console / App Store Connect: paste per-locale notes; attach new screenshots only if UI materially changed ([`design/google-play/`](../design/google-play))

## What usually does **not** change on a normal release

- SQLite `version` in app database code — only when you ship a **schema** migration
- Backup `backupVersion` — only when export/import format changes

## AI / automation hint

When asking an agent for “a release” or “version bump”, say: follow **`docs/release-checklist.md`**.
