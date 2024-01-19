%{
#include "y.tab.h"
#include "VSM.h"
char *IDentry(char *, int);
%}

ws      [ \t\n]
symbol  [=?!(),;:{}]
digit   [0-9]
letter  [a-zA-Z_] 
id      {letter}({letter}|{digit})*
other   .

%%
{ws}+
{symbol}	{ return(yytext[0]); }
"+"			{ yylval.ival = ADD; return ADDOP; }
"-"			{ yylval.ival = SUB; return ADDOP; }
"*"			{ yylval.ival = MUL; return MULOP; }
"/"			{ yylval.ival = DIV; return MULOP; }
"%"			{ yylval.ival = MOD; return MULOP; }
"^"			{ yylval.ival = POW; return MULOP; }
"++"		{ yylval.ival = INC; return PPMM;  }
"--"		{ yylval.ival = DEC; return PPMM;  }
"<"			{ yylval.ival = BLT; return RELOP; }
"<="		{ yylval.ival = BLE; return RELOP; }
"=="		{ yylval.ival = BEQ; return RELOP; }
"!="		{ yylval.ival = BNE; return RELOP; }
">="		{ yylval.ival = BGE; return RELOP; }
">"			{ yylval.ival = BGT; return RELOP; }
"int"		{ return TYPE; }
"double"	{ return TYPE; }
"log"		{ yylval.ival = LOG; return FUNCOP; }
"exp"		{ yylval.ival = EXP; return FUNCOP; }
"sqrt"		{ yylval.ival = SQRT;return FUNCOP; }
"max"		{ yylval.ival = MAX; return COMPFUNCOP; }
"min"		{ yylval.ival = MIN; return COMPFUNCOP; }
"!"			{ yylval.ival = FACT;return FUNCOP; 	}
"pi"		{ yylval.ival = PI;  return MATHCHAR; 	}
"e"			{ yylval.ival = E;	 return MATHCHAR; 	}
"abs"		{ yylval.ival = ABS;	return FUNCOP; 	}
"deg"		{ yylval.ival = DEG;	return FUNCOP; 	}
"sin"		{ yylval.ival = SIN;    return FUNCOP; 	}
"arcsin"	{ yylval.ival = ARCSIN; return FUNCOP; 	}
"read"		{ return READ;	}
"write"		{ return WRITE; }
"if"		{ return IF; 	}
"else"		{ return ELSE; 	}

{digit}+	{
			  sscanf(yytext, "%d", &yylval.ival);
			  return(INTC);
            }
{digit}+"."{digit}* { 
              sscanf(yytext, "%lf", &yylval.rval);
              return(REALC);
			}
{id}		{ yylval.Name = IDentry(yytext, yyleng); return ID; }
{other}		{
              fprintf(stderr, "Illegal char '%c' ignored\n", yytext[0]);
			}
%%