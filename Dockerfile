FROM diskless:rhel6
RUN mkdir -p /tmp/nfsroot
ADD nfsd-start /tmp/nfsroot/nfsd-start
ADD nfsd-stop /tmp/nfsroot/nfsd-stop
ADD nfsd_setup.sh /tmp/nfsroot/nfsd-setup.sh
RUN chmod 755 /tmp/nfsroot/*

# Logs and state will get written to /var. We want to monitor logs on the host
VOLUME /var/

# open up rpcbind and nfs
EXPOSE 111/udp 2049/tcp

ENTRYPOINT ["/tmp/nfsroot/nfsd_setup.sh"]
