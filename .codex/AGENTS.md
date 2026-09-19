## Commits and PRs

- Keep commits relatively atomic. If a change grows into several independent pieces, ask whether I want to split it into multiple PRs.
- Use Conventional Commit-style prefixes such as `feat:` and `fix:` in commit messages.
- Always open new PRs in draft mode.
- After creating, updating, or pushing changes to a PR, include a direct link to each affected PR in your final response.
- PR descriptions should be standalone artifacts. A reviewer should not need to read our chat, local notes, or hidden context to understand the change.
- PR descriptions should start with a top-level summary that explains the state before the change, what is changing, and why. Link associated materials such as linear issues, Notion design docs, specs, or follow-up PRs when they exist.
- When opening or updating a PR stack, every PR description in the stack should include a `Stack` section. Use a numbered list with links to each PR in order, add a short description of what each PR does, and mark the current PR in bold. Each PR title should include a shared stack name and its position in the stack, e.g., `[Stack] [x/n] Change description`.
- For broad refactors that touch many call sites, include a table listing the important call sites changed and what changed at each one. This is especially important for linked migrations, API shape changes, and function behavior changes.
- For large PRs or PRs where we made important design decisions during the work, include a design decisions section, state the decisions directly, and explain why we chose them.
- In PR descriptions, keep testing notes categorical. Prefer brief entries like `Tests:, targeted tests, smoke tests covering [x, y, z], and CI`. Do not include test failures, blocked test attempts, raw command transcripts, full local command lists, generated file commands, formatter commands, or environment-specific invocation details in the testing section, unless I explicitly ask for them.
- Before pushing commits to a remote or updating an existing PR, run the repo's formatter or fix command if one exists, and it is relevant to the files changed.
- When I ask you to carry a PR through Codex review, you may post `@codex review` comments on the PRs and scope after each pushed head SHA without asking for separate confirmation. Keep this exception narrow: it only covers requesting Codex bot review, not replying to humans or making substantive GitHub comments on my behalf.
- Before resolving a thread authored by the `@codex review` bot, reply in that thread with the reason for resolving it. State whether the feedback was addressed and how, is not relevant and why, or is intentionally deferred or out of scope for the PR and why. Then resolve the thread. This permission applies only to `@codex review` threads. It does not authorize replies to human reviewers.

## Documentation

- When a project has a `docs/` directory, treat it as the authoritative source of truth for planning and design. If the implementation intentionally drifts, update the existing docs accordingly.
- For a new project without an established documentation structure, use `docs/` as the default location for planning and design documentation.

## Long-running commands

- Run long-lived foreground processes such as dev servers and watchers in a named `tmux` session when `tmux` is available. Reuse an existing session for the same checkout before creating another, and state the session name so I can attach to it.

## AGENTS.md Defaults

- If I say "edit AGENTS.md" or "add a note to AGENTS.md" without naming a repo-specific file, default to editing `~/.codex/AGENTS.md`.
- Only choose a repo-local `AGENTS.md` by default when I clearly mean instructions scoped to that repo or subproject.

## Generated Artifacts

- Treat generated files as generator-owned by default.
- Do not hand-edit generated artifacts in general unless I explicitly ask for that escape hatch.
- Instead, find the source of truth, update the source files, and run the proper regeneration step.
- If a regenerated file is stale, regenerate it from its source of truth. If regeneration still produces incorrect output, fix the generator path rather than hand-editing the result.

## Language

- Use plain language over jargon, and reference technical details only to the degree that it helps illustrate an idea or your work to the user. Communicate complex concepts in a clear and cohesive manner, and calibrate your writing to the level of background knowledge assumed from the user's prompt and context.
- Avoid using slop words or phrases like "Bottom Line:" in conclusions, "delve," "foster," "leverage," "it's worth noting," "importantly," "Question? Answer." or "This isn't about X. It's about Y.", "genuinely" or hyphenated compound descriptions and adjectives. Do not use concluding summary statements such as "In short:..", "The simplest mental model is:...".
- State the intended action directly. Avoid adding what you won't do, what will remain unchanged, or how you'll separate or categorize results. Do not use contrastive framing such as "X, not Y" or "X—not Y" that introduces an unprompted alternative that the user didn't ask about. Avoid invented compound labels like "exact-head checks" and "editorial-row layouts", vague qualifiers, and canned transitions; use plain verbs and prepositions to state the actual relationship directly.

## Behavior

- Treat patch size as a design constraint. Start with the smallest correct change. Do not spend diff budget on drive-by cleanup unless it is needed to make the fix understandable.
- Prefer extending an existing flow over building a parallel one. Add one enum case, one parameter, or one branch to the current path before introducing a second helper stack or result model.
- Prefer invariants over defensive fallbacks. If a route or flow requires a value, treat missing data as an error instead of adding soft fallback behavior.
- Use the smallest control structure that fits the problem. Use `if` when there is one special case. Use `switch` only when there are multiple real branches.
- Do not build a framework for one field. If a feature only needs one query param, one prop, or one extra result case, thread it through directly.
- Minimize new names. New helpers, files, enums, and types should reduce total complexity, not just move code around.
- Avoid unrelated churn. If an old line is not part of the bug, contract, or readability win, leave it alone.

## Testing

- Do not write tests for reversible, low-impact changes that mirror the implementation. If you do choose to verify your work with tests, make sure that the tests are meaningful and necessary to verify implementation.
- Run tests appropriate to the change and complete required checks. Once those pass, broaden or repeat testing only when new changes, failures, or unresolved concerns justify it; otherwise, continue toward completing the task.
