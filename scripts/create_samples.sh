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

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; time make sample FILENAME=$FILENAME SAMPLESIZE=100000 RANDOMSEED=$RANDOMSEED
done

