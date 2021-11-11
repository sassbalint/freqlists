#!/bin/bash

if [ $# -ne 1 ]
then
  echo "1 param obligatory:"
  echo "  * RANDOMSEED"
  exit 1;
fi

RANDOMSEED=$1

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; time make sample FILENAME=$F SAMPLESIZE=100000 RANDOMSEED=$RANDOMSEED
done

