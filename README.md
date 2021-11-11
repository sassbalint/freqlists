_... the ultimate solution for everything: frequency lists_


# "determining cleanness of corpora" project 

the point: a __unified__ approach based on frequency lists


## :fire: TODO

1. :fire: create plan: how to tackle each cleanness aspect using frequency lists:\
(1) fragment;
(2) foreign;
(3) spelling;
(4) dedup

2. :fire: implementation based on [`book-index/freqlists.py`](https://github.com/sassbalint/book-index/blob/main/scripts/freqlists.py):\
(1) take script; (2) correct it (identify problem); (3) split to several scripts?; (4) solve all problems with it :)


## sample for experiments

command:
```
scripts/create_samples.sh 42
```
== `SAMPLESIZE=100000 RANDOMSEED=42`


## (2) foreign :fire: TODO

_Are there too much foreign text in the corpus?_

_first attempt:_
based on the freq of most frequent words in certain languages

command:
```
scripts/investigate_foreign.sh 42
```
results:
|language|`MagyarSzo`|`KiadokAkademiai`|`arcj_teljes`|`MNSZ_nowp`|
|:--     |:--        |:--              |:--          |:--        |
|English |very few   |some             |very few     |quite much |
|German  |very few   |some             |very few     |very few   |

very few > rank=5000 > some > rank=1000 > quite much

Result is stable = `RANDOMSEED=42` and `RANDOMSEED=43` gives essentially the same.

Looking at concordance of _the_ in MNSZ, it can be the case that
even such many English text is not too much,
because most hits are part of small English excerpts! Hm..


## (3) spelling :fire: TODO

command:
```
scripts/investigate_spelling.sh 42
```
results:
|                   |`MagyarSzo`|`KiadokAkademiai`|`arcj_teljes`|`MNSZ_nowp`|
|:--                |        --:|              --:|          --:|        --:|
|es/ugy/tobb/jo/ev% |0,13%      |0,10%            |0,09%        |1,06%      |

Result is stable = `RANDOMSEED=42` and `RANDOMSEED=43` gives essentially the same.

Idea: investigate MNSZ2 by subcorpora?


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
* there can be a limit if corpus is larger then the memory -- :fire: _to be tested_
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
