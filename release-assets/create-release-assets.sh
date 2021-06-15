set -e

echo "1. Creatimg meta.json"

HASH_OUTPUT_PREFIX="BLT folder hash: "
META_JSON_HASH_PLACEHOLDER="__hash__"

HASH=$(./hash.exe ../ | sed "s/$HASH_OUTPUT_PREFIX//g")
sed "s/$META_JSON_HASH_PLACEHOLDER/$HASH/g" base.meta.json > meta.json

echo "2. Zipping files to be included in build"

echo "Recreating build/XpNotifier folder"
mkdir -p XpNotifier
rm -f XpNotifier/*
cp ../icon.png ../mod.Lua ../mod.txt ../README.md ./XpNotifier

echo "Zipping build/XpNotifier folder"
./7za.exe a XpNotifier.zip ./XpNotifier