Docker NFSroot image server
================
Modified by: Blake Caldwell <blakec@ornl.gov>
Adapted from: https://github.com/cpuguy83/docker-nfs-server

Prepapring image:
----
See https://rdteam.ornl.gov/farm/cades/doku.php/infra:ironic_nfsroot_docker

First tar up the image to ironic-diskless.tar and then import the tar file to a container:

```
docker import - diskless:rhel6 < ironic-diskless.tar
# run will fail without workaround from: https://bugzilla.redhat.com/show_bug.cgi?id=1109855
touch /etc/yum.repos.d/redhat.repo
git clone https://git.ornl.gov/blakecaldwell/docker-nfsroot.git
cd docker-nfsroot
docker build -t nfs-server .
docker run --privileged=true -t -i nfs-server /bin/bash
/tmp/nfs/nfs_setup.sh 
```

It should be possible to enable shares from the command line, but it definitely works by just editing /exports
