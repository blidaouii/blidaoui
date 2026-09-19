# Android release architecture

This repository currently contains the Flutter/Dart layer and intentionally does not include generated Android build output or signing secrets. For release:

- Set `version` and build number in `pubspec.yaml`.
- Configure a private upload keystore through CI secrets; never commit it.
- Use Play App Signing and produce APK/AAB only in a Flutter-enabled CI runner.
- Keep `google-services.json`, keystores, and service-account keys out of Git.
- Use the official Play Store update channel for production updates.
- The `UpdateService` contract accepts an official signed manifest but does not download or silently install APKs.

`assets/icon/ludo_dz_icon.png` is the required branded source artwork. Replace the placeholder README with the final image before release.
