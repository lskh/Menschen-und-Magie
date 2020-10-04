all: Spielerhandbuch-cover.png Spells-cover.png Hausregeln2021-cover.png

Spells-cover.png: Makefile ../Spells.pdf
	pdftoppm -f 1 -l 1 ../Spells.pdf > tmp.png
	convert +level-colors "#000000","#aaaa44" \
	tmp.png Spells-cover.png
	convert +level-colors "#aaaa44","#aaaa44" \
	-fuzz 100% tmp.png Spells-back.png
	rm -f tmp.png

Spells-fullcover.png: Makefile Spells-fullcover.pdf
	pdftoppm -f 1 -l 1 Spells-fullcover.pdf > tmp.png
	convert +level-colors "#000000","#aaaa44" \
	tmp.png Spells-fullcover.png
	rm -f tmp.png

Spells-fullcover.pdf: Makefile Spells-fullcover.tex
	pdflatex Spells-fullcover.tex
	rm *.aux *.log

Hausregeln2021-cover.png: Makefile ../Hausregeln2021.pdf
	pdftoppm -f 1 -l 1 ../Hausregeln2021.pdf > tmp.png
	convert +level-colors "#000000","#44f4a4" \
	tmp.png Hausregeln2021-cover.png
	convert +level-colors "#44f4a4","#44f4a4" \
	-fuzz 100% tmp.png Hausregeln2021-back.png
	rm -f tmp.png

Hausregeln2021-fullcover.png: Makefile Hausregeln2021-fullcover.pdf
	pdftoppm -f 1 -l 1 Hausregeln2021-fullcover.pdf > tmp.png
	convert +level-colors "#000000","#44f4a4" -fuzz 10% \
	tmp.png Hausregeln2021-fullcover.png
	rm -f tmp.png

Hausregeln2021-fullcover.pdf: Makefile Hausregeln2021-fullcover.tex
	pdflatex Hausregeln2021-fullcover.tex
	rm *.aux *.log

Spielerhandbuch-cover.png: Makefile ../Spielerhandbuch.pdf
	pdftoppm -f 1 -l 1 ../Spielerhandbuch.pdf > tmp.png
	convert +level-colors "#000000","#cca666" \
	tmp.png Spielerhandbuch-cover.png
	convert +level-colors "#cca666","#cca666" \
	-fuzz 100% tmp.png Spielerhandbuch-back.png
	rm -f tmp.png

Spielerhandbuch-fullcover.png: Makefile Spielerhandbuch-fullcover.pdf
	pdftoppm -f 1 -l 1 Spielerhandbuch-fullcover.pdf > tmp.png
	convert +level-colors "#000000","#cca666" \
	tmp.png Spielerhandbuch-fullcover.png
	rm -f tmp.png

Spielerhandbuch-fullcover.pdf: Makefile Spielerhandbuch-fullcover.tex
	pdflatex Spielerhandbuch-fullcover.tex
	rm *.aux *.log

clean: 
	rm -f *~ *-fullcover.pdf

realclean: clean
	rm -f *.png
