#!/bin/bash

if [ -f floppy01.img ]; then
  rm -f floppy01.img
fi

vagrant up

scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../../templates/windows-2003R2-serverenterprise-amd64/winnt.sif vagrant@localhost:/home/vagrant/winnt.sif
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../regedit.bat vagrant@localhost:/home/vagrant/regedit.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../runonce.bat vagrant@localhost:/home/vagrant/runonce.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../openssh.ps1 vagrant@localhost:/home/vagrant/openssh.ps1
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../ps.bat vagrant@localhost:/home/vagrant/ps.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../downloadFile.vbs vagrant@localhost:/home/vagrant/downloadFile.vbs

vagrant ssh -c "sudo dd bs=512 count=2880 if=/dev/zero of=floppy01.img"
vagrant ssh -c "sudo mkfs.msdos floppy01.img"
vagrant ssh -c "sudo mount -o loop floppy01.img /mnt"
vagrant ssh -c "sudo cp winnt.sif /mnt/winnt.sif"
vagrant ssh -c "sudo cp regedit.bat /mnt/regedit.bat"
vagrant ssh -c "sudo cp runonce.bat /mnt/runonce.bat"
vagrant ssh -c "sudo cp openssh.ps1 /mnt/openssh.ps1"
vagrant ssh -c "sudo cp ps.bat /mnt/ps.bat"
vagrant ssh -c "sudo cp downloadFile.vbs /mnt/downloadFile.vbs"
vagrant ssh -c "sudo chown root:root /mnt/*.*"
vagrant ssh -c "sudo umount /mnt"

scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 vagrant@localhost:/home/vagrant/floppy01.img .

vagrant destroy -f
