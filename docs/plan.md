# Development Plan

### 1\. Architecture Overview

- **Layers**  
– Data: Repository pattern (flutter\_contacts + sqflite)  
– Domain: Models (BusinessCard, ContactCard, VCard)  
– Presentation: Riverpod providers + MVVM widgets
- Clean folder structure (feature-based).
- No over-engineering — simple, readable code.

**Architecture Overview**

- MVVM pattern using Riverpod (StateNotifier / Notifier / AsyncNotifier as ViewModels)
- Feature-first folder structure: each major screen/flow lives in its own `features/` subfolder
- Inside each feature:  
• models/ → pure data classes  
• repositories/ → data sources & business logic abstraction  
• providers/ → ViewModels (state + logic exposed to UI)  
• screens/ → UI entry points (ConsumerWidget / HookConsumerWidget)  
• widgets/ → smaller composable UI pieces
- Global shared code lives in `core/` (themes, utils, constants, reusable widgets)
- Goal: high locality, easy testing, clear separation of concerns, simple refactoring

### 2\. Full Tech Stack

- Flutter + Dart
- flutter\_contacts ^2.0.0
- pretty\_qr\_code ^3.6.0
- sqflite
- flutter\_riverpod, share\_plus
- Testing: flutter\_test + integration\_test

### 3\. Phases & Estimated Timeline (Solo Developer)

**Week 1** – Setup & Foundation

- [x] Project init, permissions, Riverpod setup
- [x] Contact list screen + search + alphabetical sections (flutter\_contacts)
- [x] SQLite setup (local `cards.db`)

**Week 2** – Business Cards Core

- [x] Business card CRUD + linked mode + sync toggle
- [ ] QR ↔ edit transitions + field edit with appearance config (AnimatedSwitcher / polish)

**Week 3** – QR & Sharing

- [x] pretty\_qr\_code integration (all customizations)
- [x] Device contact field selection → QR
- [x] QR screen + share/save

**Week 4** – Settings, Polish & Export

- [x] All settings screens
- [ ] Export/Import JSON handling
- [ ] Theme, auto-open, internationalization

**Week 5** – Nice-to-haves & Testing

- [ ] Full device testing (Android + iOS)
- [ ] Performance & edge-case testing (large contact lists)

**Week 6** – Release Preparation

- [ ] App icon, screenshots, store listings
- [ ] Open-source repo setup (GitHub, MPL 2.0)
- [ ] Beta testing & bug fixes

Total MVP: 4–6 weeks realistic for experienced Flutter developer.

### 4\. Milestones & Deliverables

- [x] M1 (End Week 1): Working contact list + local DB
- [x] M2 (End Week 3): Full QR sharing from cards and contacts
- [ ] M3 (End Week 5): Complete MVP + testing
- [ ] M4: Public GitHub repo + first store submission

### 5\. Testing Strategy

- [ ] Unit tests: Models & repositories (80 % coverage)
- [ ] Widget tests: Key screens & QR ↔ edit transitions
- [ ] Integration tests: Full share flow + scanning
- [ ] Manual: Multiple devices (Android 10–16, iOS 16–19), large contact lists, offline mode

### 6\. Deployment & Release

- [ ] GitHub repo (open-source from day 1)
- [ ] Google Play & Apple App Store (free) & F-Droid & Others???
- [ ] CI/CD: GitHub Actions (build, test, deploy)
- [ ] Versioning: Semantic (1.0.0)

### 7\. Risks & Mitigations

- Permission changes on new OS versions → Monitor flutter\_contacts issues
- QR scannability with many fields → Limit displayed fields + test with real scanners
- App or OS data loss on device reset → Rely on export/import workflow
- App name conflict → Already verified available; fallback “QuickContact QR” ready

This PRD and Development Plan are complete, self-contained, and ready for implementation. You can copy-paste directly into your project docs or Notion.

Next recommend steps:

- [ ] Create the GitHub repo and init the Flutter project (I can give you the exact `flutter create` + package commands).
- [ ] Approve wireframes (I can generate simple text-based or describe them).
- [ ] Start Week 1 coding.

Would you like me to generate the initial GitHub README, the exact pubspec.yaml, or the first set of wireframe descriptions next? Just say the word!
