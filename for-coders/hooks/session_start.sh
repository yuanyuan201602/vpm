#!/usr/bin/env bash
# VPM SessionStart hook — fires at the start of every Claude Code session
# Injects project context and runs a quick gate pre-check.

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  VPM — Verified Project Management"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Show current PRD and acceptance versions
PRD_FILE=$(ls docs/PRD_*.md 2>/dev/null | sort -V | tail -1 || echo "")
ACC_FILE=$(ls docs/ACCEPTANCE_*.md 2>/dev/null | sort -V | tail -1 || echo "")

if [ -n "$PRD_FILE" ]; then
  echo "  PRD:         $PRD_FILE"
else
  echo "  PRD:         [not found — run /start-project]"
fi

if [ -n "$ACC_FILE" ]; then
  echo "  Acceptance:  $ACC_FILE"
else
  echo "  Acceptance:  [not found]"
fi

# Show active milestone from GOALS.md
if [ -f "docs/GOALS.md" ]; then
  ACTIVE=$(grep -m1 '待执行\|in.progress\|当前' docs/GOALS.md | sed 's/^[[:space:]]*//' | head -c 80 || echo "")
  if [ -n "$ACTIVE" ]; then
    echo "  Active:      $ACTIVE"
  fi
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Non-blocking gate check (summary only)
if [ -f "for-coders/scripts/check_gates.sh" ]; then
  bash for-coders/scripts/check_gates.sh 2>/dev/null || echo "[WARNING] One or more VPM gates are failing. Run: bash for-coders/scripts/check_gates.sh"
fi
