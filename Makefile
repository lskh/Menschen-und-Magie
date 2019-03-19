DATE:=$(shell date +%d\\.%m\\.%Y\ \\/%H\\:%M\\:%S)

all: MnM.pdf 

MnM.pdf: Makefile MnM.md license.md template.tex
	sed "s/^Datum:.*/Datum: $(DATE)/" MnM.md > tmp1.md
	rm -f tmp1.tex
	pandoc -s -t latex --template template.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o tmp1.tex tmp1.md license.md
	pdflatex tmp1.tex
	makeindex tmp1.idx
	pdflatex tmp1.tex
	mv tmp1.pdf MnM.pdf
	rm tmp*.*

clean:
	rm -f tmp*.* 

realclean: clean
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
