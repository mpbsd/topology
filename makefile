TEX_ENGINE = xelatex
BIB_ENGINE = bibtex
OPR_SYSTEM = $(shell uname -s)

ifeq ($(OPR_SYSTEM), Darwin)
	DOC_VIEWER = open -a Preview
else
	DOC_VIEWER = zathura
endif

draft: main.tex
	$(TEX_ENGINE) main
	$(TEX_ENGINE) main
	$(DOC_VIEWER) main.pdf

final: main.tex bib/main.bib
	$(TEX_ENGINE) main
	$(BIB_ENGINE) main
	$(TEX_ENGINE) main
	$(DOC_VIEWER) main.pdf

clean:
	find . -type f -name *.aux | xargs rm -rf
	find . -type f -name *.bbl | xargs rm -rf
	find . -type f -name *.blg | xargs rm -rf
	find . -type f -name *.log | xargs rm -rf
	find . -type f -name *.pdf | xargs rm -rf
	find . -type f -name *.toc | xargs rm -rf

.PHONY: draft final clean
