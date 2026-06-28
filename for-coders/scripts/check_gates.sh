#!/usr/bin/env bash
# VPM gate checks — run before any milestone completion claim
# Exit 0: all gates pass. Exit 1: one or more gates failed.

set -euo pipefail

PASS=0
FAIL=1
STATUS=0

check() {
  local name="$1"
  local result="$2"
  if [ "$result" = "pass" ]; then
    echo "[PASS] $name"
  else
    echo "[FAIL] $name"
    STATUS=1
  fi
}

# ---------------------------------------------------------------------------
# Gate 1: PRD and ACCEPTANCE share the same version number
# ---------------------------------------------------------------------------
# grep -oE 'v[0-9]+\.[0-9]+' stops at the minor version so the .md extension's
# dot is not captured (the old 'v[0-9.]*' produced 'v0.1.').
PRD_VER=$(ls docs/PRD_*.md 2>/dev/null | grep -oE 'v[0-9]+\.[0-9]+' | sort -V | tail -1)
ACC_VER=$(ls docs/ACCEPTANCE_*.md 2>/dev/null | grep -oE 'v[0-9]+\.[0-9]+' | sort -V | tail -1)
PRD_VER=${PRD_VER:-none}
ACC_VER=${ACC_VER:-none}

if [ "$PRD_VER" = "none" ] || [ "$ACC_VER" = "none" ]; then
  check "Gate 1: PRD+ACCEPTANCE version parity" "fail (missing files)"
elif [ "$PRD_VER" = "$ACC_VER" ]; then
  check "Gate 1: PRD+ACCEPTANCE version parity ($PRD_VER)" "pass"
else
  check "Gate 1: PRD+ACCEPTANCE version parity (PRD=$PRD_VER, ACC=$ACC_VER)" "fail"
fi

# ---------------------------------------------------------------------------
# Gate 2: No banned words in generated output
# Uncomment and point OUTPUT_DIR at your generated artifacts directory
# ---------------------------------------------------------------------------
# OUTPUT_DIR="output"
# BANNED_WORDS_FILE="for-coders/scripts/banned-words.txt"
# if [ -d "$OUTPUT_DIR" ] && [ -f "$BANNED_WORDS_FILE" ]; then
#   HITS=$(grep -rif "$BANNED_WORDS_FILE" "$OUTPUT_DIR" | wc -l)
#   if [ "$HITS" -eq 0 ]; then
#     check "Gate 2: No banned words in output" "pass"
#   else
#     check "Gate 2: No banned words in output ($HITS hits)" "fail"
#   fi
# else
#   check "Gate 2: No banned words (skipped — no output dir)" "pass"
# fi

# ---------------------------------------------------------------------------
# Gate 3: ACCEPTANCE.md contains a product value line section
# ---------------------------------------------------------------------------
ACC_FILE=$(ls docs/ACCEPTANCE_*.md 2>/dev/null | head -1 || echo "")
if [ -n "$ACC_FILE" ] && grep -q "Product value line" "$ACC_FILE"; then
  check "Gate 3: ACCEPTANCE has product value line section" "pass"
else
  check "Gate 3: ACCEPTANCE has product value line section" "fail"
fi

# ---------------------------------------------------------------------------
# Gate 4: No in-progress artifact is marked with a stale PRD version
# ---------------------------------------------------------------------------
# A LEGACY marker should name the current PRD version, e.g. "[LEGACY - v0.1]".
# A stale marker is any "[LEGACY" line that does NOT reference the current version.
# grep returns non-zero when there are no matches; under pipefail that would abort
# the script, so each grep is guarded with `|| true` and the count is trimmed.
if [ "$PRD_VER" != "none" ]; then
  # Scan project artifacts only — the install kit and PR/issue machinery contain
  # instructional text that *describes* the LEGACY format and must not be flagged.
  STALE=$(grep -rn '\[LEGACY' . --include="*.md" \
    --exclude-dir=for-coders --exclude-dir=.github 2>/dev/null \
    | grep -v "LEGACY - $PRD_VER" \
    | grep -c '' || true)
  STALE=$(printf '%s' "$STALE" | tr -d '[:space:]')
  STALE=${STALE:-0}
  if [ "$STALE" -eq 0 ]; then
    check "Gate 4: No stale LEGACY markers" "pass"
  else
    check "Gate 4: No stale LEGACY markers ($STALE found)" "fail"
  fi
fi

# ---------------------------------------------------------------------------
# Exit
# ---------------------------------------------------------------------------
echo ""
if [ "$STATUS" -eq 0 ]; then
  echo "All gates passed."
else
  echo "One or more gates FAILED. Do not declare milestone complete."
fi

exit "$STATUS"
