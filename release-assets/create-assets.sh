set -e

# set pwd as /release-assets
cd "${0%/*}" 

echo "1. Creatimg meta.json"

echo "Running BLT Hasher..."
HASH_OUTPUT_PREFIX="BLT folder hash: "
HASH=$(./blt-hasher.exe ../src | sed "s/$HASH_OUTPUT_PREFIX//g")

echo "Creating meta.json with hash $HASH..."
sed "s/__hash__/$HASH/g" base.meta.json > meta.json

echo "2. Zipping game files to XpNotifier.zip"

echo "Creating XpNotifier folder..."
mkdir -p XpNotifier
rm -f XpNotifier/*
cp ../src/* ./XpNotifier

echo "Zipping src folder..."
./7za.exe a XpNotifier.zip ./XpNotifier/ > /dev/null

echo "Assets created!"