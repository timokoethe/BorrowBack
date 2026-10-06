#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec /usr/bin/xcrun swift -module-cache-path "${TMPDIR:-/tmp}/borrowback-image-module-cache" "$SCRIPT_DIR/export-images.swift" "$@"
