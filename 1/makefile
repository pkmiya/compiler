FILENAME = report1

main: $(FILENAME).tab.c
	gcc -o main $(FILENAME).tab.c -ly -lm

$(FILENAME).tab.c: $(FILENAME).y
	bison -d $(FILENAME).y

clean:
	rm -f $(FILENAME).tab.c $(FILENAME).tab.h main