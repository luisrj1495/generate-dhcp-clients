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

while [ "$opt" != "yes" ]; do
  echo "Intoduce how many clients do you want generate ?"
    read CLIENTS
  echo "Intoduce your interface network ?"
    read INTERFACE
  generateMacs $CLIENTS $INTERFACE
  echo "Do you want close ? (yes / no) "
    read opt
  clear
done

