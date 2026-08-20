---
status: implemented
area: loans
platforms:
  - ios
---

# Delete a Loan

## Purpose

Allow students to permanently remove an active loan that is no longer needed or was entered incorrectly.

## User Story

As a user, I want to delete an active loan so that incorrect or irrelevant records no longer appear in my overview.

## Acceptance Criteria

- Swiping an active loan from the trailing edge reveals a destructive delete action.
- Completing the action removes the loan from the overview and persistent storage.
- A failed deletion is rolled back and displays an error.
