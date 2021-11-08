# freqlists

the ultimate solution for everything: frequency lists 

## "determining cleanness of corpora" project 

the point: a __unified__ approach based on frequency lists

### :fire: TODO

#### 1. _efficient_ sampling from gigamegalarge corpora

files (from `arcj`):
`MagyarSzo_10percent`  5,76mió sor;   57mió szó;  .4G
`MagyarSzo`           57,6mió sor;   627mió szó; 4G
`arcj_teljes`       1067mió sor;   10650mió szó; 67G

command:
`time make sample FILENAME=MagyarSzo SAMPLESIZE=?`

average of 3 measures, in seconds
<!--
for i in 1 2 3 ; do for s in 10 10000 1000000 10000000 ; do for f in MagyarSzo_10percent MagyarSzo arcj_teljes ; do echo ; echo "$s   $f" ; time make sample FILENAME=$f SAMPLESIZE=$s ; done ; done > times$i 2>&1 ; done
-->

|samplesize|`MagyarSzo_10percent`|`MagyarSzo`|`arcj_teljes`|
|--:|--:|--:|--:|
      |10|0|0|0|
   |10000|0|0|0|
 |1000000|5|6|8|
|10000000|37|48|90|

=> időbonyolultság:
corpussize alig számít (log?), samplesize is lineáris alatt,
szóval extra hatékony a cucc! :)
(Lehet, hogy _elsőre_, azaz memóriába betöltéskor sokkal lassabb!)

a memória azért biztos határt szab ennek -- __tesztelni!__

hátrány: kell hozzá egyben a fájl! -- de üsse kő! :)

#### 2. create plan: how to tackle each cleanness aspect using frequency lists

#### 3. implementation based on [`book-index/freqlists.py`](https://github.com/sassbalint/book-index/blob/main/scripts/freqlists.py):\
(1) take script, (2) correct it (identify problem), (3) split to several scripts?, (4) solve all problems with it :)

### cleanness aspects

OTKA pályázatbeli _cleanness_ fogalom alapján, [source](https://github.com/ril-lexknowrep/META/blob/main/wiki/korpuszok.md)

(1) __é__ rtelmes = nincsenek széttöredezett szavak, szótöredékek, értelmetlen stringek\
(2) __m__ agyar = nincsenek benne idegen nyelvű többmondatos szakaszok;\
(3) __h__ elyesírás oké = ékezet, nagybetűsség, írásjelek okék (a normatív helyesírás nem követelmény);\
(4) __d__ eduplikált = nincsenek benne azonos többmondatos szakaszok.

(a boilerplate is megoldható dedup alapon?)

### prereq

tok _or_ split by space\
sentsplit _or_ split by ≈100 chars or ≈7 words\
:arrow_right: spl\
:arrow_right: base unit = "sentence"

hm.. a sampling szereti, ha kb. egyforma hosszúak a sorok,
megoldás lehet: a hosszú mondatok tördelése!

