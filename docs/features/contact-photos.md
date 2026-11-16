---
status: implemented
area: loans
platforms:
  - ios
---

# Contact Photos

## Purpose

Help users recognize a linked borrower by keeping a small contact photo with the loan.

## User Story

As a user, I want to see a selected borrower's photo on my devices so that I can
recognize them without granting ongoing access to my contacts.

## Acceptance Criteria

- Selecting a contact captures a reduced copy of its photo when the system
  contact picker supplies one.
- The selected photo appears beside the borrower name in the loan form and on
  active and archived loan cards.
- Contacts without an available or readable photo use the existing contact symbol.
- Photos scale with the text size and do not duplicate the borrower name in VoiceOver.
- Photos fill the contact symbol's layout bounds without additional padding,
  so switching between a photo and its placeholder does not shift the name.
- Photos are saved only when the loan form is confirmed; cancelling leaves the
  stored borrower and photo unchanged.
- Removing or replacing the linked contact removes or replaces its photo when saved.
- Saved photos remain available after restarting, returning, or restoring a loan.
- When iCloud synchronization is enabled, the photo synchronizes with the loan
  through the user's private iCloud database, without developer access.
- Displaying a saved photo requires no Contacts authorization or contact lookup,
  including on another device.
- The photo is a snapshot; later changes in Contacts are not fetched automatically.
- Existing loans keep their contact symbol until a contact with an available photo
  is selected again and the loan is saved.
