#!/usr/bin/env bash
# VPM install script
# Usage: bash for-coders/install.sh
# Installs VPM hooks and wiring into the current project.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "VPM installer"
echo "Project root: $PROJECT_ROOT"
echo ""

# ---------------------------------------------------------------------------
# 1. Make scripts executable
# ---------------------------------------------------------------------------
chmod +x "$SCRIPT_DIR/scripts/check_gates.sh"
chmod +x "$SCRIPT_DIR/hooks/session_start.sh"
echo "[ok] Scripts made executable"

# ---------------------------------------------------------------------------
# 2. Copy AGENTS.md to project root (if not already there)
# ---------------------------------------------------------------------------
if [ ! -f "$PROJECT_ROOT/AGENTS.md" ]; then
  cp "$SCRIPT_DIR/AGENTS.md" "$PROJECT_ROOT/AGENTS.md"
  echo "[ok] AGENTS.md copied to project root"
else
  echo "[skip] AGENTS.md already exists at project root"
fi

# ---------------------------------------------------------------------------
# 3. Claude Code settings
# ---------------------------------------------------------------------------
CLAUDE_DIR="$PROJECT_ROOT/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

mkdir -p "$CLAUDE_DIR"

if [ ! -f "$SETTINGS_FILE" ]; then
  # Create minimal settings with VPM hooks
  cat > "$SETTINGS_FILE" << 'EOF'
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash for-coders/hooks/session_start.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash for-coders/scripts/check_gates.sh"
          }
        ]
      }
    ]
  }
}
EOF
  echo "[ok] .claude/settings.json created with VPM hooks"
else
  echo "[manual] .claude/settings.json already exists"
  echo "         Merge the following into it:"
  echo "         $SCRIPT_DIR/wiring/claude-settings.snippet.json"
fi

# ---------------------------------------------------------------------------
# 4. Pre-commit hook
# ---------------------------------------------------------------------------
GIT_HOOKS_DIR="$PROJECT_ROOT/.git/hooks"
PRE_COMMIT="$GIT_HOOKS_DIR/pre-commit"

if [ -d "$GIT_HOOKS_DIR" ]; then
  if [ ! -f "$PRE_COMMIT" ]; then
    cp "$SCRIPT_DIR/wiring/pre-commit.snippet.sh" "$PRE_COMMIT"
    chmod +x "$PRE_COMMIT"
    echo "[ok] pre-commit hook installed"
  else
    echo "[manual] pre-commit hook already exists"
    echo "         Merge $SCRIPT_DIR/wiring/pre-commit.snippet.sh into .git/hooks/pre-commit"
  fi
else
  echo "[skip] Not a git repository — skipping pre-commit hook"
fi

# ---------------------------------------------------------------------------
# 5. Run baseline gate check
# ---------------------------------------------------------------------------
echo ""
echo "Running baseline gate check..."
bash "$SCRIPT_DIR/scripts/check_gates.sh" || true

echo ""
echo "Install complete."
echo ""
echo "Next steps:"
echo "  1. Open a new Claude Code session — you should see the VPM preamble"
echo "  2. Run /start-project to initialize PRD and acceptance criteria"
echo "  3. Fill in docs/GOALS.md with your milestone targets"
