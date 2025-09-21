---
description: Create N subagents with parallel worktrees to explore solutions, then merge the best approach
argument-hint: <task-description> [--count=N]
allowed-tools: Bash, Task, Read, Write, Edit, Glob, Grep
---

You are orchestrating parallel solution exploration. Parse arguments: extract count (default 3) from --count=N flag, remaining text is the task.

**Phase 1: Setup**

1. Extract task name from description (kebab-case, max 20 chars)
2. Create parent directory `../[task-name]` if it doesn't exist using `mkdir -p ../[task-name]`
3. List parent directory `../[task-name]` to prompt user to add as working directory for session
4. Create N git worktrees using `git worktree add ../[task-name]/[i] -b [task-name]-[i]` from current directory
5. Spawn N Task agents in parallel with subagent_type "developer", each with prompt:
   "cd ../[task-name]/[i] && work here. Task: $ARGUMENTS. Focus on different approach than other agents. Complete implementation with tests. Commit all changes when done."

**Phase 2: Analysis & Merge**

1. After all agents complete, analyze each worktree's committed changes using git log and git diff
2. Compare approaches: performance, maintainability, completeness
3. Decision:

- If one approach is clearly superior, merge it directly.
- If no single approach is decisively best, prepare a concise comparison for the user, recommend the most promising path, and—if beneficial—propose a hybrid plan synthesizing the strongest elements.

4. Apply the chosen or hybrid solution to the current directory (./), not the worktree directories.
5. Run tests to verify

**Phase 3: Cleanup**

1. Remove worktrees with `git worktree remove ../[task-name]/[i]` for each
2. Delete [task-name]-[i] branches with `git branch -D`
3. Prune any stale worktree references with `git worktree prune`
4. Remove the now-empty parent directory with `rmdir ../[task-name]`

Execute phases sequentially. Be concise in agent communication.
