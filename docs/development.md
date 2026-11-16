# Native development

Requires Xcode 26 or later and iOS 26 or later. Open
`app/apple/BorrowBack.xcodeproj` and select the `BorrowBack` scheme.

## Signing and iCloud

Because runtime persistence uses CloudKit, installing and running the app
requires a regularly signed build. For your own build, select your Apple
Developer team in Signing & Capabilities, use your own bundle identifier and
iCloud container, and update the container identifier in both
`BorrowBack.entitlements` and `App/BBModelContainer.swift`. Your provisioning
profile must support the app's iCloud/CloudKit and push notification capabilities.
The checked-in identifiers belong to the upstream app; they are not credentials.

Debug builds populate and refresh sample loans on each launch. These use the
configured persistent store and can sync to its private iCloud database. Use a
development account for local work; see [screenshot documentation](screenshots.md)
for the sample-data behavior. Release builds do not seed sample loans.

## Compile without signing

Run from the repository root:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -project app/apple/BorrowBack.xcodeproj \
  -scheme BorrowBack \
  -destination 'generic/platform=iOS' \
  -derivedDataPath /tmp/borrowback-build \
  CODE_SIGNING_ALLOWED=NO build
```

This verifies compilation but does not produce an app that can run with its
iCloud-backed container.

