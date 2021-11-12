#!/bin/bash

if [ $# -ne 2 ]
then
  echo "2 params obligatory:"
  echo "  * FILENAME"
  echo "  * RANDOMSEED"
  exit 1;
fi

FILENAME=$1
RANDOMSEED=$2

cat out/$FILENAME.100000.$RANDOMSEED.out | wordperline | sstat | cat -n | egrep " (és|év|jó|több|úgy)$"
cat out/$FILENAME.100000.$RANDOMSEED.out | wordperline | sstat | cat -n | egrep " (es|ev|jo|tobb|ugy)$"

