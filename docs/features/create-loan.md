---
status: implemented
area: loans
platforms:
  - ios
---

# Create a Loan

## Purpose

Let users record an item they have lent, the borrower's name, the date it was lent, and the expected return date.

## User Story

As a user, I want to record a new loan so that I do not forget who borrowed an item or when it is due.

## Acceptance Criteria

- The plus button in the overview header navigates to the new-loan page.
- The plus button exposes localized input names for new loan, add loan, and plus to assistive input tools.
- The new-loan page uses the standard back button in the navigation bar.
- The new-loan page finishes opening before the item field receives focus and the keyboard rises from the bottom edge.
- The app background continues behind the keyboard without exposing the tab bar.
- The form accepts an item description, a borrower, a loan date, and a due date.
- Optional [loan notes](loan-notes.md) can be entered at the bottom of the form.
- The borrower is either a free-text name or a linked contact, as described in
  [Link a Borrower Contact](link-borrower-contact.md).
- The loan date is preselected with the current date so recording a loan right away needs no date entry.
- The loan date can be moved into the past to record a loan after the fact, and cannot be set to a future date.
- The due date cannot be earlier than the loan date.
- Saving a loan with a due date earlier than its loan date is rejected without creating a record. Equal dates are allowed.
- The new-loan page offers quick choices for seven days, fourteen days, or a custom due date. A quick choice is counted from the loan date.
- Due-date quick choices briefly animate their text and background colors when selection changes. With Reduce Motion enabled, the colors change immediately.
- Saving is disabled while the item description or the borrower name is empty or contains only whitespace.
- A save checkmark is displayed in the top-right corner of the new-loan page.
- Confirming a valid form persists the loan and returns to the overview.
- Navigating back without saving does not create a loan.
- A failed save keeps the page open and displays an error.
- At accessibility text sizes, due-date quick choices are stacked vertically and their labels can wrap.
