#!/bin/bash
#VOLPATH="/dev/zvol/rpool"
#IQN="iqn.2024-09.ru.vmhouse.iscsi"

tgtd -f &> tgt.log &
tgtadm --op update --mode sys --name State -v offline
tgt-admin -e -c /etc/tgt/targets.conf
tgtadm --op update --mode sys --name State -v ready

for VOL in `ls -1 $VOLPATH`; 
do
  tgtadm --lld iscsi --op new --mode target --tid ${VOL: -2} --targetname $IQN:$VOL
  tgtadm --lld iscsi --op new --mode logicalunit --tid ${VOL: -2} --lun 1 --backing-store $VOLPATH/$VOL
done
echo ****************************************************************************
tgtadm --lld iscsi --op show --mode target
tail -100 -f tgt.log
