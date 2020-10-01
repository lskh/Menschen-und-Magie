all: sticker1.pdf sticker2.pdf sticker3.pdf

%.pdf: %.md ../template.tex Makefile
	pandoc -s -t latex --template ../template.tex \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< -o $@

realclean: 
	rm -f *.pdf *~
