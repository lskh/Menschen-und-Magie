all: MnM.pdf Spells.pdf Hausregeln.pdf 
	cd cover; make

%.pdf: %.md Makefile template.tex 
	pandoc -s -t latex --template template.tex \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< license.md | sed -e "s/^Datum\:/$(shell date)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > tmp.$<.tex
	pdflatex --draftmode tmp.$<.tex
	makeindex tmp.$<.idx
	pdflatex --draftmode tmp.$<.tex
	makeindex tmp.$<.idx
	pdflatex tmp.$<.tex
	mv tmp.$<.pdf $@ &&\
	rm tmp.$<.*

MnM.md: intro.md Charaktererschaffung.md Abenteuer.md Anhang.md
	cat $^ > MnM.md

Spells.md: Spells/Spells.md Makefile
	cd Spells ; make Spells.md
	cp Spells/Spells.md Spells.md 

clean:
	rm -f tmp* Spells.md MnM.md

realclean: clean
	cd Spells; make realclean
	cd cover; make realclean
	rm -f *.pdf
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
