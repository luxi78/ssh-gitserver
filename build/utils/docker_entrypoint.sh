#!/bin/bash
set -e

# This script designed to be used a docker ENTRYPOINT "workaround" missing docker
# feature discussed in docker/docker#7198, allow to have executable in the docker
# container manipulating files in the shared volume owned by the USER_ID:GROUP_ID.
#
# It creates a user named `sshserver` with selected USER_ID and GROUP_ID (or
# 1000 if not specified).

# Example:
#
#  docker run -ti -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) imagename bash
#

# Reasonable defaults if no USER_ID/GROUP_ID environment variables are set.
if [ -z ${USER_ID+x} ]; then USER_ID=1000; fi
if [ -z ${GROUP_ID+x} ]; then GROUP_ID=1000; fi

msg="docker_entrypoint: Creating user UID/GID [$USER_ID/$GROUP_ID]" && echo $msg
groupadd -g $GROUP_ID -r git && \
useradd -u $USER_ID --create-home -r -g git git 
echo 'git:git-repo' |chpasswd
echo "$msg - done"

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="bash"
fi

# Execute command as `aosp` user
export HOME=/home/git
#exec sudo -E -u aosp $args
exec $args
