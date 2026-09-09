---
status: implemented
area: loans
platforms:
  - ios
---

# Active Loan Overview

## Purpose

Show all items that are currently on loan so students can see what needs to be returned and by whom.

## User Story

As a user, I want to see my active loans in one place so that I can keep track of outstanding items.

## Acceptance Criteria

- The overview displays only loans that have not been returned.
- Each loan displays its title, borrower name, and due date.
- An empty state is displayed when there are no active loans.
- Changes to persisted loans are reflected in the overview.
- Tapping a loan opens it for editing, as described in [Edit a Loan](edit-loan.md).
