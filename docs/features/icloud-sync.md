---
status: implemented
area: data
platforms:
  - ios
---

# iCloud Sync

## Purpose

Keep a user's loan records consistent across supported devices through their private iCloud account.

## User Story

As a user, I want my loans to sync through iCloud so that I can manage the same records on my supported devices.

## Acceptance Criteria

- When iCloud is enabled for BorrowBack in device settings, loan records automatically sync between supported devices signed in to the same Apple Account.
- Synchronization is controlled through device settings; BorrowBack has no separate iCloud switch.
- Created, edited, returned, and deleted loans are included in synchronization.
- Loan data is stored in the user's private iCloud database and is not shared with other users.
- Synchronized records include item details, notes, dates, and a linked contact's stored name, identifier, and phone number when present.
- The developer does not receive or have access to the private loan records.
- Changes made without a network connection remain available locally and sync after connectivity returns.
