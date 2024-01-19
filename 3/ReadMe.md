# Get started
- Fix your files: `report3.l`, `report3.y`
- Fix given files: `VSM.c`, `VSM.h`, `main.c`
- Copy given files: `SymTable.c`, `NameTable.c`
- For given files, refer to the directory `./3/distributed/`

# Compile
## General compile
- Type `sh run.sh` to clean chore files & compile all files. This command will execute generate below commands.
```shell
make clean
make
```
- This command generates `gen` and `exe` files including other chore files.
## Just clean
- If you just want to clean, type `make clean`. 
- Clean command removes .o, .to, yacc and lex files.

## [If necessary] Fix permissions
If you are told "Permission denied" when you execute `./gen` or `./exe`, fix permissions. by typing below commands.
```bash
chmod +x ./gen ./exe
```

# Execute (test data)
## 0. Prepare test data
- Create a Tiny C file ending with `.tc` in ``./data` directory
- Write your calculation code in the file. If you want to see the result in the execution result, use `write()` function.
## 1. Execute testing
### 1-1. Auto testing
- If your test data is named `test.tc`, Type `./calc.sh test`.
- This command will execute commands `gen` and `exe` automatically.
### 1-2. Manual testing
- Type `./gen test1.tc`.
  - This command loads source code and generates object codes and will generate `test1.to` file.
- Then, type `./exe test1.to`.
  - This command loads and executes object codes.
  - You will see the stack status and result in terminal. 

# Sample data
- `test1.tc`: single calc & print
- `test2.tc`: single calc & print & if-else
- `test3.tc`: multiple calc & print

# Concerns
Below calculations are not available. There may be more.
- Factorial: 3!
- Max: max(2,1)