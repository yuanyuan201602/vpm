#!/usr/bin/env bash
# VPM pre-commit hook snippet
# Add to .git/hooks/pre-commit (or merge into existing hook)

# Run VPM gate checks before every commit
if [ -f "for-coders/scripts/check_gates.sh" ]; then
  echo "Running VPM gate checks..."
  bash for-coders/scripts/check_gates.sh
  if [ $? -ne 0 ]; then
    echo ""
    echo "Commit blocked: VPM gates are failing."
    echo "Fix the issues above or use 'git commit --no-verify' to bypass (not recommended)."
    exit 1
  fi
fi
