---
status: implemented
area: data
platforms:
  - ios
---

# Local Persistence

## Purpose

Keep users' loan records available across app launches and during temporary loss of network connectivity.

## User Story

As a user, I want my loan records and their lifecycle changes to be saved locally so that I can rely on them after reopening the app.

## Acceptance Criteria

- Created loans remain available after the app is relaunched.
- Return timestamps and deletions remain applied after the app is relaunched.
- The app does not require network access to read or change loan records.
- Local changes synchronize through iCloud when connectivity is available, as described in [iCloud Sync](icloud-sync.md).
- If local storage cannot be opened, loan-management controls are unavailable and the app displays a recovery message.
- The app does not silently switch to temporary storage when persistent storage is unavailable.
