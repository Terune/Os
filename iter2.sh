#!/bin/bash

MAX=3
for i in $(seq "$MAX") 
do
    # echo "$i"
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
    temp="open$i"
    echo open=${!temp}
done

for i in $(seq "$MAX")
do
    temp="openwithwrite$i"
    echo openwithwrite=${!temp}
done
for i in $(seq "$MAX")
do
    temp="read$i"
    echo read=${!temp}
done
for i in $(seq "$MAX")
do
    temp="readwithwrite$i"
    echo readwithwrite=${!temp}
done



