---
status: implemented
area: loans
platforms:
  - ios
  - ipados
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
- The reminder action opens a sheet with a localized Reminder message label
  above an editable message containing the item and due date, followed by
  full-width Send and Copy buttons with leading paper-plane and copy symbols.
- The message field has a compact height that scales with the text size;
  longer messages can be scrolled inside the field.
- The sheet has an inline Reminder message navigation title and a leading
  close (X) button, matching the edit-loan sheet's navigation layout.
- Send opens the system SMS/iMessage composer with the stored phone number
  and the edited message.
- Copy copies the edited message to the clipboard and confirms it with a
  Copied label and checkmark on the button. Editing the message restores the
  Copy label and symbol. Copy remains available when messaging is unavailable.
- Both buttons are disabled when the message is empty or only whitespace.
- Closing the sheet with the X button or a dismissal gesture discards edits
  without changing the loan.
- An overdue loan receives wording that acknowledges the missed due date.
- The app never sends a reminder without the user confirming it in the system
  message composer.
- If messaging is unavailable on the device, tapping Send explains why it
  cannot open the composer and keeps the edited message available.
- If sending fails in the system composer, the app displays an error after the
  composer closes.
- Closing the system composer returns to the reminder sheet with its draft
  intact, including after cancellation or a send failure. Further edits made
  inside the system composer are not copied back to the sheet.
- The sheet uses a preferred height suited to the message editor and actions in wide layouts; compact layouts retain medium and large sheet sizes.
