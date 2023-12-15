%{
    #include <stdio.h>
    #include <math.h>

    int yylex(void);
    void yyerror(const char *s);
%}

%union{
    int     ival;
    double  dval;
}

%token SQRT SIN ARCSIN
%token <ival> INTNUM
%token <dval> DNUM
%type <dval> expr
%type <dval> term
%type <dval> factor
%%

line    : 
        | line  expr     '\n'       { printf("%lf\n", $2); }     
        | line  error    '\n'       { yyerrok; }
        ;

expr    : expr  '+' term            { $$ = $1 + $3; }       
        | expr  '-' term            { $$ = $1 - $3; }       
        | expr  '<' term            { $$ = (int)$1 << (int)$3; }
        | expr  '>' term            { $$ = (int)$1 >> (int)$3; }
        | SQRT '(' expr ')'         { $$ = sqrt($3); }
        | SIN  '(' expr ')'         { $$ = sin($3); }
        | ARCSIN  '(' expr ')'      { $$ = asin($3); }
        | term
        ;

term    : term '*' factor           { $$ = $1 * $3; }
        | term '/' factor           { $3 ? $$ = $1 / $3 : printf("ZeroDivisionError\n"); }
        | term '%' factor           { $3 ? $$ = (int)$1 % (int)$3 : printf("ZeroDivisionError\n"); }
        | term '^' factor           { $$ = pow($1, $3);}
        | factor
        ;

factor  : '(' expr ')'              { $$ = $2; }
        | '-'INTNUM                 { $$ = -(double)$2; }
        | INTNUM                    { $$ = (double)$1; }
        | '-'DNUM                   { $$ = -$2; }
        | DNUM                      { $$ = $1; }
        ;

%%
int main(void)
{
    yyparse();
    return 0;
}
