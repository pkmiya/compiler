/* Yaccで定義した式の定義 */

%%

input:  expr '\n';
expr:   expr '+' term | expr '-' term | term;
term:   term '*' factor | term '/' factor | factor;
factor: 'i' | '(' expr ')';

%%

#include <stdio.h>

main(){
    yyparse();
}

yylex(){
    getchar();
}