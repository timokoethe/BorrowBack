---
status: implemented
area: data
platforms:
  - ios
---

# iCloud Sync

## Purpose

Keep a user's loan records consistent across their Apple devices through their private iCloud account.

## User Story

As a user, I want my loans to sync through iCloud so that I can manage the same records on all my devices.

## Acceptance Criteria

- Loan records sync between devices signed in to the same iCloud account.
- Created, edited, returned, and deleted loans are included in synchronization.
- Loan data is stored in the user's private iCloud database and is not shared with other users.
- Changes made without a network connection remain available locally and sync after connectivity returns.
