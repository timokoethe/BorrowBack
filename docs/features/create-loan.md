---
status: implemented
area: loans
platforms:
  - ios
---

# Create a Loan

## Purpose

Let students record an item they have lent, the borrower's name, and the expected return date.

## User Story

As a user, I want to record a new loan so that I do not forget who borrowed an item or when it is due.

## Acceptance Criteria

- The plus button on the overview opens the new-loan sheet.
- The form accepts an item description, a free-text borrower name, and a due date.
- The due date cannot be earlier than the current date.
- Saving is disabled while the item description or borrower name is empty or contains only whitespace.
- Confirming a valid form persists the loan and dismisses the sheet.
- Closing the sheet with the cancel action does not create a loan.
- A failed save keeps the sheet open and displays an error.
