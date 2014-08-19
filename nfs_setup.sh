#!/bin/bash

set -e

mounts="${@}"

for mnt in "${mounts[@]}"; do
  src=$(echo $mnt | awk -F':' '{ print $1 }')
  echo "$src *(ro,no_root_squash,async)" >> /etc/exports
done

/tmp/nfs/nfs.init
