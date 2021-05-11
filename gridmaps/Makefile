all: hexgrid1.png

%.png: %.svg Makefile
	inkscape -o $@ $<

realclean:
	rm -f *~ *.png
