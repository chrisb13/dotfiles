set -x

# This file is for fixing some shortcuts and mounting the ccrc datadirs on my
# laptop
mv ~/.config/openbox/lubuntu-rc.xml  ~/.config/openbox/lubuntu-rc.xml.OLD  
openbox --reconfigure

sudo mount -t vboxsf VM_shared_folder mount_win/
sshfs z3457920@cyclone.ccrc.unsw.edu.au:/srv/ccrc ~/ccrc -o ServerAliveInterval=60

