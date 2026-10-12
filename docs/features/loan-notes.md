---
status: implemented
area: loans
platforms:
  - ios
---

# Loan Notes

## Purpose

Keep additional details about a loan alongside its item, borrower, and dates.

## User Story

As a user, I want to add optional notes to a loan so that I can remember
details such as accessories or the item's condition.

## Acceptance Criteria

- New-loan and edit-loan forms end with an optional, multiline notes field.
- Focusing the notes field scrolls the form to keep the notes and character
  counter visible above the keyboard, in both new-loan and edit-loan forms.
- Notes are limited to 200 characters, including line breaks and spaces.
- A visible counter shows the current character count and limit.
- At 200 characters, further input cannot increase the visible text; deleting
  or replacing characters remains possible.
- Pasting text below the limit keeps only the first 200 characters of the
  resulting notes without splitting emoji or other combined characters.
- A loan can be saved without notes; empty or whitespace-only notes are absent.
- Saving removes surrounding whitespace from notes and preserves internal line breaks.
- Editing opens with the saved notes and allows changing or clearing them.
- Cancelling a form leaves saved notes unchanged.
- Saving other edits preserves notes synchronized while the form was open
  if the notes were left unchanged locally.
- Notes stay attached to a loan when it is returned or restored.
- The notes field and counter are available in English and German.
