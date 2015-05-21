Docker NFSroot image server
=====================================

v1.0 May 21, 2015

Copyright 2015 Blake Caldwell
Oak Ridge National Laboratory

This program is licensed under GNU GPLv3. Copy of license in LICENSE
=====================================
Credit goes to cpuguy83 for NFS server in a docker container:
https://github.com/cpuguy83/docker-nfs-server
=====================================

Prerequisites:
----
1. The docker bridge will need to be accessible by nodes in the cluster to boot from a NFSroot
container. Note that this is not the standard docker configuration
2. The PXE comdline will need to have root=dhcp
3. DHCP will need to hand out the root-path option to point to the container. For example
    option root-path  "nfs:xxx.xxx.xxx.xxx:/";

Prepapring the base image:
----

First tar up the image (e.g.) ironic-rhel6-diskless.tar and then import the tar file to a docker image.
The docker-nfsroot Dockerfile builds from diskless:rhel6. Change this if needed (e.g. per cluster image)

```
docker import - diskless:rhel6 < ironic-rhel6-diskless.tar
```

Building the NFSroot image serving container:
----
Next build the nfs-server container that is based off of the docker image we just built
```
git clone https://github.com/bacaldwell/docker-nfsroot.git
cd docker-nfsroot
docker build -t nfs-server .
```

Starting the container:
----
Start the container in daemon mode. It will start nfsd and tail /var/log/messages in the
foreground
```
docker run -d --name $image --privileged nfs-server
```

Run "docker ps $image" to verify the container was started. 

Now / within the container, which is the root of the tarball, will be exported via nfs.
To get the ip of the server, run "docker inspect $image".

Modifying the container once started:
----
To get a tty in the container, one way is to use nsenter. The problem with this is that iti
doesn't drop capabilities. If that is a concern, the recommended way is to use nsinit:
[Blog on nsenter and nsinit](http://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/)

The utility for either is for an admin user to make changes to the image that will get 
propogated to diskless nodes that have it bind mounted as '/'.

```
PID=$(docker inspect --format '{{.State.Pid}}' $image)
nsenter --target $PID --mount --uts --ipc --net --pid
```
