---
status: implemented
area: loans
platforms:
  - ios
---

# Sort Active Loans

## Purpose

Allow students to organize outstanding loans by urgency or item name.

## User Story

As a user, I want to sort active loans so that I can find an item or identify the next due loan quickly.

## Acceptance Criteria

- The overview offers sorting by due date and by name.
- Due-date sorting places the earliest due loan first.
- Loans with the same due date are ordered by item title.
- Name sorting orders loans by item title using locale-aware comparison.
- The selected sort order is shown in the overview control.
