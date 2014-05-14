#!/bin/bash

#set -vx
export LANGUAGE=C
export LC_ALL=C
export LANG=C

export CPUSall="$(cat /proc/cpuinfo|grep proc|wc -l)"
export CPUS=$(( $CPUSall - 2 ))

BASE="WiBed"
./set_environment.sh

GIT_BRANCH="$(cd feeds/wibed/ && git rev-parse --abbrev-ref HEAD)"
GIT_HASH="$(echo $(cd feeds/wibed/ && git rev-parse HEAD) | awk '{print substr($0,0, 8)}')"
VERSION="${GIT_BRANCH}.$GIT_HASH"

rename() {
	echo "Renaming binaries"
	for D in bin/*; do
		rm -f $D/${BASE}.*
		for f in $D/*.bin; do
			newname="$(echo $f | sed s/openwrt/$BASE.$VERSION/g)"
			mv $f $newname
			echo "$newname"
		done
		for f in $D/*.gz; do
                       newname="$(echo $f | sed s/openwrt/$BASE.$VERSION/g)"
                       mv $f $newname
                       echo "$newname"
               done
	done
	echo "Done!"
}

make -j$CPUS V=s
[ $? -eq 0 ] && rename

