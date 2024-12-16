#!/bin/bash

# Configure project
./autogen.sh
./configure --prefix=/opt/pbs --enable-ptl
make
make install

# Configure server
echo "PBS_EXEC=/opt/pbs
PBS_SERVER=$(hostname)
PBS_START_SERVER=1
PBS_START_SCHED=1
PBS_START_COMM=1
PBS_START_MOM=0
PBS_HOME=/var/spool/pbs
PBS_CORE_LIMIT=unlimited
PBS_SCP=/usr/bin/scp" > /etc/pbs.conf

# Start pbs
/opt/pbs/libexec/pbs_init.d start


# Create groups and users for PTL
# or run pbs_config --make-ug
groupadd -g 1900 tstgrp00
groupadd -g 1901 tstgrp01
groupadd -g 1902 tstgrp02
groupadd -g 1903 tstgrp03
groupadd -g 1904 tstgrp04
groupadd -g 1905 tstgrp05
groupadd -g 1906 tstgrp06
groupadd -g 1907 tstgrp07
groupadd -g 901 pbs
groupadd -g 1146 agt
useradd -K UMASK=0022 -m -s /bin/bash -u 4359 -g tstgrp00 pbsuser
useradd -K UMASK=0022 -m -s /bin/bash -u 4361 -g tstgrp00 -G tstgrp01,tstgrp02 pbsuser1
useradd -K UMASK=0022 -m -s /bin/bash -u 4362 -g tstgrp00 -G tstgrp01,tstgrp03 pbsuser2
useradd -K UMASK=0022 -m -s /bin/bash -u 4363 -g tstgrp00 -G tstgrp01,tstgrp04 pbsuser3
useradd -K UMASK=0022 -m -s /bin/bash -u 4364 -g tstgrp01 -G tstgrp04,tstgrp05 pbsuser4
useradd -K UMASK=0022 -m -s /bin/bash -u 4365 -g tstgrp02 -G tstgrp04,tstgrp06 pbsuser5
useradd -K UMASK=0022 -m -s /bin/bash -u 4366 -g tstgrp03 -G tstgrp04,tstgrp07 pbsuser6
useradd -K UMASK=0022 -m -s /bin/bash -u 4368 -g tstgrp01 pbsuser7
useradd -K UMASK=0022 -m -s /bin/bash -u 4358 -g tstgrp00 -G tstgrp02,pbs,agt pbsother
useradd -K UMASK=0022 -m -s /bin/bash -u 4355 -g tstgrp00 -G tstgrp02,pbs,agt pbstest
useradd -K UMASK=0022 -m -s /bin/bash -u 1100 -g tstgrp00 tstusr00
useradd -K UMASK=0022 -m -s /bin/bash -u 1101 -g tstgrp00 tstusr01
useradd -K UMASK=0022 -m -s /bin/bash -u 9000 -g tstgrp00 pbsbuild
useradd -K UMASK=0022 -m -s /bin/bash -u 4372 -g tstgrp00 pbsdata
useradd -K UMASK=0022 -m -s /bin/bash -u 4367 -g tstgrp00 pbsmgr
useradd -K UMASK=0022 -m -s /bin/bash -u 4356 -g tstgrp00 -G tstgrp02,pbs,agt pbsoper
useradd -K UMASK=0022 -m -s /bin/bash -u 4357 -g tstgrp00 -G tstgrp02,pbs,agt pbsadmin
useradd -K UMASK=0022 -m -s /bin/bash -u 4371 -g tstgrp00 -G tstgrp02 pbsroot