#!/bin/bash

rulesConfig=/etc/udev/rules.d/70-persistent-net.rules
exec_lspci=/usr/bin/lspci
exec_reboot=/usr/sbin/reboot
exec_awk=/usr/bin/awk
exec_egrep=/usr/bin/egrep
exec_echo=/usr/bin/echo
exec_cat=/usr/bin/echo

if [ -f $rulesConfig ] ; then
	exit 0
fi

pci_dir=/sys/bus/pci/devices

addToUdevRules() {
	pciId=$1
	hostNic=$2
	gustNic=$3
	${exec_echo} "# HostNic = ${hostNic}" >> $rulesConfig
	${exec_echo} "SUBSYSTEM==\"net\", ACTION==\"add\", KERNELS==\"${pciId}\", DRIVERS==\"?*\", ATTR{type}==\"1\", KERNEL==\"ens*\", NAME=\"${guestNic}\"\n" >> $rulesConfig
}

for bus_name in $(${exec_lspci} | ${exec_egrep} -i 'network|ethernet' | ${exec_awk} '{printf "0000:%s\n",$1}')
do
	dir=${pci_dir}/${bus_name}

	hostNic=$(${exec_cat} ${dir}/label})
	hostNic="Ethernet6"
	guestNic=$(${exec_echo} "eth"${hostNic##Ethernet})
	addToUdevRules ${bus_name} ${hostNic} ${guestNic}	
done

${exec_reboot}
