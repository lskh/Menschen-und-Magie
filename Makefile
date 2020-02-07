DATE:=$(shell date +%d\\.%m\\.%Y\ \\/%H\\:%M\\:%S)

md=intro.md Charaktererschaffung.md Abenteuer.md Anhang.md 20Q.md license.md

pdf=MnM.pdf Spells.pdf Hausregeln.pdf

all: $(pdf)
	cd cover; make

MnM.pdf: Makefile template.tex $(md)
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$(md) | sed -e "s/, Datum: /, Datum: $(DATE)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > tmp1.tex
	pdflatex --draftmode tmp1.tex
	makeindex tmp1.idx
	pdflatex --draftmode tmp1.tex
	makeindex tmp1.idx
	pdflatex tmp1.tex
	mv tmp1.pdf $@
	rm tmp1.*

Charaktererschaffung.pdf: Makefile Charaktererschaffung.md
	sed 's/lettrine//g' Charaktererschaffung.md |\
	pandoc -s -t latex --variable classoption="12pt" \
	--variable "title:Menschen \& Magie: Charaktererschaffung" \
	--variable fontfamily=coelacanth \
	--variable fontfamilyoptions=osf \
	--variable toc \
	--variable geometry="margin=1.2cm,bottom=1.8cm" \
	--variable papersize="a5" \
	--variable lang=de \
	-o Charaktererschaffung.pdf 

Spells.md: Makefile
	cd Spells ; make Spells.md
	cp Spells/Spells.md Spells.md 

Spells.pdf: Makefile Spells.md template.tex license.md
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o tmp2.tex Spells.md license.md
	pdflatex --draftmode tmp2.tex
	makeindex tmp2.idx
	pdflatex --draftmode tmp2.tex
	makeindex tmp2.idx
	pdflatex tmp2.tex
	mv tmp2.pdf Spells.pdf
	rm Spells.md 
	rm tmp2.*

Hausregeln.pdf: Makefile template.tex Hausregeln.md license.md
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o Hausregeln.pdf Hausregeln.md license.md

Tabellen.pdf: Makefile Tabellen.md Hausregeln.md
	pandoc -s -t latex --variable classoption="12pt" \
	--variable "title:Menschen \& Magie: Tabellen" \
	--variable fontfamily=coelacanth \
	--variable fontfamilyoptions=osf \
	--variable lot \
	--variable geometry="margin=1.5cm" \
	--variable papersize="a5" \
	--variable lang=de \
	-o Tabellen.pdf Tabellen.md Hausregeln.md

clean:
	rm -f tmp*.* 

realclean: clean
	cd Spells; make realclean
	cd cover; make realclean
	rm -f *.pdf
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
