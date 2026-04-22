# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2026-03-31

### Fixed

- **Duplicate contact data** — Fixed possible duplicate contact information to be shared.

## [1.0.0] - 2026-03-30

Initial limited beta release of Contact Quick Share.

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

[Unreleased]: https://github.com/aleclerc/contact-quick-share/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/aleclerc/contact-quick-share/releases/tag/v1.0.0
