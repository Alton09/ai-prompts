# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a collection of reusable AI prompts and automation scripts for software development workflows. The prompts are designed to be copied/pasted into AI assistants, with blank placeholders (`_____`) that users fill in with their specific values.

## Structure

- **Prompt files** (`*_prompts.md`): Markdown files containing templated prompts with HTML comments explaining their purpose
- **Scripts** (`scripts/`): Shell scripts for git worktree automation with AI tools

## Prompt Format Conventions

Prompts use the following patterns:
- Blank placeholders (`_____`) indicate values the user must provide (e.g., branch names, issue numbers, repository names)
- HTML comments (`[//]: #` or `<!-- -->`) describe the prompt's purpose and usage
- Multiple related prompts may be grouped in a single file, separated by comments

## Available Scripts

- `scripts/worktree-auggie.sh` - Creates a git worktree and runs auggie CLI with a prompt. Usage: `./scripts/worktree-auggie.sh <prompt> [branch-name] [worktree-path] [-d]`
- `scripts/build-and-install.sh` - Builds and installs an Android app using a temporary worktree (project-specific)
