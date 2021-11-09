#!/bin/bash

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; cat out/$F.100000.42.out | wordperline | sstat | cat -n | egrep " (és|év|jó|több|úgy)$"
done

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; cat out/$F.100000.42.out | wordperline | sstat | cat -n | egrep " (es|ev|jo|tobb|ugy)$"
done

