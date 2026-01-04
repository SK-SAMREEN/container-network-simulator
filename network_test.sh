#!/bin/bash
LOG=network.log
echo "Network Test - $(date)" > $LOG

test() {
  if docker exec $1 ping -c 1 $2 &>/dev/null; then
    echo "$1 -> $2 : SUCCESS" | tee -a $LOG
  else
    echo "$1 -> $2 : FAILED" | tee -a $LOG
  fi
}

test c1 c2
test c1 c3
