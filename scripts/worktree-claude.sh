#!/bin/bash

# Script to create a git worktree and run Claude Code CLI in non-interactive mode
# Usage: ./scripts/worktree-claude.sh <prompt> [new-branch-name] [worktree-path] [-d]

set -e

# Parse arguments
AUTO_DELETE=false
PROMPT_ARG=""
BRANCH_ARG=""
WORKTREE_ARG=""

for arg in "$@"; do
    if [ "$arg" = "-d" ]; then
        AUTO_DELETE=true
    elif [ -z "$PROMPT_ARG" ]; then
        PROMPT_ARG="$arg"
    elif [ -z "$BRANCH_ARG" ]; then
        BRANCH_ARG="$arg"
    elif [ -z "$WORKTREE_ARG" ]; then
        WORKTREE_ARG="$arg"
    fi
done

# Check if prompt is provided
if [ -z "$PROMPT_ARG" ]; then
    echo "Error: Claude Code prompt is required"
    echo "Usage: $0 <prompt> [new-branch-name] [worktree-path] [-d]"
    echo ""
    echo "Arguments:"
    echo "  <prompt>           Required. The prompt string for Claude Code"
    echo "  [new-branch-name]  Optional. Name for the new branch (default: <current-branch>-worktree-<random>)"
    echo "  [worktree-path]    Optional. Path for the worktree (default: ../worktree-<branch-name>)"
    echo "  [-d]               Optional. Auto-delete worktree after Claude Code finishes"
    exit 1
fi

# Get the current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Generate branch name if not provided
if [ -z "$BRANCH_ARG" ]; then
    RANDOM_NUM=$((RANDOM % 101))
    NEW_BRANCH="${CURRENT_BRANCH}-worktree-${RANDOM_NUM}"
    echo "No branch name provided, using: $NEW_BRANCH"
else
    NEW_BRANCH="$BRANCH_ARG"
fi

WORKTREE_PATH="${WORKTREE_ARG:-../worktree-$NEW_BRANCH}"

echo "Creating worktree from branch '$CURRENT_BRANCH' into new branch '$NEW_BRANCH'..."
echo "Worktree path: $WORKTREE_PATH"

# Create the worktree with a new branch based on current branch
git worktree add -b "$NEW_BRANCH" "$WORKTREE_PATH" "$CURRENT_BRANCH"

echo "Worktree created successfully at: $WORKTREE_PATH"

# Copy properties over and navigate to the worktree
cp local.properties "$WORKTREE_PATH/local.properties"

# Copy CLAUDE.md if it exists in the current directory
if [ -f "CLAUDE.md" ]; then
    cp -f CLAUDE.md "$WORKTREE_PATH/CLAUDE.md"
    echo "Copied CLAUDE.md to worktree"
fi

# Navigate to the worktree
cd "$WORKTREE_PATH"

echo "Running Claude Code in non-interactive mode..."
echo "Prompt: $PROMPT_ARG"

# Run Claude Code in non-interactive mode with scoped permissions
# Allowed: git, gradle, adb, and standard file operations
# Denied: dangerous git operations (force push, hard reset)
claude -p "$PROMPT_ARG" \
  --allowedTools "Bash(git:*)" "Bash(./gradlew:*)" "Bash(gradle:*)" "Bash(adb:*)" "Bash(ls:*)" "Bash(mkdir:*)" "Bash(cp:*)" "Bash(mv:*)" "Read" "Edit" "Write" "Glob" "Grep" \
  --disallowedTools "Bash(git push --force:*)" "Bash(git push -f:*)"

echo "Claude Code finished."

# Auto-delete worktree if flag is set
if [ "$AUTO_DELETE" = true ]; then
    echo "Auto-delete enabled. Cleaning up worktree..."
    cd -
    git worktree remove "$WORKTREE_PATH"
    git branch -D "$NEW_BRANCH"
    echo "Worktree and branch '$NEW_BRANCH' deleted successfully."
else
    echo "Worktree preserved at: $WORKTREE_PATH"
    echo "To manually remove later, run:"
    echo "  git worktree remove $WORKTREE_PATH"
    echo "  git branch -D $NEW_BRANCH"
fi

echo "Done!"

