# Get started
Create a yacc file and lex file. For example, type `touch report2.y report2.l` to create an empty yacc file named `report2.y` and `report2.l`.

# Compile
Type `make` to compile.
The makefile will execute below commands to compile the both files. 
```bash
bison -dv -y report2.y
flex -l report2.l
gcc y.tab.c lex.yy.c -ly -ll -lm -o main
```

# Run
## Input data manually
Just type `./main` to run the program.

## Input data from text file
- Write down test data in a text file `input.txt`.
- Type `run_test.sh` to run the program. This script will execute below commands.
```bash
make
while read -r input; do
    echo "$input"
    echo "$input" | ./main
done < test.txt
```

# Compile & run in one command
Type `sh run.sh` to compile and run the program.