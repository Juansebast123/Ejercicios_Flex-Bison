%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(char *s);
%}

%union {
    float fval;
}

/* declare tokens */
%token <fval> NUMBER
%token ADD SUB MUL DIV OR AND ABS UMINUS
%token EOL

%type <fval> exp factor term

%start calclist

%%
calclist: /* nothing */
 | calclist exp EOL { printf("= %f\n", $2); }
 | EOL { }
 ;
exp: factor { $$ = $1; }
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 | exp AND factor { $$ = (int)$1 & (int)$3; }
 | exp OR  factor { $$ = (int)$1 | (int)$3; }
 ;
factor: term { $$ = $1; } 
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { 
	if ($3 == 0.0f) { yyerror("division by zero"); $$ = 0.0f; }
        else $$ = $1 / $3; }
 ;
term: NUMBER { $$ = $1; } 
 | '(' exp ')' { $$ = $2; }
 | SUB term %prec UMINUS { $$ = -$2; }
 | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
;
%%
int main(int argc, char **argv) {
 return yyparse();
}
void yyerror(char *s) {
 fprintf(stderr, "error: %s\n", s);
}
