set -x

# This file is for fixing some shortcuts and mounting the ccrc datadirs on my

sudo mount -t vboxsf Shared_VB_folder ~/mount_win/
sshfs z3457920@cyclone.ccrc.unsw.edu.au:/srv/ccrc ~/ccrc -o ServerAliveInterval=60

