---
status: implemented
area: loans
platforms:
  - ios
---

# Loan Status

## Purpose

Help students recognize the urgency and lifecycle state of each loan at a glance.

## User Story

As a user, I want to see whether a loan is on time, due soon, overdue, or returned so that I can prioritize follow-up.

## Acceptance Criteria

- An active loan due in five days or more displays an OK status.
- An active loan due within five days displays a Due soon status.
- An active loan past its due date displays an Overdue status.
- An archived loan displays a Returned status.
- Overdue loans use coral, loans due soon use amber, and OK or returned loans use teal.
- Loan status reflects the current calendar day without requiring a restart or a data change.
