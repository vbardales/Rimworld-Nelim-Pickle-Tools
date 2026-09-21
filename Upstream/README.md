# Upstream: what waits for a merge at Pickle

What we carry for [RimWorks/Rimworld-Pickle](https://github.com/RimWorks/Rimworld-Pickle) while it waits for a
merge: patches against its `main`, the probe features that show they work, and one ledger of what is open,
played, or only an idea. It sits in PickleTools next to the shared steps because it is the same concern: Pickle
as a tool we depend on and extend.

Not a fork: the fork lives at `vbardales/Rimworld-Pickle`, where the branches that become pull requests are
made. This folder is where the work is written down while it is not yet a pull request, or is one that has not
landed.

| Path | What |
|---|---|
| `PENDING.md` | The ledger: every change and idea, its upstream reference, its state, and what proves it |
| `patches/` | Unmerged code as patches against Pickle `main` (`git apply --ignore-whitespace`) |
| `bundles/` | Upstream `main` plus named PRs, built and staged as a mod folder to play a PR before it merges (`make-bundle.sh`, `run-on-bundle.sh`; written by the ArchitectStudio session, see its README) |
| `tests/` | Throwaway features that exercise a patch, kept because the patch is worthless without them |

The launcher and the WSL harness are not here: they live in the monorepo's `scripts/` (`PICKLE-WSL.md`).

## Rules

- Everything in English, commits included.
- A patch enters `patches/` only with the evidence of what it was played against, in `PENDING.md`.
- Nothing goes upstream without Virginie's word: an issue or a pull request is public.
- To test a patch on the WSL machine: apply it to a checkout of Pickle, rebuild the WHOLE solution
  (`dotnet build Pickle.slnx --no-incremental`), check that `Assemblies/` holds the same DLLs as the Workshop
  copy, and pass the folder to `Run-PickleWsl.ps1 -PickleSrc`.
