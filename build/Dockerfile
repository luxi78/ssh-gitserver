FROM rastasheep/ubuntu-sshd:latest
MAINTAINER Martin Lu "luxi78@gmail.com"

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD    ["/usr/sbin/sshd", "-D"]

COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
RUN chmod 755 /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]

VOLUME ["/home/git"]
EXPOSE 22
