%{
#include "ejercicio1.tab.h"
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]   { }
"//".*  { }
.       { return yytext[0]; }
%%

int yywrap() { return 1; }

