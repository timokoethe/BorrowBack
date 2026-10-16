# Contributing to BorrowBack

Thanks for your interest in contributing to BorrowBack.
BorrowBack is a native SwiftUI app for iOS that tracks lent items, borrowers, due dates, and returns, so contributions should keep the app clear, approachable, and reliable.

## How to Contribute

Before opening a pull request, please:

- check whether a similar issue or pull request already exists
- keep changes focused on one topic
- describe the problem, motivation, and solution clearly
- include screenshots or screen recordings for UI changes when useful
- test the app before submitting changes

## Development Guidelines

Please follow the existing project style and structure. Prefer small, readable SwiftUI views and avoid adding unnecessary dependencies.

For native iOS feature changes, update the matching document in
[`docs/features/`](docs/features/). Use
[`_template.md`](docs/features/_template.md) when adding a new feature.

For UI changes:

- keep the interface simple and approachable
- make controls easy to understand
- preserve accessibility labels for icon-only controls
- keep English and German user-facing strings in sync
- consider different iPhone screen sizes

For data or persistence changes:

- keep the SwiftData model and `BBModelContainer` registration aligned
- preserve the distinction between active loans and returned loans in the archive
- handle save failures without silently falling back to temporary runtime storage

## Pull Requests

Pull requests should include:

- a concise summary of the change
- the reason for the change
- testing notes
- related issue links, if applicable

Please keep pull requests reasonably small. Larger changes are easier to review when split into focused steps.

## Reporting Bugs

When reporting a bug, include:

- the affected app version or commit
- iOS version and device or simulator details
- steps to reproduce
- expected behavior
- actual behavior
- screenshots or screen recordings, if helpful

## Security

Do not report security issues in public issues. Follow the process described in [SECURITY.md](SECURITY.md).

## License

By contributing to BorrowBack, you agree that your contributions will be licensed under the project's MIT License.
