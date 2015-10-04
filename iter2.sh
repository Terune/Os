#!/bin/bash

MAX=3
for i in $(seq "$MAX") 
do
    echo 8 4 1 6 > /proc/sys/kernel/printk 
    #echo "$i"
    eval "open$i=`./openread openread.txt open`"
    echo 4 4 1 6 > /proc/sys/kernel/printk 
done

for i in $(seq "$MAX") 
do
    # echo "$i"
    echo 8 4 1 6 > /proc/sys/kernel/printk 
    eval "openwithwrite$i=`./openread openread.txt open write`"
    echo 4 4 1 6 > /proc/sys/kernel/printk 
done

for i in $(seq "$MAX") 
do
    # echo "$i"
    echo 8 4 1 6 > /proc/sys/kernel/printk 
    eval "read$i=`./openread openread.txt read`"
    echo 4 4 1 6 > /proc/sys/kernel/printk 
done
for i in $(seq "$MAX") 
do
    # echo "$i"
    echo 8 4 1 6 > /proc/sys/kernel/printk 
    eval "readwithwrite$i=`./openread openread.txt read write`"
    echo 4 4 1 6 > /proc/sys/kernel/printk 
done
opensum=0
openwithwritesum=0
readsum=0
readwithwritesum=0
dopen=0
dopenw=0
dread=0
dreadw=0
for i in $(seq "$MAX")
do
    temp="open$i"
    echo open=${!temp}
    let opensum=opensum+temp
done

for i in $(seq "$MAX")
do
    temp="openwithwrite$i"
    echo openwithwrite=${!temp}
    let openwithwritesum=openwithwritesum+temp

done
for i in $(seq "$MAX")
do
    temp="read$i"
    echo read=${!temp}
    let readsum=readsum+temp
done
for i in $(seq "$MAX")
do
    temp="readwithwrite$i"
    echo readwithwrite=${!temp}
    let readwithwritesum=readwithwritesum+temp
done

let openmean=opensum/MAX
let open_writemean=openwithwritesum/MAX
let read_mean=readsum/MAX
let read_writemean=readwithwritesum/MAX
echo open mean=${openmean}
echo open with write mean=${open_writemean}
echo read mean=${read_mean}
echo read with write mean=${read_writemean}

