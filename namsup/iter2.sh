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
    let dopen=dopen+\(temp\*temp\)
done

for i in $(seq "$MAX")
do
    temp="openwithwrite$i"
    echo openwithwrite=${!temp}
    let openwithwritesum=openwithwritesum+temp
    let dopenw=dopenw+\(temp\*temp\)
done
for i in $(seq "$MAX")
do
    temp="read$i"
    echo read=${!temp}
    let readsum=readsum+temp
    let dread=dread+\(temp\*temp\)
done
for i in $(seq "$MAX")
do
    temp="readwithwrite$i"
    echo readwithwrite=${!temp}
    let readwithwritesum=readwithwritesum+temp
    let dreadw=dreadw+\(temp\*temp\)
done

let openmean=opensum/MAX
let dopenmean=dopen/MAX
let openvar=dopenmean-\(openmean\*openmean\)

let open_writemean=openwithwritesum/MAX
let dopen_writemean=dopenw/MAX
let wopenvar=dopen_writemean-\(open_writemean\*open_writemean\)

let read_mean=readsum/MAX
let dread_mean=dread/MAX
let readvar=dread_mean-\(read_mean\*read_mean\)

let read_writemean=readwithwritesum/MAX
let dreadw_mean=dreadw/MAX
let wreadvar=dreadw_mean-\(read_writemean\*read_writemean\)

echo open mean=${openmean}
echo open var=${openvar}
echo open with write mean=${open_writemean}
echo open with write var=${wopenvar}
echo read mean=${read_mean}
echo read var=${readvar}
echo read with write mean=${read_writemean}
echo read with write var=${wreadvar}


