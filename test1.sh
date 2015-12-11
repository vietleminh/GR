#!/bin/sh
l_all_vms=$(nova host-list --zone nova | tail -n +4 | head -n -1 | cut -d'|' -f 2 | sed -e 's# ##g')

l_tmp="/tmp/$(basename $0).$$"
for vm in $l_all_vms; do
  # get info
  if nova host-describe $vm 2>/dev/null > $l_tmp; then
    l_vm_host=$(grep -e "^| (total)" $l_tmp | cut -d'|' -f 3 | sed -e 's#^ \+##; s#[ \t]*$##')
    echo "$l_vm_host"
  fi
done
