%{
#include "y.tab.h"
%}

ws      [¥t]
symbol  [=+\-*/\^()[\]%,\n]
digit   [0-9]
other   .

%%
{ws}+
{symbol}    { return(yytext[0]); }
"exp"       { return(EXP); }
"log"		{ return(LOG); }
"sqrt"      { return(SQRT); }
"max"		{ return(MAX); }
"min"		{ return(MIN); }
"!"			{ return(FACT); }
"pi"		{ return(PI); }
"e"			{ return(E); }
"abs"		{ return(ABS); }
"deg"		{ return(DEG); }
"sin"       { return(SIN); }
"arcsin"    { return(ARCSIN); }

{digit}+    {
			  sscanf(yytext, "%d", &yylval.val_i);
			  return(INTC);
            }
{digit}+"."{digit}* { 
              sscanf(yytext, "%lf", &yylval.val_d);
              return(DOUBLEC);
            }
{other}     {
              fprintf(stderr, "Illegal char '%c' ignored\n", yytext[0]);
            }
%%