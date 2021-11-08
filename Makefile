SHELL:=/bin/bash

all:
	@echo "choose explicit target = type 'make ' and press TAB"

S=scripts
I=data
O=out


# ===== MAIN STUFF 

FILENAME=data
INPUT=$I/$(FILENAME)
SAMPLESIZE=10
RANDOMSEED=42
SCRIPT=$S/random_sampler.py
sample:
	python3 $(SCRIPT) --filename $(INPUT) --samplesize $(SAMPLESIZE) --randomseed $(RANDOMSEED) > $O/out

