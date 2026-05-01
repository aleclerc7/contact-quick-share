# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [1.1.0] — 2026-04-30

Business-card workflow (create, duplicate, delete) and fixes for QR/detail presentation and layout.

### Added

- **Create card from contact** — Start a business card from an existing device contact.
- **Duplicate card** — Duplicate a contact card from the card’s context menu.
- **Delete card** — Delete a contact card from the same menu, with a confirmation prompt (aligned with the edit flow).

### Fixed

- **PNG transparency** — Transparent areas in exported PNGs no longer show an unintended blurred background.
- **QR “more details”** — The details section no longer repeats phone and email (or other fields) already shown in the primary summary; only additional fields appear.
- **Field selector layout** — Bottom safe area and padding so the last toggles are not covered by action buttons when the share button is hidden (e.g. in edit mode).


## [1.0.1] — 2026-03-31

Improved contact information display in specific cases; initial public release of the source code.

### Fixed

- **Duplicate contact data** — Fixed possible duplicate contact information to be shared.


## 1.0.0 — 2026-03-30

Internal limited beta only; no public Git tag or source tree for this version.

### Added

- **QR sharing** — Generate QR codes from device contacts or custom business cards; share contact data quickly (vCard 3.0).
- **QR appearance** — Customize codes (colors, logos, eye shapes, gradients, and related options).
- **Business cards** — Create cards, optionally link to contacts with auto-sync, reorder, edit from the QR screen (menu and swipe gestures).
- **Privacy-first design** — No accounts, no cloud, and no internet required for core functionality; no ads or in-app analytics in this release.
- **Local data** — Local SQLite storage for business cards and preferences on device.
- **Theming** — Light, dark, and system appearance.
- **Internationalization** — UI available in German, English, Spanish, French, Italian, Dutch, Polish, and Portuguese.
- **Data portability** — Export and import business cards and settings.
- **Settings** — Defaults for QR appearance and share fields, plus app preferences (e.g. locale).

### Security

- Contact data and app data stored locally on device; no write access to the system address book (see project documentation for details).

[Unreleased]: https://github.com/aleclerc/contact-quick-share/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/aleclerc/contact-quick-share/releases/tag/v1.1.0
[1.0.1]: https://github.com/aleclerc/contact-quick-share/releases/tag/v1.0.1
