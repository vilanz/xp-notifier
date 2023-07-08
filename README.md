# xp-notifier

A PAYDAY 2 mod that shows notifications for EXP gains during a mission.

[Get it in ModWorkshop](https://modworkshop.net/mod/28247)

## Generating assets for releases

Run `./release-scripts/create-assets.sh`. It's Windows-only because the BLT Hasher is Windows-only.

It will produce:

- `XpNotifier/`: mod files, drop it in your `/mods` folder to test it in-game
- `XpNotifier.zip`: zipped mod files, should be published in the GitHub release
- `meta.json`: auto-updater configuration, should be published in the GitHub release for auto-updates
