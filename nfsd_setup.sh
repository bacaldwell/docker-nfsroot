#!/bin/bash
set -e

# Docker NFSroot
# Blake Caldwell <blakec@ornl.gov>

# Configure nfs to run. We have our start/stop scripts in /tmp, so 
#  they do not make it to the image. The last piece is to setup
#  /etc/exports.

# Only need to export /, but make it read-only
echo "/ *(ro,no_root_squash,async)" > /etc/exports

/tmp/nfsrootd/nfsd-start
