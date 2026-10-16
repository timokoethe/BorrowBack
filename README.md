<p align="center">
  <img src="website/app/icon.png" width="112" alt="BorrowBack app icon">
</p>

<h1 align="center">BorrowBack</h1>

<p align="center">
  <strong>Keep track of what you lend — and get it back.</strong>
</p>

<p align="center">
  A calm, native iOS app for recording lent items, borrowers, due dates, and returns.
</p>

<p align="center">
  <a href="https://opensource.org/license/mit"><img src="https://img.shields.io/badge/license-MIT-0E7C86" alt="MIT license"></a>
  <a href="https://github.com/timokoethe/BorrowBack/releases/latest"><img src="https://img.shields.io/github/v/release/timokoethe/BorrowBack?color=0E7C86" alt="Latest release"></a>
  <img src="https://img.shields.io/badge/UI-SwiftUI-0E7C86" alt="SwiftUI">
  <img src="https://img.shields.io/badge/platform-iOS%2026-0E7C86" alt="iOS 26">
  <img src="https://img.shields.io/badge/Xcode-26-0E7C86" alt="Xcode 26">
</p>

## At a Glance

BorrowBack keeps the full lifecycle of a loan in one place: create it, see what
is due, mark it as returned, and find it again in the archive. The interface is
purposefully small and uses native iOS patterns throughout.

<p align="center">
  <img src="website/public/screens/HomeView.png" width="30%" alt="BorrowBack active-loan overview">
  &nbsp;
  <img src="website/public/screens/AddView.png" width="30%" alt="BorrowBack add-loan form">
  &nbsp;
  <img src="website/public/screens/ArchiveView.png" width="30%" alt="BorrowBack returned-loan archive">
</p>

<p align="center">
  <sub>Active loans · Add a loan · Returned-loan archive</sub>
</p>

## Highlights

- **Stay oriented:** See active loans at a glance, including borrower, due date,
  and a clear status indicator.
- **Capture the essentials:** Record an item, borrower, lending date, and due
  date in a focused form.
- **Use the system contact picker:** Link a borrower without granting the app
  broad access to the Contacts database.
- **Complete the lifecycle:** Edit, return, restore, archive, and delete loans.
- **Find what matters first:** Sort active loans by due date or item name.
- **Keep data available:** Store loans locally with SwiftData and synchronize
  them through the user's private iCloud database.
- **Use the app in English or German:** Interface text and date presentation
  respond to the selected locale.

The behavior of every implemented feature is documented in
[`docs/features/`](docs/features/), including
[onboarding](docs/features/onboarding.md),
[loan status](docs/features/loan-status.md),
[the archive](docs/features/loan-archive.md), and
[iCloud sync](docs/features/icloud-sync.md).

## Privacy by Design

BorrowBack does not request general Contacts access. Contact selection happens
in Apple's out-of-process picker, and the app retains only the selected contact
identifier, display name, and optional reminder phone number. Loan records stay
on the device and, when iCloud is enabled for BorrowBack in device settings,
synchronize through the user's private CloudKit database. The developer does
not receive or have access to these records. The app has no analytics,
advertising, or developer-operated backend.

The current [privacy manifest](app/apple/BorrowBack/PrivacyInfo.xcprivacy)
declares no collected data and no tracking. Local storage and private iCloud
synchronization do not give the developer access to loan records. The manifest
lists UserDefaults API use with required reason `CA92.1` for the saved onboarding
status. App Store Connect privacy labels are maintained separately and must
reflect the same data handling.

The [privacy policy](https://borrowback.itstimo.me/privacy) also explains contact
selection, user-confirmed reminder messages, and copying text to the clipboard.
Website logs and analytics are separate from the native app's data handling.

## Getting Started

### Native iOS app

You need Xcode 26 or later and an iPhone or simulator running iOS 26 or later.

Open the project and run the `BorrowBack` scheme:

```sh
open app/apple/BorrowBack.xcodeproj
```

Because runtime persistence uses CloudKit, installing and running the app
requires a regularly signed build. For a signing-independent compile check,
use:

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

### Website

The separate landing page lives in [`website/`](website/). To run it locally:

```sh
cd website
npm ci
npm run dev
```

Then open [http://localhost:3000](http://localhost:3000). See the
[website README](website/README.md) for scripts and deployment details.

## Repository Layout

```text
BorrowBack/
├── app/apple/       Native iOS app and Xcode project
├── docs/features/   Observable feature behavior and acceptance criteria
└── website/         Separate Next.js landing page
```

## Releases

Stable releases use tags such as `v1.1.0`; beta releases use tags such as
`v1.1.0-beta1`. A pushed release tag creates the corresponding GitHub Release
and deploys the website to Vercel. Native builds run separately in Xcode Cloud.

See [docs/release.md](docs/release.md) for the complete release and verification
process.

## Contributing

Contributions are welcome. Please keep changes focused and read
[CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

Report security issues privately as described in [SECURITY.md](SECURITY.md).

## License

BorrowBack is available under the [MIT License](LICENSE).
