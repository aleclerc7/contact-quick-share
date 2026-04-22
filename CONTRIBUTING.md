# Contributing to Contact Quick Share

Thanks for your interest in contributing. This project is open source under the [Mozilla Public License 2.0](LICENSE).

## Where to start

- Read [docs/architecture.md](docs/architecture.md) for MVVM, feature-first layout, and folder responsibilities.
- Read [docs/ai-instructions.md](docs/ai-instructions.md) for coding rules (Riverpod, localization, file headers, etc.).

## Development setup

1. Install [Flutter](https://flutter.dev) (see `pubspec.yaml` for the Dart SDK constraint).
2. Clone the repository and run:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
4. Run tests:
   ```bash
   flutter test
   ```

## Code style

- **MVVM + Riverpod** — Use `Notifier` / `AsyncNotifier` and `ConsumerWidget` / `HookConsumerWidget`. Do not add `setState` or `ChangeNotifier` for new features.
- **Feature-first structure** — `features/<feature>/{models,repositories,providers,screens,widgets}` plus shared code under `lib/core/`.
- **Prefer** `riverpod_generator` and `@riverpod` where it fits the codebase.
- **Localization** — Use `AppLocalizations`; assign `final loc = AppLocalizations.of(context)!;` once per build where possible.
- **New Dart files** — Include the MPL 2.0 SPDX header at the top (see [docs/ai-instructions.md](docs/ai-instructions.md)).

## Pull requests

- Keep PRs focused and reasonably small.
- Describe what changed and why.
- Run `flutter analyze` and `flutter test` before submitting when possible.

## What we avoid (unless explicitly requested)

- Cloud-only dependencies, analytics, or crash reporting without discussion.
- Deprecated APIs; target current Flutter/Dart stable.

Questions are welcome via issues on the repository.
