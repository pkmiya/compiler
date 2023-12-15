bison -dv -y report2.y
flex -l report2.l
gcc y.tab.c lex.yy.c -ly -ll -lm -o report2

while read -r input; do
    echo "$input"
    echo "$input" | ./report2
done < test.txt

# sh run.sh