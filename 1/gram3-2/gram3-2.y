/* 数式の計算 */

%token NUM  // トークンの定義

%%
line    : expr '\n' { printf("%d\n", $1); }
        ;

expr    : expr '+' term { $$ = $1 + $3; }
        | expr '-' term { $$ = $1 - $3; }
        | term          { $$ = $1; }
        ;

term    : term '*' factor { $$ = $1 * $3; }
        | term '/' factor { $$ = $1 / $3; }
        | factor          { $$ = $1; }
        ;

factor  : '(' expr ')' { $$ = $2; }
        | NUM            { $$ = $1; }
        ;
%%

#include <ctype.h>

yylex(){                                        // 字句解析関数
    int c;

    while((c = getchar()) == ' ' || c == '\t'); // 空白を読み飛ばす
    if(isdigit(c)){                             // 数字なら
        yylval = c - '0';
        while(isdigit(c = getchar()))           // 数字列をint型の値へ
            yylval = yylval * 10 + c - '0';
        ungetc(c, stdin);                       // 入力文字をもとに戻す
        return NUM;
    }
    else                                        // 空白，数字以外なら
        return c;
}