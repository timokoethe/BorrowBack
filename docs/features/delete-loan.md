---
status: implemented
area: loans
platforms:
  - ios
---

# Delete a Loan

## Purpose

Allow users to permanently remove a loan that is no longer needed or was entered incorrectly.

## User Story

As a user, I want to delete a loan so that incorrect or irrelevant records no longer appear in my overview or archive.

## Acceptance Criteria

- Swiping an active loan from the trailing edge reveals a destructive delete action.
- Swiping an archived loan from the trailing edge reveals a destructive delete action.
- A full swipe does not delete a loan; the user must activate the revealed delete button.
- Long-pressing an active loan reveals a context menu with a destructive delete action.
- Long-pressing an archived loan reveals a context menu with a destructive delete action.
- Deleting a loan from either list completes immediately without showing a confirmation alert.
- Completing the action removes the loan from its current list and persistent storage.
- The remaining loans move into place with a short animation unless Reduce Motion is enabled.
- A failed deletion is rolled back and displays an error.
