# as of now M&M does only build properly with pandoc 2.9
# if your system has got pandoc 2.10 or higher, you'll have
# to install pandoc 2.9 manually and put a symlink named 
# pandoc-2.9 in your $PATH
# if you want to use your standard pandoc uncomment the 
# second line hereafter:

PANDOC=pandoc-2.9
#PANDOC=pandoc

all: Spielerhandbuch.pdf Spells.pdf Hausregeln2020.pdf Hausregeln2021.pdf
	cd cover; make

Gridmaps:
	cd gridmaps ; make all

Spielleiterbuch.tex: Spielleiterbuch.md Makefile template.ltx Gridmaps
	$(PANDOC) -s -t latex --template template.ltx \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< | sed -e "s/^Datum\:/$(shell date)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > $@

.PRECIOUS: %.tex

%.tex: %.md Makefile license.md template.ltx 
	$(PANDOC) -s -t latex --template template.ltx \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< license.md | sed -e "s/^Datum\:/$(shell date)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > $@ 

%.pdf: %.tex
	pdflatex --draftmode $<
	makeindex $(shell basename $< .tex).idx
	pdflatex --draftmode $<
	makeindex $(shell basename $< .tex).idx
	pdflatex $<

Spells/Spells.md: Makefile
	cd Spells ; make Spells.md

Spells.md: Spells/Spells.md Makefile
	cp Spells/Spells.md Spells.md 

clean:
	rm -f *.tex *.ilg *.ind *.log *.lot *.toc *.aux *.idx tmp* Spells.md
	rm -f *.xmpi *.out

realclean: clean
	cd gridmaps ; make realclean
	cd Spells; make realclean
	cd cover; make realclean
	rm -f *.pdf
	rm -f *.log *~ 
	rm -f *.xmpi

archive: realclean
	zip -rv  ../Hausregeln.zip . -x ".git/*" -x ".gitignore"
