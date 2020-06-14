## Get the CentOS 7 Cloud Image - Found Here - https://cloud.centos.org/centos/7/images/
cd /mnt/pve/NFS_Share_Name/
wget https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1808.qcow2

## Create the Cloud Image Template
qm create 9000 --name CentOS-7-CloudTemplate --memory 1024 --net0 virtio,bridge=vmbr0
qm importdisk 9000 /mnt/pve/NFS_Share_Name/template/iso/CentOS-7-x86_64-GenericCloud-1808.qcow2 PMXShare
qm set 9000 --scsihw virtio-scsi-pci \
   --scsi0 PMXShare:9000/vm-9000-disk-0.raw
qm set 9000 \
   --ide2 PMXShare:cloudinit --boot c \
   --bootdisk scsi0 --serial0 socket \
   --vga serial0 
qm set 9000 \
   --ciuser centos \
   --ipconfig0 ip=dhcp

qm template 9000

## Launching New Instance Based on the template
qm clone 9000 1000 --description Notes_Field

## Set all the relevant variables.
## --name <string>
## --memory <int in MB>
## --cores <int>
## --net0 virtio,bridge=vmbr0,tag=<int>
## --ciuser <string>
## --ipconfig0 ip=dhcp
## --sshkeys ~/provisioning/publicsshkey.pub
qm clone 9000 1000 --description "gitlab server" --full
qm set 1002 --name Gitlab --memory 12288 \
  --cores 4 --net0 virtio,bridge=vmbr0,tag=105 \
  --ciuser centos --ipconfig0 ip=dhcp \
  --sshkeys /mnt/pve/PMXShare/provisioning/danmbp.pub \
  --vga qxl --agent 1
qm resize 1002 scsi0 40G
qm start 1002

qm stop 1000 && qm destroy 1000

Display all 194 possibilities? (y or n)
--acpi              --hostpci3          --ipconfig25        --net1              --net4              --sata2             --skiplock          --virtio0
--agent             --hotplug           --ipconfig26        --net10             --net5              --sata3             --smbios1           --virtio1
--args              --hugepages         --ipconfig27        --net11             --net6              --sata4             --smp               --virtio10
--autostart         --ide0              --ipconfig28        --net12             --net7              --sata5             --sockets           --virtio11
--balloon           --ide1              --ipconfig29        --net13             --net8              --scsi0             --sshkeys           --virtio12
--bios              --ide2              --ipconfig3         --net14             --net9              --scsi1             --startdate         --virtio13
--boot              --ide3              --ipconfig30        --net15             --numa              --scsi10            --startup           --virtio14
--bootdisk          --ipconfig0         --ipconfig31        --net16             --numa0             --scsi11            --tablet            --virtio15
--cdrom             --ipconfig1         --ipconfig4         --net17             --numa1             --scsi12            --tdf               --virtio2
--cipassword        --ipconfig10        --ipconfig5         --net18             --numa2             --scsi13            --template          --virtio3
--citype            --ipconfig11        --ipconfig6         --net19             --numa3             --scsi2             --unused0           --virtio4
--ciuser            --ipconfig12        --ipconfig7         --net2              --numa4             --scsi3             --unused1           --virtio5
--cores             --ipconfig13        --ipconfig8         --net20             --numa5             --scsi4             --unused2           --virtio6
--cpu               --ipconfig14        --ipconfig9         --net21             --numa6             --scsi5             --unused3           --virtio7
--cpulimit          --ipconfig15        --keyboard          --net22             --numa7             --scsi6             --unused4           --virtio8
--cpuunits          --ipconfig16        --kvm               --net23             --onboot            --scsi7             --unused5           --virtio9
--delete            --ipconfig17        --localtime         --net24             --ostype            --scsi8             --unused6           --vmgenid
--description       --ipconfig18        --lock              --net25             --parallel0         --scsi9             --unused7           --vmstatestorage
--digest            --ipconfig19        --machine           --net26             --parallel1         --scsihw            --usb0              --watchdog
--efidisk0          --ipconfig2         --memory            --net27             --parallel2         --searchdomain      --usb1
--force             --ipconfig20        --migrate_downtime  --net28             --protection        --serial0           --usb2
--freeze            --ipconfig21        --migrate_speed     --net29             --reboot            --serial1           --usb3
--hostpci0          --ipconfig22        --name              --net3              --revert            --serial2           --usb4
--hostpci1          --ipconfig23        --nameserver        --net30             --sata0             --serial3           --vcpus
--hostpci2          --ipconfig24        --net0              --net31             --sata1             --shares            --vga
