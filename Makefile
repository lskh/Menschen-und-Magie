all: Spielerhandbuch.pdf Spells.pdf Hausregeln2020.pdf Hausregeln2021.pdf
	cd cover; make

gridmaps:
	cd gridmaps ; make all

Spielleiterbuch.tex: Spielleiterbuch.md Makefile template.ltx gridmaps
	pandoc -s -t latex --template template.ltx \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< | sed -e "s/^Datum\:/$(shell date)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > $@

.PRECIOUS: %.tex

%.tex: %.md Makefile license.md template.ltx 
	pandoc -s -t latex --template template.ltx \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< license.md | sed -e "s/^Datum\:/$(shell date)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > $@ 

%.pdf: %.tex
	pdflatex --draftmode $<
	makeindex $(shell basename $<).idx
	pdflatex --draftmode $<
	makeindex $(shell basename $<).idx
	pdflatex $<

Spells/Spells.md: Makefile
	cd Spells ; make Spells.md

Spells.md: Spells/Spells.md Makefile
	cp Spells/Spells.md Spells.md 

clean:
	rm -f *.tex *.log *.lot *.toc *.aux *.idx tmp* Spells.md
	rm -f *.xmpi

realclean: clean
	cd gridmaps ; make realclean
	cd Spells; make realclean
	cd cover; make realclean
	rm -f *.pdf
	rm -f *.log *~ 
	rm -f *.xmpi

archive: realclean
	zip -rv  ../Hausregeln.zip . -x ".git/*" -x ".gitignore"
