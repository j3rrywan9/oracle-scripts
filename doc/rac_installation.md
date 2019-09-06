# RAC Installation

## Linux

### RHEL

#### Disable iptables and SELinux

```bash
service iptables save
service iptables stop
chkconfig iptables off
```

Edit **/etc/selinux/config**
```
SELINUX=disabled
```

#### Groups and Users

```bash
groupadd oinstall; groupadd dba; groupadd oper
```

#### 12c

```bash
groupadd oinstall; groupadd dba; groupadd oper; groupadd backupdba; groupadd dgdba; groupadd kmdba
```

```bash
useradd -g oinstall -G dba,oper -d /home/oravis -s /bin/bash oravis
```

#### 12c

```bash
useradd -g oinstall -G dba,oper,backupdba,dgdba,kmdba -d /home/oravis -s /bin/bash oravis

passwd oravis
```

# /home/oravis/.bash_profile

export ORACLE_BASE=/u01/app/oravis
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export CRS_HOME=/u01/app/11.2.0/grid

export PATH=$CRS_HOME/bin:$ORACLE_HOME/bin:$PATH:$ORACLE_HOME/OPatch
user=`env |grep USER= | sed -e 's/USER=//'`
host=`hostname| awk -F"." '{print $1}'`
export PS1="${user}@$host:\$PWD-> "

# oraivs_ins.sh

```bash
#!/bin/bash

echo "
session    required     /lib/security/pam_limits.so
" >>/etc/pam.d/login
echo "
kernel.shmall = 2097152
kernel.shmmax = 4294967295
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
fs.file-max = 6815744
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
" >>/etc/sysctl.conf
sysctl -p
echo "
oravis soft nproc 2047
oravis hard nproc 16384
oravis soft nofile 1024
oravis hard nofile 65536
oravis soft stack 10240
" >>/etc/security/limits.conf
```

#### visudo

```
Defaults:oravis !requiretty
oravis ALL=NOPASSWD:/bin/mount, /bin/umount, /bin/mkdir, /bin/rmdir, /bin/ps
```

#### Raw Devices

```bash
fdisk /dev/sdc
fdisk /dev/sdd
fdisk /dev/sde
```

# /etc/udev/rules.d/60-raw.rules

ACTION=="add", KERNEL=="sdc1", RUN+="/bin/raw /dev/raw/raw1 %N"
ACTION=="add", KERNEL=="sdd1", RUN+="/bin/raw /dev/raw/raw2 %N"
ACTION=="add", KERNEL=="sde1", RUN+="/bin/raw /dev/raw/raw3 %N"

# /etc/udev/rules.d/65-raw-permissions.rules

KERNEL=="raw1", OWNER="oravis", GROUP="oinstall", MODE="660"
KERNEL=="raw2", OWNER="oravis", GROUP="oinstall", MODE="660"
KERNEL=="raw3", OWNER="oravis", GROUP="oinstall", MODE="660"

```bash
start_udev

raw -qa

ls -l /dev/raw/*
```

#### Filesystem

```bash
fdisk /dev/sdb

mkfs.ext4 /dev/sdb1

mkdir /u01
```

# /etc/fstab

/dev/sdb1               /u01                    ext4    defaults        0 2

mount -at ext4

#### Directories

mkdir -p /u01/app/11.2.0/grid

mkdir -p /u01/app/oravis

chmod -R 775 /u01

chown -R oravis:oinstall /u01

#### NTP Slewing Option

```bash
service ntpd stop
```

# /etc/sysconfig/ntpd
-x

```bash
service ntpd start
````

#### Packages

```bash
subscription-manager register

subscription-manager attach --auto

yum install -y ksh libaio-devel

subscription-manager unregister
```

#### GI Installation

OSASM group: oinstall
OSDBA for ASM group: dba

Ignore the packages requirement for pdksh-5.2.14 because we already installed ksh instead.
