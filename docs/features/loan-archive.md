---
status: implemented
area: loans
platforms:
  - ios
---

# Loan Archive

## Purpose

Help users preserve a history of completed loans and when their items were returned.

## User Story

As a user, I want to review returned loans so that I can reference past lending activity.

## Acceptance Criteria

- The archive displays only returned loans.
- Each archived loan displays its title and borrower name.
- Each archived loan displays the original loan date above the return date.
- Archived loans are ordered by return time with the most recently returned item first.
- An empty state is displayed when there are no returned loans.
- The empty state briefly fades in or out when the archive becomes empty or receives its first returned loan. With Reduce Motion enabled, it changes immediately.
- At accessibility text sizes, archived cards let titles, names, and dates wrap and show the status beside the title when both fit in one line, otherwise below it.
