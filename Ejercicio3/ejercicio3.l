%{
#include "ejercicio3.tab.h"
%}

HEX     0[xX][0-9a-fA-F]+
FLOAT   [0-9]+\.[0-9]+
INT     [0-9]+

%%
{FLOAT} { yylval.fval = atof(yytext); return NUMBER; }
{HEX}   { yylval.fval = (float)strtol(yytext, NULL, 16); return NUMBER; }
{INT}   { yylval.fval = atof(yytext); return NUMBER; }
"|"     { return OR;  }
"&"     { return AND; }
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"("     { return '('; }
")"     { return ')'; }
"abs"   { return ABS; }
\n      { return EOL; }
[ \t]   { }
"//".*  { }
.       { return yytext[0]; }
%%

int yywrap() { return 1; }

