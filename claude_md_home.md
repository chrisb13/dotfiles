# Session rules (local VMs)

## Project folders
- I start each session from a project folder at `~/claudework/<project-name>/` (the launch directory). Always write paths as `~/claudework/...` or relative to the launch directory, never as an absolute `/home/<user>/...` path, because these rules are shared across several virtual machines.
- If a session is launched somewhere other than a folder inside `~/claudework/`, tell me before creating any files.

## File location
- Everything you create during a session (scripts, outputs, notes, logs, scratch files, clones of repositories, build outputs, screenshots) goes inside the launch directory. Use a subfolder such as `./scratch/` or `./outputs/` if it helps.
- This includes temporary files. Don't use `/tmp` or Claude Code's session scratchpad directory, even if a tool or instruction suggests it. If a tool wants a temp dir, point it inside the launch directory (e.g. `TMPDIR=$PWD/tmp`).
- Never write anywhere else under `~` (or elsewhere on the machine) unless I explicitly ask. The exception is Claude Code's own files under `~/.claude/` (memory, settings, this file), which you may edit when I ask.
- If a task seems to require writing outside the launch directory, stop and ask first.

## progress.md
- Maintain `./progress.md` in the launch directory for the whole session. Create it at the start if it doesn't exist.
- If `./progress.md` already exists at session start, read it first and resume from it.
- Update it after every meaningful step, and always before starting anything long-running (a background job, a local server, a big download, a long build) and after it finishes.
- Keep it concise and current, not a transcript. Sections:
  1. **Goal**: what this session is trying to achieve.
  2. **Status**: done / in progress / blocked.
  3. **Next steps**: ordered, specific enough to resume cold.
  4. **Key paths & state**: files created, branches, PR numbers and links, environments activated, background processes and their PIDs or ports, published artifact links.
  5. **Decisions & gotchas**: things learned that would be costly to rediscover.
  6. **Cleanup commands**: see below.

## Deletion
- The launch directory is this session's scratch space. You may delete files and empty directories inside it (use `rm <file>` and `rmdir <dir>`, no `-r`/`-rf`, no wildcards that could escape it). Never delete `progress.md` itself.
- Never delete anything outside the launch directory without my explicit instruction. If something outside needs removing, add it to the cleanup section instead.

## Cleanup record
- In progress.md, keep a "Cleanup commands" section listing the exact commands or steps needed to undo or tidy up anything this session left behind that I should handle:
  - background processes and local servers (`kill <pid>`)
  - pushed branches (`git push origin --delete <branch>`) and open or draft PRs
  - published claude.ai artifacts (their links, to delete from the gallery)
  - anything created outside the launch directory (with my permission)
  - anything inside it I may want to remove after review
- Use full paths written from `~` (e.g. `~/claudework/<project>/...`). Record these commands only; do not run them for items outside the launch directory.
- Add each entry at the moment you create the thing it cleans up.

## Git commits
- All commits must be signed so they show as "Verified" on GitHub: always use `git commit -S` (or rely on `commit.gpgsign=true`). Never use `--no-gpg-sign`, `-c commit.gpgsign=false`, or amend/rebase in a way that drops signatures.
- Author/committer email must be `5499680+chrisb13@users.noreply.github.com`. Before the first commit in any repo, check `git config user.email`; if it differs, set it for that repo only (`git config user.email 5499680+chrisb13@users.noreply.github.com`). Don't change global git config.
- If signing fails (no key, agent unavailable, passphrase prompt), stop and tell me. Do not fall back to an unsigned commit. Signing may not be set up yet on a new VM.
- Local commits are fine without asking.

## Pushing and posting
- Never `git push`, open or update a pull request, or post on GitHub (comments, reviews, @-mentions) or any other external service without my explicit confirmation for that specific action.
- "Make a PR" means prepare it locally (branch, commits, PR description) and show me first.
- Write @-mentions in PR descriptions and comments as plain names (no `@`) unless I say to ping someone.

## GitHub: cloning, gh and PRs
- Clone over SSH (`git clone git@github.com:<owner>/<repo>.git`), not https, because https prompts for a username. If an existing clone uses https, switch it with `git remote set-url origin git@github.com:<owner>/<repo>.git`.
- `gh pr create` only works after the branch has been pushed. If the branch is missing on GitHub, it fails with "Head sha can't be blank ... No commits between main and X ... Head ref must be a branch". Before creating the PR, confirm the branch name (`git branch --show-current`) and that it is on GitHub (`git ls-remote origin <branch>`).
- When you give me commands to run myself, chain the dependent steps with `&&` (or `set -e`) so they stop at the first failure, and include a check that the push landed before the PR step.
- Branches for issue work start with the issue number: `<N>-short-description`.

## Python environments
- Use micromamba for Python environments. Run commands in an environment with `micromamba run -n <name> <command>`.
- There is usually an existing environment called `mkdoc` (MkDocs and common docs tooling), which you can use for docs builds and light Python work. Check it exists with `micromamba env list`, since it may be missing on a new VM.
- Don't install packages into `mkdoc` or `base` without asking.
- If a task needs many new packages, create a new environment inside the launch directory (e.g. `micromamba create -p ./envs/<name> ...`, then `micromamba run -p ./envs/<name> <command>`), and add `micromamba env remove -p ~/claudework/<project>/envs/<name>` to the cleanup section.

## Figshare
- Never push, upload, publish or modify anything on Figshare, by any route (the Figshare API or tokens, or any script whose job is to upload). If you're unsure whether a command touches Figshare, stop and ask.

## Previews
- Build previews (e.g. `mkdocs build`) into a folder inside the launch directory.
- Don't leave a preview server running unless I ask. If you start one, record its PID or port and the command to stop it in progress.md.
- Check previews against the real site's styling, not a stand-in. A mock with different CSS can hide real rendering problems.
