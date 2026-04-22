# Product Requirements Document (PRD) – Contact Quick Share

**Version:** 1.0  
**Date:** March 10, 2026  
**Subtitle:** Share Contacts via QR Code  
**Platform:** Android & iOS (Flutter single codebase)  
**License:** Fully open-source under MPL 2.0 (free forever, contributions welcome)

### 1\. Overview & Vision

Contact Quick Share is a lightweight, offline-first mobile app that lets users instantly generate and share contact information via beautiful, customizable QR codes (vCard 3.0 format for broader support). It combines instant access to device contacts with user-created “business cards” (pre-made editable templates stored locally).

The experience is deliberately “one- or two-tap fast” — ideal for networking events, business cards, conferences, or everyday use. No accounts, no cloud, no internet required for core functionality. Inspired by QRcard but expanded with full device-contact integration and automatic updates for linked cards.

**Core Value Proposition**  
“Open app → tap card or contact → show QR in <3 seconds.”

### 2\. Business & Product Goals

- Deliver the fastest and simplest contact-sharing experience on mobile.
- Target business professionals while remaining fun and accessible to everyone (artists, families, students).
- Remain 100 % offline and privacy-first (read-only contacts, local on-device storage).
- Be fully open-source (MPL 2.0) to encourage community contributions.
- Achieve high App Store / Play Store ratings through polish, speed, and zero ads.

### 3\. User Personas

- **Alex (Primary)** – 35, sales professional – needs one-tap business-card QR at events.
- **Sam (Secondary)** – 28, freelancer/artist – wants colorful QR with logo for creative branding.
- **Maria** – 45, parent – shares family contact quickly with schools or friends.
- **Tech-savvy user** – values open-source, privacy, and full vCard support.

### 4\. Functional Requirements

#### 4.1 Main Screen

- Top section: Horizontal or vertical scroll of Business Card tiles (name, title, optional photo/color preview).
- Below: Alphabetical device contact list (A–Z sections), lazy-loaded.
- Sorting & display configurable (First/Last name, asc/desc).
- Top search bar filters both sections.
- Floating Action Button: “New Business Card”.
- Optional: Auto-open a chosen business card’s QR on app launch.

#### 4.2 Business Cards

- Create: Manual entry or “Link to device contact” (one-way sync toggle).
- Edit flow: Tap card → full-screen QR → **tap anywhere** to open the action menu (share, view data as text, edit), or **swipe right-to-left** to go straight to edit → adjust fields/toggles/appearance → save → return to QR view.
- Per-card customization: Background color/text color, display photo/logo (not in QR), separate QR center logo.
- Linked cards: Auto-refresh from device contact on open/generate (user can disable if they edit manually).
- Full management: reorder, delete, duplicate.

#### 4.3 Device Contact Sharing

- Tap contact → field-selection screen (toggles for every vCard field).
- Pre-configurable default fields in Settings.
- One-tap “Validate” → QR generated with default appearance settings.

#### 4.4 QR Code Generation

- Always vCard 3.0.
- Powered by pretty\_qr\_code 3.6.0 (latest 2026).
- Full customization: colors, gradients, eye shapes, center logo/image, quiet zone.
- Full-screen display with share/save image.

#### 4.4.1 Full-screen QR screen gestures

The full-screen QR display (business cards and device contact share) uses:

- **Tap anywhere** on the QR view – Opens an action menu with:
  - Share as image
  - Share as vCard
  - View QR / vCard data as text
  - Edit (business card editor or contact field selection)
- **Swipe right-to-left** – Enter edit mode directly (same destinations as **Edit** in the menu).
- **Swipe left-to-right** – Close the business card detail or dismiss the QR view per navigation stack.

There is **no** separate long-press gesture on the QR code; viewing raw data and editing are reached from the menu or via swipe-to-edit.

#### 4.5 Scanning (Nice-to-have / Phase 1.1)

- Bottom navigation icon.
- Planned implementation: mobile\_scanner 7.2.0 (would add camera permission when this ships).
- Parse vCard → show details or save as new device contact.

#### 4.6 Settings

- Contact list sort/display preferences.
- Default share fields.
- Default QR appearance (applied to quick shares).
- Auto-open business card on launch.
- Theme (system/light/dark).
- Export/Import (all cards + settings).
- About & open-source license.

### 5\. Non-Functional Requirements

- Performance: < 1 s to show first QR on cold start (target).
- Offline-first, zero analytics or tracking.
- Business card data stored locally using sqflite (SQLite on device).
- Permissions: Contacts (read-only) for the current product scope. Camera is not requested until QR scanning (Phase 1.1) is implemented.
- Internationalization: Support multiple name formats and languages.
- Accessibility: High contrast, large tap targets, screen-reader friendly.
- Security: No write access to device contacts; local storage only.

### 6\. Technical Stack (Locked for MVP)

- Framework: Flutter (latest stable 2026)
- Contacts: flutter\_contacts ^2.0.0 (full vCard 3.0 export/import, real-time listeners, all fields)
- QR Generation: pretty\_qr\_code ^3.6.0
- Scanning (Phase 1.1, not in current builds): mobile\_scanner ^7.2.0 — adds camera permission when shipped
- Storage: sqflite (local SQLite)
- State Management: Riverpod (flutter_riverpod)
- Sharing: share\_plus
- Architecture: MVVM (Model-View-ViewModel) with separated layers
- License: MPL 2.0

**Architecture style**  
MVVM (Model-View-ViewModel) with Riverpod for state management.  
Folder structure follows **feature-first** organization:

- `core/` for shared utilities, themes, global widgets
- `features/<feature_name>/` with subfolders:
    - `models/` – plain data classes
    - `repositories/` – data access
    - `providers/` – ViewModels (Riverpod notifiers/providers)
    - `screens/` – UI screens (Views)
    - `widgets/` – feature-specific reusable widgets

### 7\. User Stories & Flows (High-Level)

- As a user I want to open the app and immediately see my most-used business card QR (auto-open).
- As a user I want to tap any contact and share only selected fields in <5 seconds.
- As a user I want my linked business card to stay up-to-date when the device contact changes.
- As a user I want beautiful, branded QR codes with my logo and colors.

### 8\. Scope

**MVP (v1.0 – 4–6 weeks solo dev)**

- Main screen + search
- Business cards (manual + linked)
- Device contact field selection
- QR generation & customization
- Local SQLite storage for business cards
- Settings (sort, defaults, auto-open, theme)
- Export/Import

**Phase 1.1 (2 weeks)**

- Scanning + import
- Full QR appearance defaults
- Polish & testing

Future (post v1): Cloud backup option (opt-in), widget, Apple Watch support, etc.

### 9\. Assumptions & Dependencies

- Device contacts permission granted.
- Flutter 3.24+ and latest packages (verified March 2026).
- App name “Contact Quick Share” is available on both stores (confirmed March 2026).
