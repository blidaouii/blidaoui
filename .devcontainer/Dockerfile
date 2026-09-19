FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

ARG FLUTTER_CHANNEL=stable
ARG FLUTTER_VERSION=3.29.3

ENV DEBIAN_FRONTEND=noninteractive \
    ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    FLUTTER_ROOT=/opt/flutter \
    JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64 \
    PUB_CACHE=/home/vscode/.pub-cache

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       file \
       git \
       libglu1-mesa \
       openjdk-17-jdk \
       unzip \
       wget \
       xz-utils \
       zip \
    && rm -rf /var/lib/apt/lists/*

# Android command-line tools and SDK components required by Flutter's Android toolchain.
RUN mkdir -p "${ANDROID_SDK_ROOT}/cmdline-tools" \
    && curl -fsSL -o /tmp/commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && unzip -q /tmp/commandlinetools.zip -d "${ANDROID_SDK_ROOT}/cmdline-tools" \
    && mv "${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools" "${ANDROID_SDK_ROOT}/cmdline-tools/latest" \
    && rm /tmp/commandlinetools.zip \
    && yes | "${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager" --licenses >/dev/null || true \
    && "${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager" \
       "platform-tools" \
       "platforms;android-35" \
       "build-tools;35.0.0" \
    && chown -R vscode:vscode "${ANDROID_SDK_ROOT}"

# Pin the SDK to a reproducible stable release while retaining the stable channel.
RUN git clone --depth 1 --branch "${FLUTTER_CHANNEL}" https://github.com/flutter/flutter.git "${FLUTTER_ROOT}" \
    && cd "${FLUTTER_ROOT}" \
    && git fetch --depth 1 origin "${FLUTTER_VERSION}" \
    && git checkout "${FLUTTER_VERSION}" \
    && chown -R vscode:vscode "${FLUTTER_ROOT}"

ENV PATH="${FLUTTER_ROOT}/bin:${FLUTTER_ROOT}/bin/cache/dart-sdk/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${PATH}"

USER vscode
RUN flutter config --no-analytics \
    && flutter config --android-sdk "${ANDROID_SDK_ROOT}" \
    && dart --disable-analytics \
    && flutter precache --android

WORKDIR /workspaces/${localWorkspaceFolderBasename}
