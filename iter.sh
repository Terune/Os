#!/bin/bash

CMON=IoooI
MAX=3
MIN=1
for i in $(seq "$MAX") 
do
    # printf "${i}\n"
    # CM=`echo -e ''$_{1..2}"\b$CMON"` # *
    CM=$(printf "$CMON" $(seq $MAX))
    printf "$CM\n"

    # printf `echo -e ''$_{1..10}'\b+'`
    # printf '%*s\n' "12" | tr ' ' "$CMON"
    # printf "%${i}s\n" "" | tr '' "$CMON"
    PRT=`echo -e ''$_{1..$MAX}"\b$CMON"`
    # echo "$i"
    eval var$i=`./fint "$PRT"`
done

for i in $(seq "$MAX")
do
    temp="var$i"
    echo ${!temp}
done




