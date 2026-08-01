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
- Before pushing commits to a remote or updating an existing PR, run the repose formatter or fix command if one exists, and it is relevant to the files changed.
- When I ask you to carry a PR through Codex review, you may post add `@codex review` comments on the PRs and scope after each pushed head SHA without asking for separate confirmation. Keep this exception narrow: it only covers requesting Codex bot review, not replying to humans or making substantive GitHub comments on my behalf.
- Before resolving a thread authored by the `@codex review` bot, reply in that thread with the reason for resolving it. State whether the feedback was addressed and how, is not relevant and why, or is intentionally deferred or out of scope for the PR and why. Then resolve the thread. This permission applies only to `@codex review` threads. It does not authorize replies to human reviewers.

## Documentation

- When a project has a `docs/` directory, treat it as the authoritative source of truth for planning and design. If the implementation intentionally drifts, update the existing docs accordingly.
- For a new project without an established documentation structure, use `docs/` as the default location for planning and design documentation.

## Long-running commands

- Run long-lived foreground processes such as dev servers and watchers in a named `tmux` session when `tmux` is available. Reuse an existing session for the same checkout before creating another, and state the session name so I can attach to it.

## AGENTS.md Defaults

- If I say "edit AGENTS.md" or "add a not to AGENTS.md" without naming a repo-specific file, default to editing `~/.codex/AGENTS.md`.
- Only choose a repo-local `AGENTS.md` by default when I clearly mean instructions scoped to that repo or subproject.

## Generated Artifacts

- Treat generated files as generator-owned by default.
- Do not hand-edit generated artifacts in general unless I explicitly ask for that escape hatch.
- Instead, find the source of truth, update the source files, and run the proper regeneration step.
- If a regenerated file is stale, regenerate it from its source of truth. If regeneration still produces incorrect output, fix the generator path rather than hand-editing the result.

## Language & Behavior

- Explain things simply, from first principles, without assuming existing context. Short, terse, jargony language is deeply unhelpful. Use a Paul Graham-esque style of extremely clear communication with simple words and good structure.
- Avoid negative-first explanations. Do not introduce an idea by listing what it is not, what system it avoids, or what edge case it excludes. First say what it is, who uses it, where it lives, and what happens next. Use contrasts sparingly, only later in an explanation and when you have extremely high conviction they are the best way to explain a concrete decision.
  - Bad: "This is not a public file URL. It is not a login session. It is just a temporary access token."
  - Good: "A signed download link grants temporary access to one private file. The application creates the link with the file id and an expiry time, then sends it to the user. When the user opens it, the download service verifies the signature and expiry before returning the file. Unlike a login session, the link authorizes only that file and works without loading the user’s account."
  - Bad: "This is not a React rendering bug. It is not a stale closure. It is not the query cache returning bad data. It is the route id getting changed before the save finishes."
  - Good: "The save is using the wrong route id. The user clicks save on route A. Before the save request finishes, the app navigates to route B. The save completion handler reads the current route id, so it writes route B into the saved draft."
- When you finish making a change, explain it in a technical-blog-post style. Do the same when making plans for changes. These should be self-reliant units of work that we can reasonably assume will just work.
- Design docs must make decisions. Do not leave core behavior as "decide later," "do X or Y," "if needed," or "depending on product" in the main design path. Pick the behavior to implement, name the helper/type/API to use, and explain the reason. Put alternatives or unresolved questions in a separate `Deliberation notes` or `Open questions` section, while keeping the chosen path explicit in the design section.
- When proposing or implementing state models, prefer one tagged union that carries the needed data over a separate boolean plus value pair. Use direct, literal names like `appOnboardingImpressionsCount` instead of vague names like `eligible` or `firstHero`.
- Treat patch size as a design constraint. Start with the smallest correct change. Do not spend diff budget on drive-by cleanup unless it is needed to make the fix understandable.
- Prefer extending an existing flow over building a parallel one. Add one enum case, one parameter, or one branch to the current path before introducing a second helper stack or result model.
- Prefer invariants over defensive fallbacks. If a route or flow requires a value, treat missing data as an error instead of adding soft fallback behavior.
- Use the smallest control structure that fits the problem. Use `if` when there is one special case. Use `switch` only when there are multiple real branches.
- Do not build a framework for one field. If a feature only needs one query param, one prop, or one extra result case, thread it through directly.
- Minimize new names. New helpers, files, enums, and types should reduce total complexity, not just move code around.
- Avoid unrelated churn. If an old line is not part of the bug, contract, or readability win, leave it alone.

## Type Design

- Use static types and schema models. Do not use `Any`, casts, duck typing, untyped dictionary shapes, or runtime type checks to work around a typed contract.
- Start with the type that owns the data. Inspect where the value is constructed and validated before changing a consumer.
- Extend the owning type when it can express the new behavior cleanly. Do not create intermediate or consumer-local types that rename, wrap, or duplicate an existing shape.
- Add a new type only when it represents a distinct domain concept, a real boundary, or an invariant that the existing model cannot express. Put it next to the code that owns that concept.
- Trust declared types after schema validation. If a type is inaccurate or too loose, fix the owning model instead of adding defensive checks downstream.
- Avoid defensive typing. Do not add `isinstance`, `getattr`, casts, coercion, or fallback parsing around values already covered by a declared type.
- When external data is necessarily untyped, parse it into a typed model immediately at the boundary.
