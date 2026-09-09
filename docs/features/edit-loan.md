---
status: implemented
area: loans
platforms:
  - ios
---

# Edit a Loan

## Purpose

Let students correct an active loan whose item description, borrower, or due
date was entered wrongly or has since changed.

## User Story

As a user, I want to change the details of an active loan so that a typo or a
postponed return date does not force me to delete and recreate the record.

## Acceptance Criteria

- Tapping an active loan in the overview opens it in the loan form.
- The form opens filled with the loan's current item description, borrower, and
  due date.
- A loan with a linked contact opens with that contact still linked.
- The same borrower options are available as when creating a loan: a typed name
  or a linked contact.
- The due date of an overdue loan can be kept as it is.
- Confirming the form applies the changes and closes it.
- Closing the form with the cancel action leaves the loan unchanged.
- A failed change is rolled back and displays an error.
- Editing a loan changes neither its loan date nor its returned state.
- Archived loans are not editable.
