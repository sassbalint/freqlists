_... the ultimate solution for everything: frequency lists_

# "determining cleanness of corpora" project 

the point: a __unified__ approach based on frequency lists

## :fire: TODO

1. :fire: create plan: how to tackle each cleanness aspect using frequency lists

2. :fire: implementation based on [`book-index/freqlists.py`](https://github.com/sassbalint/book-index/blob/main/scripts/freqlists.py):\
(1) take script, (2) correct it (identify problem), (3) split to several scripts?, (4) solve all problems with it :)


## _efficient_ sampling from gigamegalarge corpora

implementation: https://github.com/sassbalint/freqlists/blob/main/scripts/random_sampler.py ([original source](http://metadatascience.com/2014/02/27/random-sampling-from-very-large-files))

files (from `arcj`):
|name                 |rows    |words  |bytes|
|:--                  |     --:|    --:|  --:|
|`MagyarSzo_10percent`|   5.8 M|   57 M|.4G  |
|`MagyarSzo`          |  57.6 M|  627 M|4.0G |
|`arcj_teljes`        |1067.0 M|10650 M|67.0G|

command:
`time make sample FILENAME=MagyarSzo SAMPLESIZE=?`

results (average of 3 measures, in seconds):
<!--
for i in 1 2 3 ; do for s in 10 10000 1000000 10000000 ; do for f in MagyarSzo_10percent MagyarSzo arcj_teljes ; do echo ; echo "$s   $f" ; time make sample FILENAME=$f SAMPLESIZE=$s ; done ; done > times$i 2>&1 ; done
-->

|samplesize|`MagyarSzo_10percent`|`MagyarSzo`|`arcj_teljes`|
|       --:|                  --:|        --:|          --:|
|        10|                    0|          0|            0|
|     10000|                    0|          0|            0|
|   1000000|                    5|          6|            8|
|  10000000|                   37|         48|           90|

* :arrow_right: time complexity: corpussize hardly matters (log?), samplesize below linear :arrow_right: extra efficient stuff! :)
* maybe slower first time = when loading corpus into memory
* it can be a limit when corpus is larger then the memory -- _to be tested_
* con: stream not ok, whole file on disk is needed
* equally sized are the best for this algo -- solution can be: splitting long sentences into same sized chunks

## cleanness aspects

OTKA pályázatbeli _cleanness_ fogalom alapján, [source](https://github.com/ril-lexknowrep/META/blob/main/wiki/korpuszok.md)

(1) __é__ rtelmes = nincsenek széttöredezett szavak, szótöredékek, értelmetlen stringek\
(2) __m__ agyar = nincsenek benne idegen nyelvű többmondatos szakaszok;\
(3) __h__ elyesírás oké = ékezet, nagybetűsség, írásjelek okék (a normatív helyesírás nem követelmény);\
(4) __d__ eduplikált = nincsenek benne azonos többmondatos szakaszok.

(a boilerplate is megoldható dedup alapon?)

## prereq

tok _or_ split by space\
sentsplit _or_ split by ≈100 chars or ≈7 words\
:arrow_right: spl\
:arrow_right: base unit = "sentence"
