#!/bin/sh
set -eu

cd "$CI_PRIMARY_REPOSITORY_PATH"

if [ -z "${CI_TAG:-}" ]; then
  echo "No CI_TAG set; keeping project version settings unchanged."
  exit 0
fi

if ! expr "$CI_TAG" : '^v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null &&
   ! expr "$CI_TAG" : '^v[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*-beta[1-9][0-9]*$' >/dev/null; then
  echo "Tag '$CI_TAG' does not match expected format vMAJOR.MINOR.PATCH or vMAJOR.MINOR.PATCH-betaN."
  exit 1
fi

TAG_VERSION="${CI_TAG#v}"
VERSION_CORE="${TAG_VERSION%%-*}"

if [ -n "${CI_BUILD_NUMBER:-}" ]; then
  if ! expr "$CI_BUILD_NUMBER" : '^[1-9][0-9]*$' >/dev/null; then
    echo "CI_BUILD_NUMBER '$CI_BUILD_NUMBER' is not a positive integer."
    exit 1
  fi

  BUILD_NUMBER="$CI_BUILD_NUMBER"
else
  BUILD_NUMBER="1"
fi

echo "Setting marketing version to $VERSION_CORE from tag $CI_TAG."
echo "Setting build number to $BUILD_NUMBER from Xcode Cloud build number ${CI_BUILD_NUMBER:-unset}."

PROJECT_FILE="app/apple/BorrowBack.xcodeproj/project.pbxproj"

if [ ! -f "$PROJECT_FILE" ]; then
  echo "Cannot find $PROJECT_FILE."
  exit 1
fi

VERSION_CORE="$VERSION_CORE" BUILD_NUMBER="$BUILD_NUMBER" perl -0pi -e '
  s/(MARKETING_VERSION = )[^;]+;/${1}$ENV{VERSION_CORE};/g;
  s/(CURRENT_PROJECT_VERSION = )[^;]+;/${1}$ENV{BUILD_NUMBER};/g;
' "$PROJECT_FILE"
