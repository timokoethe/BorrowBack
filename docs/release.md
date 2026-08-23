# Releases

BorrowBack releases are triggered by Git tags. A release tag is consumed
independently by GitHub Actions and Xcode Cloud:

- GitHub Actions creates the GitHub Release and its generated release notes.
- Xcode Cloud builds the native app using its own tag-based start condition.

Neither process starts or waits for the other. A GitHub Release may therefore
exist before the corresponding Xcode Cloud build has finished.

## Release Tags

Stable releases use semantic version tags:

```text
v1.1.0
```

Beta releases append a positive beta number:

```text
v1.1.0-beta1
```

Tags must match one of these formats exactly:

```text
vMAJOR.MINOR.PATCH
vMAJOR.MINOR.PATCH-betaN
```

Other suffixes, a missing `v`, or beta number `0` are not supported. The GitHub
workflow currently accepts `beta0`, but the Xcode Cloud pre-build script rejects
it, so it is not a valid BorrowBack release tag.

## Before Tagging

Before creating a release tag:

1. Confirm that the intended release commit is on `main` and has been pushed,
   unless the release deliberately targets another branch.
2. Manually verify the native app on an appropriate iPhone or simulator.
3. Confirm that the matching documents in [`docs/features/`](features/) describe
   the implemented behavior.
4. Check that pull requests have accurate labels so generated release notes are
   categorized correctly.
5. For website-only pull requests, confirm that the `website` label is present
   so they are excluded from native app release notes.
6. Confirm that Xcode Cloud has an active workflow with a tag-based start
   condition for the release tag.

The version stored in the Xcode project does not need to be edited before
tagging. Xcode Cloud derives release version values from the tag during its
pre-build step.

## Creating a Release

Create an annotated tag for the exact commit to release, then push it:

```sh
git tag -a v1.1.0 -m "Version v1.1.0"
git push origin v1.1.0
```

For a beta release:

```sh
git tag -a v1.1.0-beta1 -m "Version v1.1.0-beta1"
git push origin v1.1.0-beta1
```

Pushing the tag is the release trigger. Verify the tag and target commit carefully before pushing it.

## GitHub Release

The [GitHub release workflow](../.github/workflows/release.yml) validates the tag
and creates a GitHub Release. It does not build, sign, notarize, or upload the
app and does not call App Store Connect.

Stable releases:

- are published as regular GitHub Releases;
- receive a `Version X.Y.Z` heading;
- compare against the previous stable `vX.Y.Z` tag;
- ignore intermediate beta tags when selecting that comparison point.

Beta releases:

- are marked as GitHub prereleases;
- receive a dynamic `Beta N - Early Preview` heading and preview notice;
- compare against the previous release tag, including previous beta tags.

Generated notes are grouped using the [release notes
configuration](../.github/release.yml). Pull requests labeled
`ignore-for-release` or `website` are excluded.

The GitHub Release is changelog metadata. Its successful creation does not mean that the Xcode Cloud build also succeeded.

## Xcode Cloud Build

Xcode Cloud is expected to start independently from the same pushed tag. The
[pre-build script](../ci_scripts/ci_pre_xcodebuild.sh) derives the app version as
follows:

- `MARKETING_VERSION` is the semantic version without the leading `v` or beta suffix. Both `v1.1.0` and `v1.1.0-beta1` therefore use marketing version `1.1.0`.
- `CURRENT_PROJECT_VERSION` is the positive Xcode Cloud `CI_BUILD_NUMBER`.
- If `CI_BUILD_NUMBER` is unavailable, the script falls back to build number `1`.

Build numbers are not derived from the semantic version or beta counter. For example, `v1.1.0-beta3` does not imply build number `3`.

The first Xcode Cloud release build in this repository is expected to become build `1`.

## Verification After Tagging

After pushing the tag, verify both consumers separately:

1. Confirm that the GitHub Actions release workflow completed successfully.
2. Open the generated GitHub Release and check its title, prerelease status, comparison range, categories, and notes.
3. Confirm that Xcode Cloud started a build for the same tag.
4. Check that Xcode Cloud used the expected marketing version and build number.
5. Verify the Xcode Cloud build result and any later distribution step configured there.

The GitHub Release can be complete while the Xcode Cloud build is still running or has failed. Treat these as separate outcomes.

## Failure Handling

If the GitHub workflow fails because the tag format is invalid, do not create a second tag until the incorrect tag and its scope have been reviewed. Tags may already have been fetched by other systems or developers.

If generated release notes are incomplete or incorrectly categorized, check the labels on the included pull requests and the configuration in `.github/release.yml`.

If Xcode Cloud does not start, verify its tag-based start condition and confirm that it recognizes the pushed tag. The GitHub Actions workflow does not trigger Xcode Cloud.

If the Xcode Cloud build fails, investigate and retry it in Xcode Cloud as appropriate. The existing GitHub Release may remain published because it represents release metadata rather than a successful native build.

Do not move or replace a published release tag casually. Prefer a new version tag when artifacts or external systems may already refer to the original tag.