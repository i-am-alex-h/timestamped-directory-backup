#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo 'Usage: ./timestamped-directory-backup.sh' \
        '<directory-to-copy> <copy-into-directory>' >&2
    exit 1
fi

dir_to_copy=${1%/}
sudo chown -R "$USER":"$USER" "$dir_to_copy"

copy_to_dir=$(basename "$dir_to_copy")-$(date +%s)
copy_to_dir=${2%/}/$copy_to_dir
mkdir "$copy_to_dir"

cp -a "$dir_to_copy"/. "$copy_to_dir"

diff --brief --recursive "$dir_to_copy" "$copy_to_dir"
status=$?

[ $status -eq 0 ] && echo SUCCESS "$copy_to_dir" || echo FAILURE! Copied directory differs from original.
