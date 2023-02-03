#!/bin/bash

rulesConfig=/etc/udev/rules.d/70-persistent-net.rules

if [ -f $rulesConfig ] ; then
	exit 0
fi

pci_dir=/sys/bus/pci/devices

addToUdevRules() {
	pciId=$1
	hostNic=$2
	gustNic=$3
	echo "# HostNic = ${hostNic}" >> $rulesConfig
	echo "SUBSYSTEM==\"net\", ACTION==\"add\", KERNELS==\"${pciId}\", DRIVERS==\"?*\", ATTR{type}==\"1\", KERNEL==\"ens*\", NAME=\"${guestNic}\"\n" >> $rulesConfig
}

for bus_name in $(lspci | egrep -i 'network|ethernet' | awk '{printf "0000:%s\n",$1}')
do
	dir=${pci_dir}/${bus_name}

	hostNic=$(cat ${dir}/label})
	hostNic="Ethernet6"
	guestNic=$(echo "eth"${hostNic##Ethernet})
	addToUdevRules ${bus_name} ${hostNic} ${guestNic}	
done
