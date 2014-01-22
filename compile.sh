#!/bin/bash

BASE="WiBed"
GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
GIT_HASH="$(echo $(git rev-parse HEAD) | awk '{print substr($0,0, 8)}')"
VERSION="${GIT_BRANCH}.$GIT_HASH"

rename() {
	echo "Renaming binaries"
	for D in bin/*; do
		for f in $D/*.bin; do
			newname="$(echo $f | sed s/openwrt/$BASE.$VERSION/g)"
			mv $f $newname
			echo "$newname"
		done
	done
	echo "Done!"
}

./set_environment.sh

make -j4
[ $? -eq 0 ] && rename


