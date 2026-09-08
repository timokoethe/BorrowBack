# BorrowBack

[![License: MIT](https://img.shields.io/badge/license-MIT-orange)](https://opensource.org/license/mit)
[![Release](https://img.shields.io/github/v/release/timokoethe/BorrowBack?color=orange)](https://github.com/timokoethe/BorrowBack/releases/latest)
![Framework](https://img.shields.io/badge/SwiftUI-orange)
![Platform](https://img.shields.io/badge/Platform-iOS-orange)
![Xcode](https://img.shields.io/badge/Xcode-26-orange)
![iOS](https://img.shields.io/badge/iOS-26-orange)

BorrowBack is a native iOS app for tracking lent items, their borrowers, due dates, and returns.

## Features

- [App Navigation](docs/features/app-navigation.md)
- [Active Loan Overview](docs/features/active-loan-overview.md)
- [Create a Loan](docs/features/create-loan.md)
- [Loan Status](docs/features/loan-status.md)
- [Sort Active Loans](docs/features/sort-active-loans.md)
- [Return a Loan](docs/features/return-loan.md)
- [Delete a Loan](docs/features/delete-loan.md)
- [Loan Archive](docs/features/loan-archive.md)
- [Local Persistence](docs/features/local-persistence.md)
- [English and German Localization](docs/features/localization.md)

## Project Structure

- [`app/apple/`](app/apple/) contains the native iOS app and Xcode project.
- [`docs/features/`](docs/features/) contains the native iOS feature
  documentation.
- [`website/`](website/) contains the separate Next.js-based landing page.

## Development

### iOS app

Requirements: Xcode 26 or later and an iPhone or simulator running iOS 26 or later.

Open the project in Xcode and run the `BorrowBack` scheme:

```sh
open app/apple/BorrowBack.xcodeproj
```

To verify a command-line build:

```sh
xcodebuild -project app/apple/BorrowBack.xcodeproj -scheme BorrowBack \
  -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build
```

### Website

The BorrowBack website is developed separately in [`website/`](website/). Its
Next.js application code is located in [`website/app/`](website/app/), with the
landing page in [`website/app/page.tsx`](website/app/page.tsx).

To run the website locally:

```sh
cd website
npm install
npm run dev
```

The development server is available at
[http://localhost:3000](http://localhost:3000). See the
[website README](website/README.md) for the available scripts and deployment
details.

## Releases

Releases use tags such as `v1.1.0` or `v1.1.0-beta1`. Pushing a release tag creates the corresponding GitHub release and deploys the website to Vercel — stable tags to production, beta tags to a preview. Native builds are handled separately by Xcode Cloud. See [docs/release.md](docs/release.md) for the full process.

## Contributing

Contributions are welcome.
Please keep changes focused and see [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

Report security issues privately as described in [SECURITY.md](SECURITY.md).

## License

BorrowBack is released under the MIT License. See [LICENSE](LICENSE).
