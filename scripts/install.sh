#!/bin/sh

# Install Treadmill from prepared wheel cache.
#
# Before running the script, run scripts/setup_wheel_cache.sh, which will
# create wheel cache based on project requirements. Defaults to ~/wheels.
#

while getopts "w:" OPT; do
    case "${OPT}" in
        w)
            WHEELS_DIR=${OPTARG}
            ;;
    esac
done
shift $((OPTIND-1))

if [ "$WHEELS_DIR" = "" ]; then
    WHEELS_DIR=~/wheels/
fi

pip install                   \
    -f $WHEELS_DIR            \
    --no-cache-dir            \
    --no-index                \
    kazoo[sasl]==2.4.0.dev0

pip install                   \
    -f $WHEELS_DIR            \
    --no-cache-dir            \
    --no-index                \
    -r test-requirements.txt

pip install                   \
    -f $WHEELS_DIR            \
    --only-binary             \
    --no-cache-dir            \
    --no-index                \
    $*
