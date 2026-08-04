#!/bin/sh
set -eu

# Xcode Cloud runs this script from the repository root, while the fallback
# keeps local/manual execution independent of the current working directory.
REPO_ROOT="${CI_PRIMARY_REPOSITORY_PATH:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}"
cd "$REPO_ROOT"

FLUTTER_VERSION="3.24.1"
FLUTTER_DIR="$HOME/flutter-$FLUTTER_VERSION"

# Xcode Cloud does not provide Flutter by default. Reuse an existing checkout
# when available, but always build with the version used to create the lockfile.
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  git clone --branch "$FLUTTER_VERSION" --depth 1 \
    https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

flutter precache --ios
flutter pub get

cd ios
pod install
