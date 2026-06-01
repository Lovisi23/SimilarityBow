all:
	ghc -isrc app/Main.hs -o similarity.exe

run-igual:
	./similarity.exe examples/res.txt \
	                  examples/sep.txt \
	                  examples/c1.c \
	                  examples/c2.c

run-similar:
	./similarity.exe examples/res.txt \
	                  examples/sep.txt \
	                  examples/c1.c \
	                  examples/c3.c

run-diferente:
	./similarity.exe examples/res.txt \
	                  examples/sep.txt \
	                  examples/c1.c \
	                  examples/c4.c

clean:
	del similarity.exe