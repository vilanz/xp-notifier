set -e

# set pwd as /release-assets
cd "${0%/*}" 

echo "1. Creatimg meta.json"

HASH_OUTPUT_PREFIX="BLT folder hash: "
HASH=$(./blt-hasher.exe ../src | sed "s/$HASH_OUTPUT_PREFIX//g")
sed "s/__hash__/$HASH/g" base.meta.json > meta.json

echo "2. Zipping game files to XpNotifier.zip"

echo "Zipping src folder"
./7za.exe a XpNotifier.zip ../src