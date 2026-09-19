# Ludo DZ

Ludo DZ is a clean, testable Flutter foundation for a premium Algerian-inspired Ludo game.

## Current foundation

- Feature-oriented architecture separating rules, presentation, services, and models.
- Deterministic local Ludo engine supporting 2–4 players, six-to-exit, captures, safe cells, exact finish, extra turns, and win detection.
- Responsive game board UI with selectable legal tokens and accessible controls.
- Local game setup for human and bot players.
- Arabic, French, and English localization foundation.
- Bot strategy boundary ready for easy, medium, and hard implementations.
- Backend-ready service interfaces for authentication, rooms, presence, and server-authoritative commands.
- Test coverage for core rules and invalid actions.

## Run locally

This repository contains the Flutter source and configuration. With Flutter installed:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

For Android release builds:

```bash
flutter build apk --release
```

## Configuration and security

Firebase adapters should be implemented behind the interfaces in `lib/services/`; never ship service-account keys or private credentials in the app. Production dice and move validation must be performed by a trusted backend/Cloud Functions layer.

`assets/icon/ludo_dz_icon.png` is the required source artwork for launcher icon generation. Replace the placeholder file with the final branded artwork before release. Do not commit build output, `.dart_tool`, secrets, or generated credentials.

## Roadmap

The current branch establishes the playable local foundation. Next milestones are Firebase adapters, server-authoritative room commands, presence/reconnection, social/progression repositories, sound assets, and signed Android release configuration.
