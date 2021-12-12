#!/bin/bash

# in loops "while & for " are two major cammonds

# while loop works on expressions that we use in if statements

a=10
while [ $a -gt 0 ]; do
  echo while loop
  sleep 0.5
  a=$(($a-2))
done

#syntax: for var in items ; do commands ;done
for fruit in apple banana pine mosamby guvva ; do
  echo fruit name = $fruit
done

echo -n "checking connection on port 22 for host $1"
while true ; do
  nc -w z 1 $1 22 &>/dev/null
# "nc" is the command used for the port open or not ,, -w is the waiting of time
if [ $? -eq 0 ]; then
  break
fi
  echo -n '.'
done