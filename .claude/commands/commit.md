---
description: Create conventional git commits
argument-hint: [-s]
allowed-tools: Bash(git status:*, git diff:*, git log:*, git branch:*, git show:*, git ls-files:*)
---

Please help me create a conventional commit using the arguments: $ARGUMENTS

## Available Flags
- `-s`: Skip staging (files already staged)

## Process to Follow
1. Run `git status`, `git diff`, `git diff --staged` in parallel to understand current state
2. If no `-s` flag is provided: stage relevant files with `git add`
3. Analyze the changes and create a conventional commit message
4. Execute the commit using heredoc format for proper formatting
5. Run `git status` to confirm the commit succeeded

## Commit Message Format
Use the format: `<type>(<scope>): <description>`

Available types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

## Style Guidelines
- Use present tense, imperative mood
- No period at the end of description
- Keep description to 50 characters maximum
- Follow the existing project's commit message style