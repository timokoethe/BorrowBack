---
status: implemented
area: loans
platforms:
  - ios
---

# Delete a Loan

## Purpose

Allow students to permanently remove a loan that is no longer needed or was entered incorrectly.

## User Story

As a user, I want to delete a loan so that incorrect or irrelevant records no longer appear in my overview or archive.

## Acceptance Criteria

- Swiping an active loan from the trailing edge reveals a destructive delete action.
- Swiping an archived loan from the trailing edge reveals a destructive delete action.
- Completing the action removes the loan from its current list and persistent storage.
- A failed deletion is rolled back and displays an error.
