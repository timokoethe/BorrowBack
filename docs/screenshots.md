# Screenshot exports

Use `scripts/export-images.sh` to put a simulator screenshot inside the shared
iPhone frame and save the same PNG to `docs/assets/` and
`website/public/screens/`. Existing files with the same name are replaced.

## Requirements

Run on macOS with Xcode installed for simulator capture. The renderer uses macOS
frameworks and requires no additional dependencies. Start a portrait iPhone
simulator with matching display proportions, such as iPhone 17 Pro, and open the
desired app screen in light mode.

The frame is `docs/assets/iphone-frame.png`. It includes a fixed light status bar
showing `9:41`. A different frame requires updating the display geometry in
`scripts/export-images.swift`.

## Sample data

Debug builds refresh the seven known sample loans on each launch using dates
relative to the current day. The overview includes an overdue loan, one due
today, one due in three days, and one due in fourteen days. Three recently
returned loans populate the archive.

These sample records use English item titles. Their titles and loan, due, creation,
and return dates are reset; other fields and unrelated loans are preserved. To capture a changed return state,
take the screenshot before relaunching. Release builds do not seed sample data.

## Capture the current simulator screen

Run from the repository root, navigating to the appropriate screen before each
capture:

```sh
./scripts/export-images.sh --simulator HomeView
./scripts/export-images.sh --simulator AddView
./scripts/export-images.sh --simulator ReminderView
./scripts/export-images.sh --simulator ArchiveView
```

For `ReminderView`, use an active loan linked to a contact with a phone number.
Touch and hold the loan, choose **Write reminder**, and leave the editable message
and its Send and Copy buttons visible before capturing. The seeded loans do not
include contact links or phone numbers; link a sample contact in the loan's edit
form first.

Use these exact names to replace the images referenced by the website and README.
Each command writes one framed image to each output directory, for example
`docs/assets/HomeView.png` and `website/public/screens/HomeView.png`.

The name is optional; without it, the filename is `simulator-framed.png`.
You can include `.png` in the name. For names containing spaces, use quotes.

If multiple simulators are running, select one explicitly:

```sh
xcrun simctl list devices booted
./scripts/export-images.sh --simulator HomeView --device DEVICE-UDID
```

## Frame an existing screenshot

```sh
./scripts/export-images.sh /path/to/raw-screenshot.png HomeView
```

Supply a raw, unframed portrait screenshot. Images already in `docs/assets/` and
`website/public/screens/` contain a device frame and should not be framed again.

## Export behavior

- Output PNGs are 1319 × 2748 pixels with transparency around the device.
- Both output directories are resolved relative to the repository, regardless of
  the working directory. Input paths are relative to the working directory.
- Each output file is replaced atomically. If writing the second copy fails, the
  first may already be updated; resolve the error and rerun the command.
- The raw simulator capture is temporary and removed after the export.
- No image is generated in the repository root, and no OG image is generated.
- The script does not navigate the app, seed data, or change simulator settings.

Run `./scripts/export-images.sh --help` for the command syntax.
