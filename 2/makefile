FILENAME = report2

main: y.tab.c lex.yy.c
	gcc -o main y.tab.c lex.yy.c -ly -ll -lm

y.tab.c: $(FILENAME).y
	bison -dv -y $(FILENAME).y

lex.yy.c: $(FILENAME).l
	flex -l $(FILENAME).l

clean:
	rm -f y.tab.c lex.yy.c y.output y.tab.h main