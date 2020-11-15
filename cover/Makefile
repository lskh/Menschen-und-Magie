all: Spielerhandbuch-cover.png Spells-cover.png Hausregeln2020-cover.png Hausregeln2021-cover.png

%-fullcover.pdf: %-fullcover.tex Makefile
	pdflatex $<
	rm *.aux *.log

Spells-cover.png: Makefile ../Spells.pdf
	pdftoppm -f 1 -l 1 ../Spells.pdf > tmp.png
	convert +level-colors "#000000","#aaaa44" \
	tmp.png Spells-cover.png
	convert +level-colors "#aaaa44","#aaaa44" \
	-fuzz 100% tmp.png Spells-back.png
	rm -f tmp.png

Spells-fullcover.png: Spells-fullcover.pdf Makefile
	pdftoppm -f 1 -l 1 -r 300 $< > tmp.png
	convert +level-colors "#000000","#aaaa44" \
	tmp.png $@
	rm -f tmp.png

Hausregeln2020-cover.png: Makefile ../Hausregeln2020.pdf
	pdftoppm -f 1 -l 1 ../Hausregeln2020.pdf > tmp.png
	convert +level-colors "#000000","#44aaaa" \
	tmp.png Hausregeln2020-cover.png
	convert +level-colors "#44aaaa","#44aaaa" \
	-fuzz 100% tmp.png Hausregeln2020-back.png
	rm -f tmp.png

Hausregeln2020-fullcover.png: Hausregeln2020-fullcover.pdf Makefile
	pdftoppm -f 1 -l 1 -r 300 $< > tmp.png
	convert +level-colors "#000000","#44aaaa" \
	tmp.png $@
	rm -f tmp.png

Hausregeln2021-cover.png: Makefile ../Hausregeln2021.pdf
	pdftoppm -f 1 -l 1 ../Hausregeln2021.pdf > tmp.png
	convert +level-colors "#000000","#44f4a4" \
	tmp.png Hausregeln2021-cover.png
	convert +level-colors "#44f4a4","#44f4a4" \
	-fuzz 100% tmp.png Hausregeln2021-back.png
	rm -f tmp.png

Hausregeln2021-fullcover.png: Hausregeln2021-fullcover.pdf Makefile 
	pdftoppm -f 1 -l 1 -r 300 $< > tmp.png
	convert +level-colors "#000000","#84a4a4" -fuzz 10% \
	tmp.png $@
	rm -f tmp.png

Spielerhandbuch-cover.png: Makefile ../Spielerhandbuch.pdf
	pdftoppm -f 1 -l 1 ../Spielerhandbuch.pdf > tmp.png
	convert +level-colors "#000000","#aa8444" \
	tmp.png Spielerhandbuch-cover.png
	convert +level-colors "#aa8444","#aa8444" \
	-fuzz 100% tmp.png Spielerhandbuch-back.png

Spielerhandbuch-fullcover.png: Spielerhandbuch-fullcover.pdf Makefile 
	pdftoppm -f 1 -l 1 -r 300 $< > tmp.png
	convert +level-colors "#000000","#aa8444" \
	tmp.png $@
	rm -f tmp.png

Spielleiterbuch-cover.png: ../Spielleiterbuch.pdf Makefile
	pdftoppm -f 1 -l 1 -r 150 $< > tmp.png
	convert +level-colors "#ffffff","#000000" \
	        +level-colors "#000000","#ff0000" \
	tmp.png $@
	rm -f tmp.png

Spielleiterbuch-fullcover.png: Spielleiterbuch-fullcover.pdf Makefile 
	pdftoppm -f 1 -l 1 -r 300 $< > tmp.png
	convert +level-colors "#ffffff","#000000" \
	        +level-colors "#000000","#ff0000" \
	tmp.png $@
	rm -f tmp.png

Monster-fullcover.png: Monster.coverart.png Monster-fullcover.pdf Makefile
	pdftoppm -f 1 -l 1 -r 300 Monster-fullcover.pdf > $@

Monster.coverart.png:
	convert +level-colors "#000000","#449966" \
	../img/DnD-kobold.png $@

Basic-fullcover.png: Basic.coverart.png Basic-fullcover.pdf Makefile
	pdftoppm -f 1 -l 1 -r 300 Basic-fullcover.pdf > $@

Basic.coverart.png:
	convert +level-colors "#000000","#FF8844" \
	../img/dragonfight.png $@

clean: 
	rm -f *~ 

realclean: clean
	rm -f *.png *.pdf
