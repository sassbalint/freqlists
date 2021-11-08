SHELL:=/bin/bash

all:
	@echo "choose explicit target = type 'make ' and press TAB"

S=scripts
I=data
O=out


# ===== MAIN STUFF 

FILENAME=$I/data
SAMPLESIZE=100
RANDOMSEED=42
SCRIPT=$S/random_sampler.py
sample:
	python3 $(SCRIPT) --filename $(FILENAME) --samplesize $(SAMPLESIZE) --randomseed $(RANDOMSEED)

