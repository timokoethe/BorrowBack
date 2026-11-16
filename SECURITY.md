# Security Policy

BorrowBack is a native SwiftUI app for iOS that stores loan records locally on the user's device. Records include item and borrower names, loan and return dates, optional notes, and a selected contact's identifier, phone number, and a reduced photo snapshot when linked to a loan.

When iCloud is enabled for BorrowBack in the device settings, these records also synchronize through the user's private CloudKit database across devices signed in to the same Apple Account. The developer does not receive or have access to these records.

Please report any issue that could compromise this data, user privacy, app integrity, or the security of a user's device.

## Supported Versions

Only the latest public release and the current `main` branch are supported for security fixes.

## Reporting a Vulnerability

Please do not open a public issue for security reports.

If private vulnerability reporting is enabled for this repository, use GitHub's private vulnerability reporting flow to submit details securely. Otherwise, email [borrowback@itstimo.me](mailto:borrowback@itstimo.me) before sharing details in public.

Please include:

- affected version or commit
- iOS version and device or simulator details
- steps to reproduce
- potential impact
- proof of concept, if available

We will review the report, validate the issue, and coordinate a fix before public disclosure.
