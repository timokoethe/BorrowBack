---
status: implemented
area: loans
platforms:
  - ios
  - ipados
---

# Active Loan Overview

## Purpose

Show all items that are currently on loan so users can see what needs to be returned and by whom.

## User Story

As a user, I want to see my active loans in one place so that I can keep track of outstanding items.

## Acceptance Criteria

- The overview displays only loans that have not been returned.
- Each loan displays its title, borrower name, and due date.
- An empty state is displayed when there are no active loans.
- The empty state briefly fades in or out when the overview becomes empty or receives its first loan. With Reduce Motion enabled, it changes immediately.
- The empty overview does not scroll its header or sorting control.
- Changes to persisted loans are reflected in the overview.
- Tapping a loan opens it for editing, as described in [Edit a Loan](edit-loan.md).
- A loan with a linked phone number offers the reminder action described in
  [Send a Loan Reminder](send-loan-reminder.md).
- At accessibility text sizes, loan cards let the title, borrower name, and due date wrap while the status indicator stays at the top trailing corner.
- In wide windows, the header, sorting control, and loan list share a centered, limited content width.
- Loans due soon or overdue show a compact circular status indicator at the top trailing corner, including when the title wraps. Loans with OK status have no visible indicator.
