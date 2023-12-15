%{
#include <stdio.h>
#include <math.h>
int yylex(void);
void yyerror(const char *s);
int getchar(void);

double degree(double rad);
%}

%union{
    int     ival;
    double  rval;
}

%token EXP LOG SQRT MAX MIN FACT ABS DEG PI E SIN ARCSIN
%token <ival> INTC;
%token <rval> DOUBLEC;
%type  <rval> line expr 

%right '='
%left '+' '-'
%left '*' '/' '%'
%right '^'
%right MINUS

%%

line    :                   { printf(" "); }
        | line expr '\n'    { printf("> %f\n", $2); }
        | line error '\n'   { yyerrok; }
        ;

expr    : expr '+' expr		{ $$ = $1 + $3; }
        | expr '-' expr		{ $$ = $1 - $3; }
        | expr '*' expr		{ $$ = $1 * $3; }
        | expr '/' expr		{ if($3 == 0) {
                                yyerror("error: zero division");
                                $$ = 0;
                            } else {
                                $$ = $1 / $3;
                            }}
        | expr '%' expr		        { $$ = fmod($1, $3); }
        | expr '^' expr		        { $$ = pow($1, $3); }
        | '(' expr ')'		        { $$ = $2; }
        | '-' expr %prec MINUS	    { $$ = -$2; }
        | LOG '(' expr ')'	        { $$ = log($3); }
        | EXP '(' expr ')'	        { $$ = exp($3); }
        | SQRT '(' expr ')'	        { $$ = sqrt($3); }
        | MAX '(' expr ',' expr ')'	{ $$ = fmax($3, $5); }
        | MIN '(' expr ',' expr ')'	{ $$ = fmin($3, $5); }
        | '(' expr ')' FACT         { $$ = tgamma($2 + 1); }
        | ABS '(' expr ')'	        { $$ = fabs($3); }
        | DEG '(' expr ')'	        { $$ = degree($3); }
        | PI                        { $$ = M_PI; }
        | E                         { $$ = M_E; }
        | SIN '(' expr ')'	        { $$ = sin($3); }
        | ARCSIN '(' expr ')'	    { $$ = asin($3); }
        | INTC                      { $$ = (double)$1; }
        | DOUBLEC                   { $$ = $1; }

%%

#include <ctype.h>

int main(void){
    yyparse();
    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "%s\n", s);
}

double degree(double rad){
    return rad * 180 / M_PI;
}