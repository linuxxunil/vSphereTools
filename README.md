一、解決在vSphere中，CentOS的網卡從ensX修改成ethX，以及網卡開順序與HostOS的不同問題。，例如：<br/>
NIC 1: ens160<br/>
NIC 2: ens161<br/>
NIC 3: ens162<br/>
NIC 4: ens163<br/>

二、安裝方式<br/>
1. cd /opt<br/>
2. git clone https://github.com/linuxxunil/vSphereTools/<br/>
3. rm -rf /etc/udev/rules.d/70-persistent-net.rules<br/>
4. vim /etc/rc.local <br/>
````
/opt/vSphereTools/generate_udev_net_rules.sh<br/>
````
三、此方法不需要使用新增 net.ifnames=0 biosdevname=0 至 /etc/default/grub 。（https://www.thegeekdiary.com/centos-rhel-7-how-to-modify-network-interface-names/）
