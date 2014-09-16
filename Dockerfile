FROM diskless:rhel6
RUN mkdir -p /tmp/nfs
ADD nfs.init /tmp/nfs/nfs.init
ADD nfs.stop /tmp/nfs/nfs.stop
ADD nfs_setup.sh /tmp/nfs/nfs_setup.sh
RUN chmod 755 /tmp/nfs/*
VOLUME /var/

EXPOSE 111/udp 2049/tcp

#ENTRYPOINT ["/tmp/nfs/nfs_setup.sh"]
