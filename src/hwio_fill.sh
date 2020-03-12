#!/bin/sh

if [ $# -lt 3 ]; then
	echo "`basename $0` [0x base] [0x offs] [size] <0x value>"
	echo "EX> `basename $0` 0x52100000 0xbb8f0 100"
	exit 0;
fi

base=$(printf "0x%x" $1)
offs=$(printf "0x%x" $2)
size=$3
value=0xff0000

if [ $# -eq 4 ]; then
	value=$(printf "0x%x" $4)
fi

base=$(printf  "0x%x" $(($base + $offs)))
i=0

while [ $i -lt $size ]
do
	addr=$(printf  "0x%x" $(($base + $i)))
	echo "[$addr]: $value" > /dev/null
	hwio -a $addr -w $value
	i=$(($i + 4))
done
