%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "VSM.h"
#include <stdlib.h>
int yyparse(void);
int yylex(void);
void yyerror(const char *s);
int getchar(void);
void SymDecl(char *);
int  SymRef(char *);
void exit(int);


%}

%union{
    int     ival;
    double  rval;
    char    *Name;
}

%token	TYPE IF ELSE READ WRITE
%token	<ival> INTC RELOP ADDOP MULOP PPMM FUNCOP COMPFUNCOP MATHCHAR
%token	<rval> REALC;
%token	<Name> ID;
%type	<dval> expr 
%type	<ival> if_part

%right	'='
%left	MATHCHAR
%left	RELOP
%left	ADDOP
%left	MULOP
%left	FUNCOP
%left	COMPFUNCOP

%right	'!' PPMM UM
%left	POSOP

%start	program

%%
program		: decl_list s_list		{ Pout(HALT); }
			;
decl_list 	:						/* empty grammar */
			| decl_list decl ';'
			;
decl		: TYPE ID				{ SymDecl($2); }
			| decl ',' ID			{ SymDecl($3); }
			;
s_list		: stmnt
			| s_list stmnt
			;
stmnt		:
			| WRITE expr ';'		{ Pout(OUTPUT); } 
			| READ LHS ';'			{ Pout(INPUT); }
			| expr ';'				{ Pout(REMOVE); }
			| error ';'				{ yyerrok; }

			  /* if statements */
			| '{' s_list '}'
			| if_part				{ Bpatch($1, PC()); }
			| if_part ELSE			{ $<ival>$ = PC();
									  Cout(JUMP, -1);
                                   	  Bpatch($1, PC()); }
          	stmnt					{ Bpatch($<ival>3, PC()); }
        	;
LHS			: ID					{ Cout(PUSHI, SymRef($1)); }
        	;
if_part		: IF '(' expr ')'		{ $<ival>$ = PC();
									  Cout(BEQ, -1); }
			stmnt              		{ $$ = $<ival>5; }
        	;
expr		: expr ADDOP expr					{ Pout($2); }
    		| expr MULOP expr					{ Pout($2); }
    		| '(' expr ')'
    		| FUNCOP '(' expr ')'				{ Pout($1); }
    		| COMPFUNCOP '(' expr ',' expr ')'	{ Pout($1); }
    		| ADDOP expr %prec UM 				{ if( $1 == SUB) Pout(CSIGN); }
    		| LHS '=' expr 						{ Pout(ASSGN); }
    		| PPMM ID				{ int addr = SymRef($2);
    		                          Cout(PUSH, addr);
									  Pout($1);
    		                    	  Pout(COPY);
									  Cout(POP, addr); }
    		| ID PPMM %prec POSOP	{ int addr = SymRef($1);
    		                          Cout(PUSH, addr);
									  Pout(COPY);
    		                          Pout($2);
									  Cout(POP, addr); }
    		| ID                   	{ Cout(PUSH,
									  SymRef($1)); }
    		| expr RELOP expr		{ Pout(COMP);
									  Cout($2, PC()+3);
    		                          Cout(PUSHI, 0);
									  Cout(JUMP, PC()+2);
    		                          Cout(PUSHI, 1);}
			| MATHCHAR				{ Pout($1); }
    		| INTC	{{ Cout(PUSHI, (double)$1); }}
    		| REALC {{ Cout(PUSHI, $1); }}
    		;
%%

static	char SourceFile[20];
extern  FILE *yyin;
		char outputFilename[256];
	    FILE *fp_o;
int			StartP = 0, SymPrintSW = 0;                 
static int	ExecSW = 1, ObjOutSW = 0, TraceSW = 0, StatSW = 0;

int main(int argc, char* argv[]) {
	// open source file
    strncpy(SourceFile, argv[1], sizeof(SourceFile));
    yyin = fopen(SourceFile, "r");
    if (yyin == NULL) {
        perror("Error: cannot open source file");
        exit(1);
    }
	// open object code file
    snprintf(outputFilename, sizeof(outputFilename), "%.*s.to", (int)(strrchr(argv[1], '.') - argv[1]), argv[1]);
    fp_o = fopen(outputFilename, "w");
    if (fp_o == NULL) {
        perror("Error: cannot open object code file");
        fclose(yyin);
        exit(1);
    }

    yyparse();
    createObjectCode(fp_o);
    fclose(fp_o);
    fclose(yyin);
    return 0;
}