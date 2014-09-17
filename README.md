Docker NFSroot image server
================
Modified by: Blake Caldwell <blakec@ornl.gov>

Prepapring image:
----
See https://rdteam.ornl.gov/farm/cades/doku.php/infra:ironic_nfsroot_docker

First tar up the image to ironic-rhel6-pfs-diskless.tar and then import the tar file to a Docker image.
The docker-nfsroot Dockerfile builds from diskless:rhel6. Change this if needed (e.g. per cluster image)

```
image=prod_diskless
docker import - diskless:rhel6 < ironic-rhel6-pfs-diskless.tar
git clone https://git.ornl.gov/blakecaldwell/docker-nfsroot.git
cd docker-nfsroot
docker build -t nfs-server .
docker run -d --name $image --priviledged nfs-server
```

Run 'docker ps' to verify the container was started and get the tag

Now / within the container, which is the root of the tarball, will be exported via nfs.
To get the ip of the server, run 'docker inspect [tag]'. To configure nfsroot via dhcp
add the root-path option (ISC) to the host definition. For example:
  option root-path  "nfs4:xxx.xxx.xxx.xxx:/";
