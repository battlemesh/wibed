#!/bin/bash

error() {
	echo "<ERROR>:  $@"
	exit 1
}

TARGET=${1-ar71xx}
#TARGET=${1-mpc85xx}
[ ! -d configs/$TARGET ] && error "Target '${TARGET}' does not exist"

echo "Updating feeds"
scripts/feeds update -a
scripts/feeds install -a

echo ""
echo "Target selected '${TARGET}'"

echo "Copying target '${TARGET}' config"
cp -f configs/$TARGET/config .config || error "Config for this target (${TARGET}) does not exist"

echo "Expanding config"
make defconfig

echo ""
echo "Copying files (if exist)"
[ ! -e files ] && mkdir files
[ -d configs/$TARGET/files ] && cp -rf configs/$TARGET/files/* files/ 2>/dev/null

echo ""
echo "You can compile it with 'make V=99'"
