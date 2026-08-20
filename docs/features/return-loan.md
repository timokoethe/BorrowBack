---
status: implemented
area: loans
platforms:
  - ios
---

# Return a Loan

## Purpose

Let students complete an active loan while retaining its history.

## User Story

As a user, I want to mark an item as returned so that it leaves my active list without losing the loan record.

## Acceptance Criteria

- Swiping an active loan from the leading edge reveals a return action.
- Completing the action records the current date and time as the return time.
- A returned loan is removed from the active overview and appears in the archive.
- A failed update is rolled back and displays an error.
