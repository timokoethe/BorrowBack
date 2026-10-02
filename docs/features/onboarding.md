---
status: implemented
area: app-shell
platforms:
  - ios
---

# Onboarding

## Purpose

Introduce BorrowBack's core benefit before the main interface appears for the first time.

## User Story

As a new user, I want a brief introduction so that I understand what BorrowBack helps me do before I begin.

## Acceptance Criteria

- A concise onboarding screen appears before the main interface on first launch.
- The app logo introduces the BorrowBack identity with a brief, subtle entrance animation.
- The onboarding screen subtly recedes before the main interface opens.
- Onboarding entrance and completion motion are omitted when Reduce Motion is enabled.
- The onboarding screen explains that BorrowBack tracks loans, due dates, and returns.
- A prominent action opens the main interface.
- The introduction scrolls only when its content exceeds the available screen
  height, including when larger text sizes are used.
- When the introduction fits, scroll gestures are disabled. The start action
  stays visible outside the scrolling content.
- After completing onboarding, later launches open the main interface directly.
