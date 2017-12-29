#!/bin/sh

instalar_virtualbox() {
    #echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" | tee /etc/apt/sources.list.d/virtualbox.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
    apt-get update
    # Note: Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade
    apt-get install -y virtualbox-5.2 dkms
}

instalar_virtualbox
