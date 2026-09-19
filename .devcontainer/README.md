# Ludo DZ Codespaces development

The repository includes a Codespaces container with:

- Flutter `3.29.3`, pinned from the stable channel.
- Dart bundled with that Flutter SDK.
- OpenJDK 17.
- Android command-line tools.
- Android platform tools.
- Android API 35 platform.
- Android build tools 35.0.0.
- Flutter and Dart VS Code extensions.

## Create a Codespace

Open the repository in GitHub Codespaces and allow the `.devcontainer` image to build. The post-create hook runs `flutter pub get`.

## Validate the environment

Inside the Codespace, run these commands individually:

```bash
flutter --version
dart --version
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
```

Build outputs are intentionally ignored by Git. Android signing credentials, keystores, Firebase credentials, and service-account keys must be supplied through a secure CI/Codespaces secret mechanism and must never be committed.

The container installs SDK tooling only; it does not create signing keys or claim a release build has succeeded.
