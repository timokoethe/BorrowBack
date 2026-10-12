# Releases

BorrowBack releases are triggered by Git tags. A release tag is consumed by
three processes:

- GitHub Actions creates the GitHub Release and its generated release notes.
- GitHub Actions then deploys the website in [`website/`](../website/) to Vercel.
- Xcode Cloud builds the native app using its own tag-based start condition.

The website deployment runs in the same workflow as the GitHub Release and
starts only after the release was created. Xcode Cloud runs independently and
neither starts nor waits for the GitHub Actions workflow. A GitHub Release may
therefore exist before the corresponding Xcode Cloud build has finished.

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
release workflow and the Xcode Cloud pre-build script validate the tag
independently and reject the same set of invalid tags.
The pre-build script validates the complete tag before deriving version values
or changing the project. Incomplete suffixes such as `v1.0.0-` and
`v1.0.0-beta` are rejected as well.

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
7. Confirm that the `Preview` and `Production` GitHub environments exist and
   that both hold the `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID`
   secrets. The website job fails immediately if any of them is missing.

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

The GitHub Release is changelog metadata. Its successful creation does not mean that the website deployment or the Xcode Cloud build also succeeded.

## Website Deployment

After the GitHub Release was created, the same workflow deploys the website in
[`website/`](../website/) to Vercel. The target depends on the tag type:

| Tag | GitHub environment | Vercel deployment |
| --- | --- | --- |
| `vX.Y.Z` | `Production` | production (`--prod`) |
| `vX.Y.Z-betaN` | `Preview` | preview |

The job reads `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID` from the
selected environment and aborts before deploying if one of them is empty. Each
deployment is tagged with the `releaseTag` metadata field so it can be traced
back to the Git tag.

The Vercel project's root directory must point at `website/`, because the
workflow runs the Vercel CLI from the repository root. Runtime environment
variables for the site are configured in Vercel, not in this workflow.

Beta tags deploy to a preview URL and never touch the production domain.

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

After pushing the tag, verify each consumer separately:

1. Confirm that the GitHub Actions release workflow completed successfully.
2. Open the generated GitHub Release and check its title, prerelease status, comparison range, categories, and notes.
3. Confirm that the website job deployed to the expected target and open the resulting deployment.
4. Confirm that Xcode Cloud started a build for the same tag.
5. Check that Xcode Cloud used the expected marketing version and build number.
6. Verify the Xcode Cloud build result and any later distribution step configured there.

The GitHub Release can be complete while the website deployment or the Xcode Cloud build is still running or has failed. Treat these as separate outcomes.

## Failure Handling

If the GitHub workflow fails because the tag format is invalid, do not create a second tag until the incorrect tag and its scope have been reviewed. Tags may already have been fetched by other systems or developers.

If generated release notes are incomplete or incorrectly categorized, check the labels on the included pull requests and the configuration in `.github/release.yml`.

If Xcode Cloud does not start, verify its tag-based start condition and confirm that it recognizes the pushed tag. The GitHub Actions workflow does not trigger Xcode Cloud.

If the website deployment fails, check the environment secrets first, then the Vercel build log. The GitHub Release stays published; the website can be redeployed from Vercel or by rerunning the failed job without creating a new tag.

If the Xcode Cloud build fails, investigate and retry it in Xcode Cloud as appropriate. The existing GitHub Release may remain published because it represents release metadata rather than a successful native build.

Do not move or replace a published release tag casually. Prefer a new version tag when artifacts or external systems may already refer to the original tag.
