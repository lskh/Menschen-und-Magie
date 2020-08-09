SPELLS=$(wildcard *.txt)

all: Spells.md

tmp.md: Makefile ${SPELLS} list_spells.awk
	./list_spells.awk > tmp.md

Spells.md: Makefile intro.md list_spells.awk ${SPELLS} endmatter.md
	./list_spells.awk > tmp.md
	cat intro.md tmp.md endmatter.md > Spells.md

Spells.pdf: Makefile Spells.md
	pandoc -H preamble.tex -s -t latex \
	-o Spells.pdf Spells.md

clean: 
	rm -f tmp.* *~

realclean: clean
	rm -f Spells.md
	rm -f Spells.pdf
