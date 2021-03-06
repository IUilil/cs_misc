%{

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include "simplesql.h"
#include "parser.hh"
%}

%option caseless
/*%option c++*/

string [\'][A-Za-z][A-Za-z0-9_]*[\']
id [A-Za-z][A-Za-z0-9_]*
number [0-9]+

%%

and    {return AND;}
create {return CREATE;}
delete {return DELETE;}
drop   {return DROP;}
exit   {return EXIT;}
from   {return FROM;}
int	   {return INT;}
char   {return CHAR;}
select {return SELECT;}
table  {return TABLE;}
where  {return WHERE;}

[;] | 
[(] | 
[)] |
[,] |
[*] |
[=] |
[!] |
[>] | 
[<] |
"<=" |
">=" |
"<>"   {return *yytext;}
 
{id}  {yylval.strval=strdup(yytext); return ID;}
{string}  {yylval.strval=strdup(yytext); return STRING;}
{number} {yylval.intval=atoi(yytext); return NUMBER;}
\n     {return *yytext;}
[ \t]+

 /*bad character*/
. {fprintf(stderr, "lex error, unexpected charactor '%s'\n", yytext);}

%%
