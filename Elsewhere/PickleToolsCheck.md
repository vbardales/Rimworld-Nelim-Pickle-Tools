# PickleToolsCheck

This is an out-of-repository tooling probe, not a gameplay mod to promote into a shared tool.
Inventory review, 2026-09-22: its suite has features and pass maps, but no local C# source under
`PickleToolsCheck/Tests/Pickle/Source/`.

The maps select the shared tools being exercised, including ClearScreen, InspectTabs, InterfaceScale,
KeyedClick and the lost-click probe. Tool implementations belong to their own PickleTools folders;
the diagnostic probe source belongs to `PickleTools/Upstream/tests/lost-click-probe/`.

Other internal fixtures, including `PickleTools/TextureOwner/evidence/suite/` and
`PickleTools/Upstream/tests/`, are deliberately excluded from the gameplay-suite inventory. Consult
the owning tool's README or `Upstream/PENDING.md` for evidence. No probe was run for this inventory.
