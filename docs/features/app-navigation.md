---
status: implemented
area: navigation
platforms:
  - ios
  - ipados
---

# App Navigation

## Purpose

Give users direct access to active loans and returned loans from one consistent navigation structure.

## User Story

As a user, I want to switch between the overview and the archive so that I can reach the app's main sections quickly.

## Acceptance Criteria

- Overview and Archive form the app's main tab navigation.
- In compact layouts, the tab bar is hidden on the new-loan page and reappears when returning to the overview.
- In wide layouts, creating a loan opens a sheet; closing it leaves the overview and tab bar in place.
- Selecting a tab displays its corresponding screen.
- Both tabs use the shared BorrowBack wordmark and a screen-specific section
  heading.
- The selected tab uses the app's accent color.
- The overview's add button and the archive's information button use equally
  sized circular accent backgrounds.
- The archive header provides the information access described in
  [App Information](app-information.md).
- The app supports iPhone and iPad; iPad supports all four interface orientations and resizable windows.
- Layout changes preserve the current navigation and unsaved form input.
