# BorrowBack Agent Instructions

BorrowBack is a native iOS app for tracking items that have been lent to other people. The app shows active loans, records returns, and keeps completed loans in an archive. The native app lives in `app/apple/`; the website is a separate project in `website/`.

## Project Shape

- `app/apple/BorrowBack.xcodeproj/`: Xcode project for the native iOS app.
- `app/apple/BorrowBack/App/`: app entry point, root tab composition, and SwiftData container setup.
- `app/apple/BorrowBack/Features/Home/`: active-loan overview, sorting, swipe actions, creating a loan as a navigation page in compact layouts or a sheet in wide layouts, and the sheet for editing a loan. `AddLoan/` and `EditLoan/` hold one flow each; the form they share lives in `Components/LoanForm/`.
- `app/apple/BorrowBack/Features/Archive/`: returned-loan history.
- `app/apple/BorrowBack/Models/`: the persisted SwiftData `Loan`, plus the value types the loan forms work with (`Borrower`, `LoanDraft`).
- `app/apple/BorrowBack/Services/LoanService.swift`: loan mutations, validation, edit merging, saving, and rollback.
- `app/apple/BorrowBack/Localizable.xcstrings`: English source strings and German translations.
- `app/apple/BorrowBack/Assets.xcassets/` and `app/apple/Icon.icon/`: app colors and icon assets.
- `app/apple/BorrowBack/PrivacyInfo.xcprivacy`: privacy manifest. It declares no collected data and no tracking: loan records stay on-device or in the user’s private iCloud database, without developer access. UserDefaults API use is declared with required reason `CA92.1`. Keep it aligned with the app's data handling when behavior changes.
- `docs/features/`: documentation for the currently implemented native features; use `_template.md` for new feature documents.
- `scripts/export-images.sh`: frame simulator screenshots and update both `docs/assets/` and `website/public/screens/`; see [docs/screenshots.md](docs/screenshots.md) for usage and image names.
- `website/`: separate Next.js site; read `website/AGENTS.md` before editing it.

## Native App Architecture

- Use SwiftUI for the interface and SwiftData for persistence.
- Keep the existing feature-oriented directory structure.
- Keep implementations small and modular. Prefer one Swift struct per file.
- Use native SwiftUI state and environment dependencies instead of introducing view models without a clear need.
- Keep reusable UI local to the owning feature, under a `Components` subdirectory when appropriate.
- Preserve the current `TabView` and per-tab `NavigationStack` composition unless a feature requires a deliberate navigation change.

## Loan Data and Lifecycle

- A loan form collects its changes in a `LoanDraft` and writes them to the model only when the form is confirmed, so cancelling discards nothing that was persisted. Keep the mapping between draft and model in that type.
- `Loan` is the persisted domain model. Keep model-container registration in `BBModelContainer` aligned with every persisted model.
- A loan is active while `returnedAt` is `nil` and archived after `returnedAt` receives the actual return timestamp.
- A borrower is either a free-text name or a linked system contact, modelled by the `Borrower` enum. `borrowerName` holds the displayed name; linked contacts also retain their identifier, an optional phone number, and an optional photo snapshot.
- The contact picker runs out of process, so the app needs no Contacts authorization and reads no contact data beyond the picked contact. Reminders use the stored phone number and require user confirmation in the system message composer. Do not introduce direct Contacts database access, a usage description, or additional contact-based actions without a deliberate decision.
- Runtime persistence must fail closed. If the persistent container cannot be created, show the unavailable state and do not silently fall back to an in-memory container.
- In-memory containers are appropriate for previews and tests only.
- Handle save failures explicitly. Roll back or remove pending changes as appropriate, keep the UI state consistent, and show the existing localized error treatment.
- Use `LoanService` for persisted loan mutations; keep validation, edit merging, saving, and rollback there.

## UI and Localization

- Reuse the named colors already defined in `Assets.xcassets` instead of duplicating color values.
- `BBTeal` is the app's accent color, set as the asset catalog's global accent in the Xcode project and seeded into the SwiftUI environment tint once in `ContentView`. Do not re-tint controls with the same color; use `.accentColor` where a control needs the accent named explicitly, such as a swipe action.
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

That build compiles the app but cannot run it. Without code signing the app
carries no iCloud entitlements, so it crashes on launch while Core Data sets up
CloudKit. Use a regularly signed build to install and run the app in a
simulator:

```sh
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -project app/apple/BorrowBack.xcodeproj \
  -scheme BorrowBack \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath /tmp/borrowback-simulator \
  build
```

- There are currently no native test targets. For code changes, run the build and describe relevant manual verification.
- Documentation-only changes do not require an Xcode build; run `git diff --check` and verify the documents against the current implementation.
- Do not add or run UI tests unless the user explicitly requests them.

## Release Reviews

- TestFlight is already part of release validation. In app reviews, identify specific behavior that still needs verification, but do not present adopting or setting up TestFlight as an outstanding task.
- App Store Connect administration and submission are handled separately. Exclude administrative checklists from app reviews unless explicitly requested. Still report concrete privacy, security, or release issues, even if resolving them involves App Store Connect.
- This repository is public. Do not add credentials, vulnerability details, or exploit instructions to public files; communicate security-sensitive findings to the owner without committing them.

## Working Guidelines

- Keep changes focused and preserve unrelated work in the working tree.
- Do not add dependencies or change the Xcode project unless the requested feature requires it.
- Update the matching feature document when native behavior changes.
- Treat the website as a separate scope. Do not modify it merely because native UI or copy changed unless the user asks for website parity.
