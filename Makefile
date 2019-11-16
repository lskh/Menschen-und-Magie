DATE:=$(shell date +%d\\.%m\\.%Y\ \\/%H\\:%M\\:%S)

md=intro.md Charaktererschaffung.md Abenteuer.md Tabellen.md Hausregeln.md Anhang.md 20Q.md license.md

pdf=MnM.pdf

all: $(pdf)

$(pdf): Makefile template.tex $(md)
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$(md) | sed -e "s/, Datum: /, Datum: $(DATE)/" \
	-e "s/\\\{/\{/" -e "s/\\\}/\}/" > tmp1.tex
	pdflatex tmp1.tex
	makeindex tmp1.idx
	pdflatex tmp1.tex
	mv tmp1.pdf $@

Charaktererschaffung.pdf: Makefile Charaktererschaffung.md
	sed 's/lettrine//g' Charaktererschaffung.md |\
	pandoc -s -t latex --variable classoption="12pt" \
	--variable "title:Menschen \& Magie: Charaktererschaffung" \
	--variable fontfamily=coelacanth \
	--variable fontfamilyoptions=osf \
	--variable toc \
	--variable geometry="margin=1.8cm" \
	--variable papersize="a5" \
	--variable lang=de \
	-o Charaktererschaffung.pdf 

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
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
