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
    echo $F ; cat out/$F.100000.$RANDOMSEED.out | wordperline | sstat | cat -n | egrep " (the|of|and)$"
done

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; cat out/$F.100000.$RANDOMSEED.out | wordperline | sstat | cat -n | egrep " (der|und|zu)$"
done

