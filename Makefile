DATE:=$(shell date +%d\\.%m\\.%Y\ \\/%H\\:%M\\:%S)

md=intro.md Charaktererschaffung.md Abenteuer.md Anhang.md license.md

pdf=MnM.pdf Spells.pdf Hausregeln.pdf

all: $(pdf)
	cd cover; make

MnM.pdf: Makefile template.tex $(md)
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=memoir \
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
#	rm tmp1.*

Spells.md: Makefile
	cd Spells ; make Spells.md
	cp Spells/Spells.md Spells.md 

Spells.pdf: Makefile Spells.md template.tex license.md
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=memoir \
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
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o tmp3.tex Hausregeln.md license.md
	pdflatex --draftmode tmp3.tex
	makeindex tmp3.idx
	pdflatex --draftmode tmp3.tex
	makeindex tmp3.idx
	pdflatex tmp3.tex
	mv tmp3.pdf Hausregeln.pdf
	rm tmp3.*


Monster.pdf: Makefile template.tex Monster.md license.md
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o Monster.pdf Monster.md license.md

AnA.pdf: Makefile template.tex AnA.md license.md
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o AnA.pdf AnA.md license.md

clean:
	rm -f tmp*.* 

realclean: clean
	cd Spells; make realclean
	cd cover; make realclean
	rm -f *.pdf
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
