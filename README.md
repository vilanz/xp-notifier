# xp-notifier

This is a simple PAYDAY 2 mod that'll log hidden EXP gains during a mission.

[Get it in ModWorkshop](https://modworkshop.net/mod/28247)

## Installing the mod

Just extract `XpNotifier.zip` (from the latest published release in GitHub) to your `mods/` folder.

## Generating assets for releases

Run `./release-assets/create-assets.sh` and it'll create a `meta.json` (for ingame auto-updater) and `XpNotifier.zip` (for the mod files itself).
It only works on Windows due to the BLT Hasher being Windows-only. This could be made into a GitHub Action...
