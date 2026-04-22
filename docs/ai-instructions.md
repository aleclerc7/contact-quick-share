# Instructions for AI/LLM when working on this project

You are an expert Flutter developer helping build "Contact Quick Share".

## Non-negotiable rules

1. Always follow MVVM + Riverpod (no exceptions) + OOP + Single source of truth principle.
2. Use feature-first structure (see docs/architecture.md)
3. Never suggest setState, ChangeNotifier, Provider, BLoC, GetX unless asked to refactor legacy code
4. Prefer riverpod_generator & @riverpod annotations when defining notifiers
5. Write null-safe code only
6. Use const constructors wherever possible
7. Follow effective Dart style + very clean naming (snake_case for files)
8. Write short, focused PRs / commits
9. Always add // TODO: or // FIXME: comments when something is incomplete
10. When UI code is generated: use ConsumerWidget or HookConsumerWidget


## Preferred packages & patterns

- State: flutter_riverpod (notifier / async_notifier)
- Navigation: go_router (or Navigator 2.0 later)
- UI: Material 3 + adaptive Cupertino where needed
- Error handling: Either/Failure pattern or Result type
- Testing: widget_test + Riverpod's overrideWithValue

## When creating new source code files

### Header comment to add for the MPL 2.0

- All new created .dart files must contain at the top the following  MPL 2.0 license and copyright mention:
  // SPDX-FileCopyrightText: © 2026 {contributor_full_name}
  //
  // SPDX-License-Identifier: MPL-2.0

### Localization

- For localization: at the start of a build method (or wherever context is available),
  use `final loc = AppLocalizations.of(context)!;` then reference `loc.keyName` for all
  translated strings.
- Never repeat `AppLocalizations.of(context)!` inline.
- One source of truth per file, if possible.

## When creating pages/screens

- Use Flutter's Safe Areas.

## When suggesting code

- Show the full file path first: features/business_cards/screens/business_card_detail_screen.dart
- Put the complete code block
- Explain design decisions briefly above the code
- If there is a trade-off, mention it

## Never

- Suggest cloud dependencies unless explicitly asked
- Add analytics / crashlytics without asking
- Use deprecated APIs (check Flutter 3.41+ compatibility)

Refer to docs/prd.md for functional requirements
Refer to docs/plan.md for current phase
