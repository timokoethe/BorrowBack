---
status: implemented
area: app-shell
platforms:
  - ios
---

# Launch Animation

## Purpose

Give the app a brief, recognizable transition into its main interface without delaying access.

## User Story

As a user, I want a short visual confirmation when BorrowBack opens so that the app launch feels polished without delaying access.

## Acceptance Criteria

- The system launch screen uses the app's background color.
- The main interface becomes available immediately after the system launch screen.
- The BorrowBack wordmark on the initial overview appears with a brief, subtle transition.
- No full-screen splash view or fixed launch delay obscures the main interface.
- The wordmark does not animate when Reduce Motion is enabled.
