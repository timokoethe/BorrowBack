---
status: implemented
area: loans
platforms:
  - ios
---

# Restore a Loan

## Purpose

Let users undo a return so that a loan archived by mistake does not have to be recreated by hand.

## User Story

As a user, I want to move an archived loan back to my active loans so that a return I recorded by accident does not cost me the record.

## Acceptance Criteria

- Swiping an archived loan from the leading edge reveals a restore action.
- Long-pressing an archived loan reveals a context menu with a restore action.
- Completing the action clears the return time of the loan.
- A restored loan leaves the archive and appears in the active overview.
- A restored loan keeps its loan date and its due date, so a loan whose due date has passed is shown as overdue.
- The remaining archived loans move into place with a short animation unless Reduce Motion is enabled.
- A failed update is rolled back and displays an error.
