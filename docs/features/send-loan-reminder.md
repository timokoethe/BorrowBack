---
status: implemented
area: loans
platforms:
  - ios
---

# Send a Loan Reminder

## Purpose

Help users remind a linked borrower about an active loan without having to
retype the item, due date, or phone number.

## User Story

As a user, I want to prepare a reminder for a borrower so that I can ask about
an upcoming or missed return date with little effort.

## Acceptance Criteria

- Linking a contact with one phone number stores that number for reminder
  messages.
- If a contact has multiple phone numbers, the user chooses which one to use.
- A contact without any phone number can still be linked, but does not offer a
  reminder action.
- An active loan with a stored phone number offers a reminder action in its
  context menu.
- The system SMS/iMessage composer opens with the phone number and a
  localized, editable reminder containing the item and due date.
- An overdue loan receives wording that acknowledges the missed due date.
- The app never sends a reminder without the user confirming it in the system
  message composer.
- If messaging is unavailable on the device, the app explains why it cannot
  open the composer.
- If sending fails in the system composer, the app displays an error after the
  composer closes.
