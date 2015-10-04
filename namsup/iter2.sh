#!/bin/bash

MAX=3

for i in $(seq "$MAX") 
do
    # echo "$i"
    echo 8 4 1 6 > /proc/sys/kernel/printk 
    eval "mkdir$i=`./test_mkdir`"
    echo 4 4 1 6 > /proc/sys/kernel/printk 
done

mkdirsum=0
dmkdir=0

for i in $(seq "$MAX")
do
    temp="mkdir$i"
    echo mkdir=${!temp}
    let mkdirsum=mkdirsum+temp
    let dmkdir=dmkdir+\(temp\*temp\)
done

let mkdir_mean=mkdirsum/MAX
let dmkdir_mean=dmkdir/MAX
let mkdir_var=dmkdir_mean-\(mkdir_mean\*mkdir_mean\)

echo mkdir mean=${mkdir_mean}
echo mkdir var=${mkdir_var}
