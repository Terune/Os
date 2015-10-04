#!/bin/bash

MAX=3
for i in $(seq "$MAX") 
do
    # echo "$i"
    eval "var$i=`./fint 12313`"
done

for i in $(seq "$MAX")
do
    temp="var$i"
    echo ${!temp}
done




