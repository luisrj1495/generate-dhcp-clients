#!/bin/bash

if [ -d $PWD/dhtest ];
  then
    echo "File Ready :)"
  else
    echo "Download files..."
    echo `git clone https://github.com/saravana815/dhtest.git`
    cd $PWD/dhtest/
    gcc -c -o dhtest.o dhtest.c
    gcc -c -o functions.o functions.c
    gcc dhtest.o functions.o -o dhtest
    clear
fi

function hexa(){
  echo `tr -dc a-f < /dev/urandom | head -c 2 && echo`
}

function nums(){
  echo `echo $((($RANDOM%89) + 10))`
}

function generateMacs(){
  for((i=0; i<$1; i++)); do
  MAC=`nums`:`hexa`:`nums`:`hexa`:`nums`:`hexa`
  cd $PWD/dhtest/ && sudo ./dhtest -m $MAC -i $2 && cd ..
  echo $MAC $2
done
  
}

function showsOptions(){
  if [ "$1" = "yes" ];
  then
    echo "-r, –release # Releases obtained DHCP IP for corresponding MAC"
    echo "-I, –option50-ip [ IP_address ] # Option 50 IP address on DHCP discover"
    echo "-o, –option60-vci [ VCI_string ] # Vendor Class Idendifier string"
    echo "-v, –vlan [ vlan_id ] # VLAN ID. Range(2 – 4094)"
    echo "-t, –tos [ TOS_value ] # IP header TOS value"
    echo "-i, –interface [ interface ] # Interface to use. Default eth0"
    echo "-T, –timeout [ cmd_timeout ] # Command returns within specified timout in seconds"
    echo "-b, –bind-ip # Listens on the obtained IP. Supported protocols – ARP and ICMP"
    echo "-k, –bind-timeout [ timeout ] # Listen timout in seconds. Default 3600 seconds"
    echo "-f, –bcast_flag # Sets broadcast flag on DHCP discover and request"
    echo "-V, –verbose # Prints DHCP offer and ack details"

fi
}

while [ "$OPT" != "yes" ]; do
  echo "Do you want show the options ? (yes / no)"
    read SHOW
    showsOptions $SHOW
  echo "Intoduce how many clients do you want generate ?"
    read CLIENTS
  echo "Intoduce your interface network ?"
    read INTERFACE
  generateMacs $CLIENTS $INTERFACE
  echo "Do you want close ? (yes / no) "
    read OPT
  clear
done

