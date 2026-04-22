# Architecture – Contact Quick Share

## Core decisions

- MVVM (Model–View–ViewModel) using  (flutter_riverpod)
- Feature-first folder structure (see folder tree in README or below)
- No BLoC, no Provider (legacy), no GetX, no setState in business logic

## Folder responsibilities

- models/        → pure data classes (often with fromJson/toJson)
- repositories/  → data sources, abstract away sqflite / flutter_contacts
- providers/     → ViewModels = Notifier / AsyncNotifier / StateProvider
- screens/       → page-level widgets (usually ConsumerWidget)
- widgets/       → smaller reusable pieces

## Important rules

- Keep providers feature-scoped whenever possible
- Use ref.watch / ref.read correctly
- Prefer functional widgets + riverpod_generator annotations
- Business logic belongs in notifiers / repositories — never in widgets
- UI is stupid: it only displays state and sends events

Full folder example:
features/business_cards/
├── models/
├── repositories/
├── providers/
├── screens/
└── widgets/

More complete example:
contact_quick_share/
├── android/
├── ios/
├── lib/
│   ├── core/                           # everything truly global / shared across features
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_constants.dart
│   │   │   └── strings.dart
│   │   ├── di/                         # global providers / overrides if needed
│   │   │   └── app_providers.dart
│   │   ├── error/
│   │   │   └── failures.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   └── theme_extensions.dart
│   │   ├── utils/
│   │   │   ├── date_utils.dart
│   │   │   ├── extensions.dart
│   │   │   └── validators.dart
│   │   └── widgets/                    # reusable cross-feature widgets
│   │       ├── app_button.dart
│   │       ├── app_card.dart
│   │       ├── loading_indicator.dart
│   │       └── qr_placeholder.dart     # example
│   │
│   ├── features/                       # ← main division: one folder per major feature / screen group
│   │   ├── business_cards/
│   │   │   ├── models/                 # plain data classes (often with fromJson/toJson)
│   │   │   │   └── business_card.dart
│   │   │   ├── repositories/           # data access (db, flutter_contacts wrapper if linked)
│   │   │   │   └── business_card_repository.dart
│   │   │   ├── providers/              # ← ViewModels = Riverpod notifiers / providers
│   │   │   │   ├── business_cards_list_notifier.dart
│   │   │   │   ├── business_card_detail_notifier.dart
│   │   │   │   └── business_card_sync_provider.dart   # optional
│   │   │   ├── screens/                # ← Views
│   │   │   │   ├── business_cards_screen.dart          # list of all cards
│   │   │   │   └── business_card_detail_screen.dart    # QR view; tap → menu, swipe RTL → edit
│   │   │   └── widgets/
│   │   │       ├── business_card_tile.dart
│   │   │       ├── business_card_data_tab.dart
│   │   │       └── business_card_appearance_tab.dart
│   │   │
│   │   ├── contacts/
│   │   │   ├── models/
│   │   │   │   └── contact_selection.dart   # if needed for field toggles
│   │   │   ├── repositories/
│   │   │   │   └── device_contact_repository.dart
│   │   │   ├── providers/
│   │   │   │   └── contacts_list_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── contact_field_selection_screen.dart   # or bottom sheet
│   │   │   └── widgets/
│   │   │       └── contact_list_tile.dart
│   │   │
│   │   ├── qr_code/                    # shared QR generation & appearance logic
│   │   │   ├── models/
│   │   │   │   └── qr_appearance.dart
│   │   │   ├── providers/
│   │   │   │   └── qr_appearance_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── qr_fullscreen_page.dart
│   │   │   └── widgets/
│   │   │       └── customizable_qr_widget.dart
│   │   │
│   │   └── settings/
│   │       ├── providers/
│   │       │   └── settings_notifier.dart
│   │       ├── screens/
│   │       │   └── settings_screen.dart
│   │       └── widgets/
│   │           └── settings_section.dart   # reusable card-like sections
│   │
│   ├── app.dart                        # root widget (MaterialApp / theme / routing)
│   ├── bootstrap.dart                  # optional: app-wide init hook
│   ├── main.dart                       # entry point
│   └── routing/                        # optional – can be added later
│       └── app_router.dart
│
├── test/
│   ├── features/
│   │   ├── business_cards/
│   │   │   └── business_cards_test.dart
│   │   └── ...
│   ├── core/
│   └── widget_test.dart
│
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
└── README.md
