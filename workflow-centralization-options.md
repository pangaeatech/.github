# Options to Minimize GitHub Actions Workflow Repetition

## Context
This repository already provides reusable workflows and workflow templates, but repositories that consume all templates still repeat configuration values (`rm_url`, `rm_project_id`, trigger blocks, etc.) and must copy trigger changes into every repository.

## Option 1: Keep Using Workflow Templates Per Repository (Current Model)
Each repository creates `.github/workflows/*.yml` files from templates and edits values in place.

### Pros
- Simple and familiar.
- Fully flexible per repository.
- No platform constraints beyond standard GitHub Actions.

### Cons
- Highest duplication within each repository.
- Trigger changes (`on:`) must be updated in every repository.
- Drift is common as repositories diverge over time.

---

## Option 2: Reusable Workflows + Organization/Repository Variables (Recommended Baseline)
Keep most logic and trigger handling in this central `.github` repository reusable workflows, and make per-repository workflow files as thin wrappers that mostly call `uses: pangaeatech/.github/.github/workflows/...@<ref>`. Move repeated values to `vars`/`secrets` (org-level where possible).

### Pros
- Centralized workflow logic and easier maintenance.
- Strong reduction in repeated parameters (use `vars.RM_URL`, `vars.RM_PROJECT_ID`, etc.).
- Repositories keep only thin entrypoints.
- Works with existing reusable workflow model.

### Cons
- Caller workflows still need minimal local files and local `on:` triggers.
- Trigger changes are not fully centralized unless combined with another mechanism.
- Requires governance for `@main` vs pinned refs.

---

## Option 3: Add a Single "Meta" Caller Workflow Per Repository
Instead of many template workflows per repository, create one local workflow that handles all relevant events and fans out into the shared reusable workflows via jobs/conditions.

### Pros
- Big reduction in per-repository file count.
- Trigger definitions are centralized within one file per repository.
- Easier repository-level customization than many independent workflow files.

### Cons
- Still one local file per repository that must be updated for trigger changes.
- Can become a large, complex dispatcher workflow.

---

## Option 4: GitHub Required Workflows (If Available in Your GitHub Plan)
Use organization-level required workflows to enforce centrally managed checks across repositories.

### Pros
- Strongest central control and consistency.
- Changes to required workflow behavior are made once and applied broadly.
- Reduces risk of repositories disabling critical automation.

### Cons
- Availability depends on GitHub plan/features.
- Best for required checks; not always a full replacement for all event-driven automation patterns.
- Still may need local workflows for repository-specific behavior.

---

## Option 5: Sync Automation (Bot/Action) for Local Workflow Files
Keep local workflow files but maintain them automatically from this repo using scheduled sync PRs (e.g., a workflow or bot opens PRs to update downstream repos).

### Pros
- Can centrally propagate trigger or template updates.
- Repositories still review and control incoming changes via PR.
- Works even when required workflows are unavailable.

### Cons
- More operational complexity.
- Not instant; updates rely on sync cadence and PR merge speed.
- Consumers can still drift between syncs.

---

## Option 6: Composite Actions for Shared Steps + Local Workflows
Move repeated step logic into composite actions and keep triggers/workflow orchestration local.

### Pros
- Reduces duplicated step scripts.
- Easier versioning of step-level behavior.

### Cons
- Does **not** solve duplicated trigger definitions.
- Less effective than reusable workflows for top-level orchestration duplication.

---

## Best Overall Approach
For minimizing repetition **both within and across many repositories**, the best practical approach is:

1. **Standardize on reusable workflows from this repo (Option 2)**.
2. **Move repeated static values to org-level `vars` and org/repo `secrets`**.
3. **Use one thin caller (or one meta caller) per repository (Option 3)**.
4. **If your GitHub plan supports it, layer on required workflows (Option 4)** for centrally enforced checks.
5. **If required workflows are not sufficient/available, add sync automation (Option 5)** to propagate local trigger-wrapper changes.

This combination gives the lowest long-term maintenance burden while staying compatible with GitHub’s current lack of true GitLab-style remote include.
