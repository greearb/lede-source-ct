#!/usr/bin/env bash

USAGE=$( cat <<EOF
Usage:\n
# -t:  Target\n
# -d:  Save current .config as diffconfig for the specified target.\n
# -l:  List available targets.\n
# -f:  Skip feeds (useful on rebuild)\n
# -j:  Compile jobs (default is 8)\n
# -h:  Show help and exit\n
#\n
#\n
# Example:  Build an image for x86_64
#  ./buildme.sh -t x86_64\n
EOF
)

BMT=buildme_targets
TARGET=UNKNOWN
LIST_TARGETS=0
SKIP_FEEDS=0
JOBS=8
SET_DIFF=0

while getopts "t:j:dlfh" flag
  do
  case $flag in
      d) SET_DIFF=1;;
      t) TARGET=$OPTARG;;
      l) LIST_TARGETS=1;;
      f) SKIP_FEEDS=1;;
      j) JOBS=$OPTARG;;
      h) echo -e USAGE && exit 0;;

      *) echo "Un-known option: $flag"; echo -e $USAGE;exit 1;;
  esac
done

if [ $LIST_TARGETS == 1 ]
then
    ls $BMT
    exit 0
fi

echo "Target dir: $BMT/$TARGET"

if [ ! -d $BMT/$TARGET ]
then
    echo "ERROR:  Unknown target, try -l option?"
    exit 1;
fi

if [ $SET_DIFF == 1 ]
then
    ./scripts/diffconfig.sh > $BMT/$TARGET/diffconfig.txt
    exit 0;
fi

set -x

if [ $SKIP_FEEDS != 1 ]
then
    # Update feeds
    ./scripts/feeds update -a || exit 1

    # Enable luci web interface
    ./scripts/feeds install -d y luci || exit 1

    # Enable ethtool for driver info and stats and such
    ./scripts/feeds install -d y ethtool || exit 1
fi

# Copy default config into place
cp $BMT/$TARGET/diffconfig.txt .config || exit 1

# Build complate .config file based on whatever is latest, etc.
make defconfig || exit 1

# Build
make v=S -j $JOBS || exit 1

# Try to figure out where the images are at.
set +x
. .config > /dev/null 2>&1
echo "Images may be found at: bin/targets/$CONFIG_TARGET_BOARD/$CONFIG_TARGET_SUBTARGET/"
