---
status: implemented
area: loans
platforms:
  - ios
---

# Edit a Loan

## Purpose

Let students correct an active loan whose item description, borrower, loan
date, or due date was entered wrongly or has since changed.

## User Story

As a user, I want to change the details of an active loan so that a typo or a
postponed return date does not force me to delete and recreate the record.

## Acceptance Criteria

- Tapping an active loan in the overview opens it in the loan form.
- Active loan buttons expose the item description as a short name for assistive input tools, while VoiceOver retains the complete card information.
- The form opens filled with the loan's current item description, borrower,
  loan date, and due date.
- A loan with a linked contact opens with that contact still linked.
- Optional [loan notes](loan-notes.md) can be edited or cleared at the bottom of the form.
- The same borrower options are available as when creating a loan: a typed name
  or a linked contact.
- The due date of an overdue loan can be kept as it is.
- The loan date can be corrected and cannot be set to a future date.
- The due date cannot be moved before the loan date.
- Confirming the form applies the changes and closes it.
- Saving preserves changes already synchronized to this device for fields left
  unchanged in the form.
- If the same field was changed in the form and a synchronized change has
  already arrived on this device, the form's edit wins when saving.
  The borrower's name, contact link, and phone number are saved together.
- If merged dates would put the due date before the loan date, saving fails
  without changing the loan and the form stays open with an error.
- Saving fails instead of recreating a loan if its deletion has already been
  applied on this device.
- Closing the form with the cancel action leaves the loan unchanged.
- A failed change is rolled back and displays an error.
- Editing a loan does not change its returned state.
- Archived loans cannot be opened for editing from the archive.
- If a return synchronizes while the edit form is open, the form can still be
  saved; the loan remains archived with its synchronized return timestamp.
