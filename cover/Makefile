all: MnM-cover.png Spells-cover.png Hausregeln-cover.png

Spells-cover.png: Makefile ../Spells.pdf
	pdftoppm -f 1 -l 1 ../Spells.pdf > tmp.png
	convert +level-colors "#000000","#aaaa44" \
	tmp.png Spells-cover.png
	convert +level-colors "#aaaa44","#aaaa44" \
	-fuzz 100% tmp.png Spells-back.png
	rm -f tmp.png

Hausregeln-cover.png: Makefile ../Hausregeln2020.pdf
	pdftoppm -f 1 -l 1 ../Hausregeln2020.pdf > tmp.png
	convert +level-colors "#000000","#44aaaa" \
	tmp.png Hausregeln-cover.png
	convert +level-colors "#44aaaa","#44aaaa" \
	-fuzz 100% tmp.png Hausregeln-back.png
	rm -f tmp.png

MnM-cover.png: Makefile MnM-fullcover.pdf
	pdftoppm -f 1 -l 1 MnM-fullcover.pdf > tmp.png
	convert +level-colors "#000000","#aa8444" \
	tmp.png MnM-cover.png
	rm -f tmp.png

MnM-fullcover.pdf: Makefile MnM-fullcover.tex
	pdflatex MnM-fullcover.tex
	rm *.aux *.log

clean: 
	rm -f *~ MnM-fullcover.pdf

realclean: clean
	rm -f *.png
