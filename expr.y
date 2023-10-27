/* Yaccで定義した式の定義 */

%%

input: /* 空 */
     | input line
     ;

line: '\n'
    | exp '\n' { printf("%d\n", $1); }
    ;

exp: NUM { $$ = $1; }
    | exp '+' exp { $$ = $1 + $3; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '/' exp { $$ = $1 / $3; }
    | '(' exp ')' { $$ = $2; }
    ;
%%

/* 以下はyaccのエラー処理用の関数群 */
int yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
  return 1;
}