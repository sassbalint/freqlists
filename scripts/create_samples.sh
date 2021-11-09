#!/bin/bash

for F in MagyarSzo KiadokAkademiai MNSZ_nowp arcj_teljes
do
    echo $F ; make sample FILENAME=$F SAMPLESIZE=100000
done

