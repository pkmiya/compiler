/* 簡単な電卓 */

%{
#include <stdio.h>
#include <math.h>
int yylex(void);
void yyerror(const char *s);
int getchar(void);

char usingChar[] = {
    '0','1','2','3','4','5','6','7','8','9',
    '+','-','*','/','%','^','r','(',')','\n'
};
char QUIT = 'q';

int isUsedChar(int);
void exit(int);
%}

%start line

%%

line    : expr '\n'    { 
                        printf("> %d\n", $1);    // 再帰的に計算結果を出力
                        if(yyparse()) exit(1); // syntax errorならば終了
                        }
        ;

expr    : expr '+' term		{ $$ = $1 + $3; }
        | expr '-' term		{ $$ = $1 - $3; }
        | term				{ $$ = $1; }
        ;

term    : term '*' factor	{ $$ = $1 * $3; }
        | term '/' factor	{ if($3 == 0) {
                                printf("error: division by zero\n");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }
                            }
        /* 剰余演算子・べき乗演算子を追加 */
        | term '%' factor	{ $$ = $1 % $3; }
        | term '^' factor	{ $$ = pow($1, $3); }

        | factor		    { $$ = $1; }
        ;

factor  : '(' expr ')'   	{ $$ = $2; }
        | '-''(' expr ')'	{ $$ = -$3; }
        | negative_factor   { $$ = $1; }
        | positive_factor   { $$ = $1; }
        | root_factor       { $$ = $1; }
        ;

negative_factor
        : '-' positive_factor   { $$ = -$2; }
        | '-' root_factor       { $$ = -$2; }
        ;

positive_factor
        : '0'		        { $$ = 0; }
        | '1'		        { $$ = 1; }
        | '2'		        { $$ = 2; }
        | '3'		        { $$ = 3; }
        | '4'		        { $$ = 4; }
        | '5'		        { $$ = 5; }
        | '6'		        { $$ = 6; }
        | '7'		        { $$ = 7; }
        | '8'		        { $$ = 8; }
        | '9'		        { $$ = 9; }
        ;

root_factor
        : 'r' positive_factor { $$ = sqrt($2); }
        ;

%%

#include <ctype.h>

int yylex(){
    int c;

    while(1){
        c = getchar();

        /* 空白とタブを読み飛ばす */
        if(c != ' ' && c != '\t'){
            if(isUsedChar(c)) break;
        }

        /* QUIT(q)を入力でプログラム終了 */
        if(c == QUIT) exit(0);

        /* 予約文字以外の場合，エラーを出力して文字を再読み込み */
        printf("error: invalid character '%c'\n", c);
    }
    return c;
}

int isUsedChar(int c){
    int i;
    int arraySize = sizeof(usingChar) / sizeof(char);
    for(i = 0; i < arraySize; i++){
        if(c == (char)usingChar[i]) return 1;
    }
    return 0;
}