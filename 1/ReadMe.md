# Get started
Create a yacc file. For example, type `touch report1.y` to create an empty yacc file named `report1.y`.

# Compile
Type `make` to compile.
The makefile will execute below commands to compile yacc file `report1.y`. 
```bash
bison -d report1.y
gcc report1.tab.c -ly -lm -o main
```

# Run
## Input data manually
Just type `./main` to run the program.

# Compile & run in one command
Type `sh run.sh` to compile and run the program.