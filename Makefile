all: MnM.pdf AnA.pdf 

MnM.pdf: Makefile MnM.md header.tex
	rm -f tmp1.tex
	pandoc -s -t latex -H header.tex \
	--variable lang=de \
	--variable documentclass=article \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	-o tmp1.tex MnM.md
	pdflatex tmp1.tex
	makeindex tmp1.idx
	pdflatex tmp1.tex
	mv tmp1.pdf MnM.pdf

AnA.pdf: Makefile AnA.md header.tex
	rm -f tmp2.tex
	pandoc -s -t latex -H header.tex \
	--toc --variable lang=de \
	--variable documentclass=book \
	--variable classoption="a5paper,12pt" \
	--variable subparagraph \
	-o tmp2.tex AnA.md
	pdflatex tmp2.tex
	makeindex tmp2.idx
	pdflatex tmp2.tex
	mv tmp2.pdf AnA.pdf

clean:
	rm -f tmp*.* 

realclean: clean
	rm -f *.log *~ 

archive: realclean
	zip -rv  ../MnM.zip . -x \.git/
