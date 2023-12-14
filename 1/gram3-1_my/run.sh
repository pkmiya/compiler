bison -d filename.y
gcc filename.tab.c -ly -lm -o ExpParser
./ExpParser
# ./ExpParser < input.txt
# sh run.sh