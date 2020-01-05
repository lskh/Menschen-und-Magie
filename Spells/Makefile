all: Spells.md

tmp.md: Makefile list_spells.awk
	./list_spells.awk > tmp.md

Spells.md: Makefile intro.md tmp.md endmatter.md
	cat intro.md tmp.md endmatter.md > Spells.md

Spells.pdf: Makefile tmp.md
	pandoc -H preamble.tex -s -t latex \
	-o Spells.pdf tmp.md
