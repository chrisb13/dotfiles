# Session rules (NCI Gadi)

## File location
- Everything you create during a session (scripts, outputs, notes, logs, scratch files, PBS scripts) goes inside the directory Claude was launched from (the working directory at session start). Use a subfolder such as `./scratch/` or `./outputs/` if it helps.
- Never write to /tmp, $HOME, /scratch, or any other /g/data path unless I explicitly ask. If a tool wants a temp dir, point it inside the working directory (e.g. `TMPDIR=$PWD/tmp`).
- If a task seems to require writing outside the working directory, stop and ask first.

## progress.md
- Maintain `./progress.md` in the launch directory for the whole session. Create it at the start if it doesn't exist.
- If `./progress.md` already exists at session start, read it first and resume from it.
- Update it after every meaningful step, and always before starting anything long-running (qsub, a big copy, a long build) and after it finishes.
- Keep it concise and current, not a transcript. Sections:
  1. **Goal**: what this session is trying to achieve.
  2. **Status**: done / in progress / blocked.
  3. **Next steps**: ordered, specific enough to resume cold.
  4. **Key paths & state**: files created, branches, modules loaded, PBS job IDs and their status, important env vars.
  5. **Decisions & gotchas**: things learned that would be costly to rediscover.
  6. **Cleanup commands**: see below.

## Deletion
- The launch directory is this session's scratch space. You may delete files and empty directories inside it (use `rm <file>` and `rmdir <dir>`, no `-r`/`-rf`, no wildcards that could escape it). Never delete `progress.md` itself.
- Never delete anything outside the launch directory, anywhere on /g/data (including ol01 and tm70 shares), without my explicit instruction. If something outside needs removing, add it to the cleanup section instead.

## Cleanup record
- In progress.md, keep a "Cleanup commands" section listing the exact commands needed to undo or tidy up anything this session left behind that I should handle: queued/running PBS jobs (`qdel <id>`), test branches or remotes, anything created outside the launch directory (with my permission), and anything inside it I may want to remove after review.
- Use full explicit paths. Record these commands only; do not run them for items outside the launch directory.
- Add each entry at the moment you create the thing it cleans up.

## Git commits
- All commits must be signed so they show as "Verified" on GitHub: always use `git commit -S` (or rely on `commit.gpgsign=true`). Never use `--no-gpg-sign`, `-c commit.gpgsign=false`, or amend/rebase in a way that drops signatures.
- Author/committer email must be `5499680+chrisb13@users.noreply.github.com`. Before the first commit in any repo, check `git config user.email`; if it differs, set it for that repo only (`git config user.email 5499680+chrisb13@users.noreply.github.com`). Don't change global git config.
- If signing fails (no key, agent unavailable, passphrase prompt), stop and tell me. Do not fall back to an unsigned commit.
- Don't push unless I ask.

## GitHub: cloning, gh and PRs
- Clone over SSH (`git clone git@github.com:<owner>/<repo>.git`), not https, because https prompts for a username. If an existing clone uses https, switch it with `git remote set-url origin git@github.com:<owner>/<repo>.git`.
- `gh` is not on PATH. Load it with `module use /g/data/vk83/modules && module load gh`.
- `gh pr create` only works after the branch has been pushed. If the branch is missing on GitHub, it fails with "Head sha can't be blank ... No commits between main and X ... Head ref must be a branch". Before creating the PR, confirm the branch name (`git branch --show-current`) and that it is on GitHub (`git ls-remote origin <branch>`).
- When you give me commands to run myself, chain the dependent steps with `&&` (or `set -e`) so they stop at the first failure, and include a check that the push landed before the PR step.
- Branches for issue work start with the issue number: `<N>-short-description`.
- On compute nodes, the vk83 spack `ssh-keygen` used for commit signing can crash with "died of signal 4". If that happens, stop and tell me. Committing from a login node works.

## Figshare and previews
- Never push, upload, publish or modify anything on Figshare, by any route (pushit without `--skip-figshare`, the Figshare API or tokens, or any script whose job is to upload). If you're unsure whether a command touches Figshare, stop and ask.
- Previews are fine. Use the `mkfigs` preview tools from https://github.com/ACCESS-NRI/access-model-mkfigs:
  - `mkfigs-preview [--ename ENAME] [--preview-dir DIR] [REPO]` builds the site offline (it passes `--skip-figshare` to pushit itself). Always pass `--preview-dir` pointing inside the launch directory. Don't use `--serve` unless I ask, since it blocks the session; if I do ask, tell me how to port-forward to it.
  - `mkfigs-preview-branch --fork git@github.com:chrisb13/<FORK>.git [REPO]` prepares a local `preview/...` branch. It never pushes. Only ever use my own fork, never an organisation repo.
- Give me the push command that `mkfigs-preview-branch` prints, but do not run it. Never merge a `preview/` branch.
- `mkfigs-preview-branch` has no output-dir option and writes to `<REPO>-preview-branch/` next to the repo, outside the launch directory. This is the one allowed exception to the file-location rule. Record `<REPO>-preview-branch/` in the progress.md cleanup section as soon as it is created, along with the remote cleanup command `git push <FORK_URL> --delete preview/<NAME>`. Do not run either.
