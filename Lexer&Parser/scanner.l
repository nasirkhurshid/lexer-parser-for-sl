%{
#undef yywrap
#define yywrap() 1 
#include "parser.tab.h"
#include "driver.h"
int line_num = 1, lexerror = 0;
%}  
DIGIT   [0-9]
LETTER  ([a-z]|[A-Z])
KEYWORDS = (if|else|while|break|read|write|function|let|call|return)
%%
"#".*
" "*
"\t"*
"\r"*
"\n"          line_num++;
"=="          { return _EQUALEQUAL; }
"!="          { return _NOTEQUAL; }
"<"           { return _LESSER; }
"<="          { return _LESSEREQUAL; }
">"           { return _GREATER; }
">="          { return _GREATEREQUAL; }
"+"           { return _PLUS; }
"-"           { return _MINUS; }
"*"           { return _TIMES; }
"/"           { return _DIVIDE; }
"%"           { return _MODULUS; }
"~"           { return _TILDE; }
"|"           { return _BAR; }
"&"          { return _AMPERSAND; }
"!"           { return _EXCLAMATION; }
"{"           { return _LBARACES; }
"}"           { return _RBARACES; }
"("           { return _LPARAN; }
")"           { return _RPARAN; }
","           { return _COMMA; }
";"           { return _SEMICOLON; }
"="           { return _EQUAL; }
"if"          { return _IF; }
"else"        { return _ELSE; }
"while"       { return _WHILE; }
"break"       { return _BREAK; }
"read"        { return _READ; }
"write"       { return _WRITE; }
"function"    { return _FUNCTION; }
"let"         { return _LET; }
"call"        { return _CALL; }
"return"      { return _RETURN; }
{DIGIT}+      { return _NUMBER; }
{LETTER}({LETTER}|{DIGIT})*    { return _IDENTIFIER; } 
.          lexerror=1;  {return _LEXICALERROR;}
%%
