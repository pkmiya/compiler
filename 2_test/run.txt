bison -dv -y report2.y
flex -l report2.l
gcc y.tab.c lex.yy.c -ly -ll -lm -o report2
./report2

# sh run.sh