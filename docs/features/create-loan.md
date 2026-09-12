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

- The plus button in the overview header navigates to the new-loan page.
- The new-loan page uses the standard back button in the navigation bar.
- The form accepts an item description, a borrower, and a due date.
- The borrower is either a free-text name or a linked contact, as described in
  [Link a Borrower Contact](link-borrower-contact.md).
- The due date cannot be earlier than the current date. Editing an existing loan relaxes this, as described in [Edit a Loan](edit-loan.md).
- The new-loan page offers quick choices for seven days, fourteen days, or a custom due date.
- Saving is disabled while the item description or the borrower name is empty or contains only whitespace.
- A save checkmark is displayed in the top-right corner of the new-loan page.
- Confirming a valid form persists the loan and returns to the overview.
- Navigating back without saving does not create a loan.
- A failed save keeps the page open and displays an error.
