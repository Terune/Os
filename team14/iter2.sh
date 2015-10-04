#!/bin/bash

MAX=1
for i in $(seq "$MAX") 
do
    #echo "$i"
    eval "open$i=`./openread openread.txt open`"
done

for i in $(seq "$MAX") 
do
    # echo "$i"
    eval "openwithwrite$i=`./openread openread.txt open write`"
done

for i in $(seq "$MAX") 
do
    # echo "$i"
    eval "read$i=`./openread openread.txt read`"
done
for i in $(seq "$MAX") 
do
    # echo "$i"
    eval "readwithwrite$i=`./openread openread.txt read write`"
done

for i in $(seq "$MAX") 
do
    # echo "$i"
    eval "readnum$i=`./test_read 30000`"
done

opensum=0
openwithwritesum=0
readsum=0
readwithwritesum=0
dopen=0
dopenw=0
dread=0
dreadw=0
bigread=0
for i in $(seq "$MAX")
do
    temp="open$i"
    let opensum=opensum+temp
    let dopen=dopen+\(temp\*temp\)
done

for i in $(seq "$MAX")
do
    temp="openwithwrite$i"
    let openwithwritesum=openwithwritesum+temp
    let dopenw=dopenw+\(temp\*temp\)
done
for i in $(seq "$MAX")
do
    temp="read$i"
    let readsum=readsum+temp
    let dread=dread+\(temp\*temp\)
done
for i in $(seq "$MAX")
do
    temp="readwithwrite$i"
    let readwithwritesum=readwithwritesum+temp
    let dreadw=dreadw+\(temp\*temp\)
done

for i in $(seq "$MAX")
do
    temp="readnum$i"
    let bigread=bigread+temp
    let dbigread=dbigread+\(temp\*temp\)
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

let bigreadmean=bigread/MAX
let dbigread_mean=dbigread/MAX
let bigreadvar=dbigread_mean-\(bigreadmean\*bigreadmean\)

echo open mean=${openmean}
echo open var=${openvar}
echo open with write mean=${open_writemean}
echo open with write var=${wopenvar}
echo read mean=${read_mean}
echo read var=${readvar}
echo read with write mean=${read_writemean}
echo read with write var=${wreadvar}
echo bigread mean=${bigreadmean}
echo bigread var=${bigreadvar}

