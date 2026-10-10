---
status: implemented
area: loans
platforms:
  - ios
---

# Link a Borrower Contact

## Purpose

Let students pick the borrower from their existing contacts instead of typing a
name, so a loan can later be traced back to a specific person.

## User Story

As a user, I want to select a borrower from my contacts or type a name so that
I can record who borrowed an item in the way that suits the situation.

## Acceptance Criteria

- The person field of the new-loan form accepts either a typed name or a
  selected contact, never both.
- A contact action next to the person field opens the system contact picker.
- Selecting a contact replaces the person field with the contact's name and
  links the contact to the loan.
- A selected contact's only phone number is stored automatically; if several
  numbers are available, the user chooses one.
- A contact without a phone number can still be linked, but cannot receive a
  reminder message.
- A contact without a personal name is linked under its organization name.
- A contact with neither a personal name nor an organization name is not
  linked, and the person field stays available for a typed name.
- Removing a linked contact clears the person field and restores free-text
  entry.
- Cancelling the contact picker leaves the person field unchanged.
- Cancelling the phone-number choice for a contact with several numbers leaves
  the person field unchanged.
- A loan with a linked contact is marked with a contact symbol next to the
  borrower name.
- Saving is disabled while no contact is linked and the typed name is empty or
  contains only whitespace.
- The borrower name of a saved loan remains available without access to the
  contacts database.
- A saved phone number can be used to prepare a reminder as described in
  [Send a Loan Reminder](send-loan-reminder.md).
- At accessibility text sizes, the selected contact name and phone number can wrap onto multiple lines.
- The selected phone number and remove-contact control remain legible against the form background in light and dark mode.
