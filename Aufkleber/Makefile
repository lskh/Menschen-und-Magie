all: a4sticker1.pdf a4sticker2.pdf

%.pdf: %.md ../template.tex Makefile
	pandoc -s -t latex --template ../template.tex \
	-f markdown+implicit_figures \
	--variable lang=de \
	--variable documentclass=memoir \
	--variable classoption="titlepage,twoside,a5paper,12pt" \
	--variable subparagraph \
	$< -o $@

a4sticker1.pdf: sticker1.pdf sticker2.pdf
	pdfjam --landscape --nup 2x1 $^ --outfile $@

a4sticker2.pdf: sticker3.pdf notizseite.pdf
	pdfjam --landscape --nup 2x1 $^ --outfile $@ 
 
realclean: 
	rm -f *.pdf *~
