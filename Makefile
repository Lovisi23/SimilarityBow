all:
	ghc -isrc app/Main.hs -o program

run:
	./program examples/res.txt \
	          examples/sep.txt \
	          examples/c1.c \
	          examples/c2.c