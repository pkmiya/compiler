CC = gcc
OBJFILES = lex.yy.o y.tab.o VSM.o SymTable.o NameTable.o

# main target
# [NOTE] Make sure to use tab for indentation

# 1. compile ./gen (that load source codes & generates object codes)
# 2. compile ./exe (that loads object codes & executes)
main: ${OBJFILES}
	${CC} ${OBJFILES} -ly -ll -lm -o gen		
	${CC} main.c VSM.c -ly -ll -lm -o exe	

# dependencies
VSM.o : VSM.c VSM.h
lex.yy.o: lex.yy.c y.tab.h
lex.yy.c: report3.l
	flex -l report3.l
y.tab.o: y.tab.c VSM.h
y.tab.c y.tab.h : report3.y
	bison -dv -y report3.y
SymTable.o : SymTable.c
NameTable.o : NameTable.c

# clean
clean :
	-rm -f *.o ./data/*.to gen exe lex.yy.c y.tab.c y.tab.h y.output