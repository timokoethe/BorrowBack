# BorrowBack Agent Instructions

BorrowBack is a native iOS app for tracking items that have been lent to other people. The app shows active loans, records returns, and keeps completed loans in an archive. The native app lives in `app/apple/`; the website is a separate project in `website/`.

## Project Shape

- `app/apple/BorrowBack.xcodeproj/`: Xcode project for the native iOS app.
- `app/apple/BorrowBack/App/`: app entry point, root tab composition, and SwiftData container setup.
- `app/apple/BorrowBack/Features/Home/`: active-loan overview, sorting, swipe actions, and the add-loan sheet.
- `app/apple/BorrowBack/Features/Archive/`: returned-loan history.
- `app/apple/BorrowBack/Features/Settings/`: placeholder for the More tab.
- `app/apple/BorrowBack/Models/Loan.swift`: persisted SwiftData loan model.
- `app/apple/BorrowBack/Localizable.xcstrings`: English source strings and German translations.
- `app/apple/BorrowBack/Assets.xcassets/` and `app/apple/Icon.icon/`: app colors and icon assets.
- `docs/features/`: documentation for the currently implemented native features; use `_template.md` for new feature documents.
- `website/`: separate Next.js site; read `website/AGENTS.md` before editing it.

## Native App Architecture

- Use SwiftUI for the interface and SwiftData for persistence.
- Keep the existing feature-oriented directory structure.
- Keep implementations small and modular. Prefer one Swift struct per file.
- Use native SwiftUI state and environment dependencies instead of introducing view models without a clear need.
- Keep reusable UI local to the owning feature, under a `Components` subdirectory when appropriate.
- Preserve the current `TabView` and per-tab `NavigationStack` composition unless a feature requires a deliberate navigation change.

## Loan Data and Lifecycle

- `Loan` is the persisted domain model. Keep model-container registration in `BBModelContainer` aligned with every persisted model.
- A loan is active while `returnedAt` is `nil` and archived after `returnedAt` receives the actual return timestamp.
- Borrower names are currently entered as free text. `contactIdentifier` is reserved for a future Contacts integration; do not imply that contact lookup is already available.
- Runtime persistence must fail closed. If the persistent container cannot be created, show the unavailable state and do not silently fall back to an in-memory container.
- In-memory containers are appropriate for previews and tests only.
- Handle save failures explicitly. Roll back or remove pending changes as appropriate, keep the UI state consistent, and show the existing localized error treatment.

## UI and Localization

- Reuse the named colors already defined in `Assets.xcassets` instead of duplicating color values.
- English is the development and source language. German is the supported secondary localization.
- Add or update user-facing strings in `Localizable.xcstrings` for both languages.
- Prefer SwiftUI localization-aware values such as `LocalizedStringKey` and locale-aware date formatting for text that must respond to the environment locale.
- Preserve accessibility labels for icon-only controls and add labels to new icon-only interactions.

## Feature Documentation

- Keep `docs/features/` aligned with observable behavior in the native app.
- Create one English Markdown file per user-facing feature using `docs/features/_template.md`.
- Mark documentation for existing behavior as `implemented`; use `planned` only for behavior that is not yet available.
- Keep acceptance criteria concise, observable, and independent of implementation details.
- Do not document placeholder UI or reserved model fields as completed features.

## Verification

Open the native project in Xcode when interactive verification is needed:

```sh
open app/apple/BorrowBack.xcodeproj
```

Use this command for a signing-independent build:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -project app/apple/BorrowBack.xcodeproj \
  -scheme BorrowBack \
  -destination 'generic/platform=iOS' \
  -derivedDataPath /tmp/borrowback-build \
  CODE_SIGNING_ALLOWED=NO build
```

- There are currently no native test targets. For code changes, run the build and describe relevant manual verification.
- Documentation-only changes do not require an Xcode build; run `git diff --check` and verify the documents against the current implementation.
- Do not add or run UI tests unless the user explicitly requests them.

## Working Guidelines

- Keep changes focused and preserve unrelated work in the working tree.
- Do not add dependencies or change the Xcode project unless the requested feature requires it.
- Update the matching feature document when native behavior changes.
- Treat the website as a separate scope. Do not modify it merely because native UI or copy changed unless the user asks for website parity.
