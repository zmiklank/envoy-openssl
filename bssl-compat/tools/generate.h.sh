#!/bin/bash

set -e # Quit on error
set -x # Echo commands

#function status {
#    cmake -E cmake_echo_color --blue "$1"
#}
#
#function warn {
#    cmake -E cmake_echo_color --yellow "$1"
#}
#
#function error {
#    cmake -E cmake_echo_color --red "$1"
#    exit 1
#}


#
# Get command line args
#
UNCOMMENT_SCRIPT="${1?"UNCOMMENT_SCRIPT not specified"}"
SRC_FILE="${2?"SRC_FILE not specified"}" # e.g. crypto/err/internal.h
DST_FILE="${3?"DST_FILE not specified"}" # e.g. source/crypto/err/internal.h

PATCH_DIR="./bssl-compat/patch"
pwd
ls bssl-compat

#
# Check/Ensure the inputs and outputs exist
#
[ -d "${PATCH_DIR}" ] || error "PATCH_DIR $PATCH_DIR does not exist"
[ -f "${UNCOMMENT_SCRIPT}" ] || error "UNCOMMENT_SCRIPT $UNCOMMENT_SCRIPT does not exist"
[ -f "${SRC_FILR}" ] || error "SRC_FILE $SRC_FILE does not exist"
[ -f "${DST_FILE}" ] || error "DST_FILE $DST_FILE does not exist"
mkdir -p "$(dirname "$DST_FILE")"


#
# Apply script file from $PATCH_DIR
# =================================
#
PATCH_SCRIPT="$PATCH_DIR/$DST_FILE.sh"
GEN_APPLIED_SCRIPT="$DST_FILE.1.applied.script"
cp "$SRC_FILE" "$GEN_APPLIED_SCRIPT"
if [ -f "$PATCH_SCRIPT" ]; then
    PATH="$(dirname "$0"):$PATH" "$PATCH_SCRIPT" "$GEN_APPLIED_SCRIPT"
else # Comment out the whole file contents
    echo "printing"
    $UNCOMMENT_SCRIPT "$GEN_APPLIED_SCRIPT" --comment
fi


#
# Apply patch file from $PATCH_DIR
# ================================
#
PATCH_FILE="$PATCH_DIR/$DST_FILE.patch"
GEN_APPLIED_PATCH="$DST_FILE.2.applied.patch"
if [ -f "$PATCH_FILE" ]; then
    patch -s -f "$GEN_APPLIED_SCRIPT" "$PATCH_FILE" -o "$GEN_APPLIED_PATCH"
else
    cp "$GEN_APPLIED_SCRIPT" "$GEN_APPLIED_PATCH"
fi


#
# Copy result to the destination
# ==============================
#
cp "$GEN_APPLIED_PATCH" "$DST_FILE"
