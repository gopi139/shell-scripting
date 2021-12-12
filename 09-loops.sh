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


