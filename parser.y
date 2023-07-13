%{
#include <stdio.h>
#include <stdlib.h>

extern int yyparse();
extern int yylex (void);
extern char *yytext;
extern int line_num;
extern int lexerror;

int yyerror(char *s) {
  if (lexerror)
    printf("Lexical error on line %d at token: %s ",line_num, yytext);
  else
    printf("Syntax error on line %d at token: %s ",line_num, yytext);
  return 0;
  
}

int main(int argc, char ** argv){
  if (!lexerror) {
    int error = yyparse();
    if (error==0){
      printf("Program is OK");
    }
  }
  return 0;     
}
%}

%token _AMPERSAND _BAR _EXCLAMATION _LBARACES _LPARAN _MODULUS _RBARACES _RPARAN _SEMICOLON _TILDE
%token _COMMA _DIVIDE _EQUAL _GREATER _LESSER _MINUS _PLUS _TIMES
%token _BREAK _CALL _ELSE _FUNCTION _IF _LET _READ _RETURN _WHILE _WRITE
%token _EQUALEQUAL _GREATEREQUAL _LESSEREQUAL _NOTEQUAL
%token _IDENTIFIER _LEXICALERROR _NUMBER


%start PROGRAM

%%

PROGRAM : FUNCTION_TIMES BLOCK

FUNCTION_TIMES :
    |   FUNCTION FUNCTION_TIMES

FUNCTION :
    _FUNCTION _IDENTIFIER _LPARAN PARAMLIST _RPARAN BLOCK

PARAMLIST :
    _IDENTIFIER PARAMREST
    |
    ;

PARAMREST :
    _COMMA _IDENTIFIER PARAMREST
    |
    ;

BLOCK :
    _LBARACES STATEMENT_TIMES _RBARACES

STATEMENT_TIMES :
    | STATEMENT STATEMENT_TIMES

STATEMENT :
    BREAK
    | CALL _SEMICOLON
    | IF
    | LET
    | READ
    | RETURN 
    | WHILE
    | WRITE

BREAK :
    _BREAK _SEMICOLON

CALL :
    _CALL _IDENTIFIER _LPARAN ARGLIST _RPARAN

ARGLIST :
  EXPR ARGREST
  |
  ;

ARGREST :
   _COMMA EXPR ARGREST
  |
  ;

IF :
  _IF EXPR BLOCK ELSE
  ;

ELSE :
  _ELSE BLOCK
  |
  ;

LET :
  _LET _IDENTIFIER _EQUAL EXPR _SEMICOLON
  | _LET _IDENTIFIER _EQUAL CALL _SEMICOLON
  ;

READ :
  _READ _IDENTIFIER _SEMICOLON
  ;

RETURN :
  _RETURN EXPR _SEMICOLON
  ;

WHILE :
  _WHILE EXPR BLOCK
  ;

WRITE :
  _WRITE EXPR _SEMICOLON
  ;

EXPR :
  _NUMBER
  | _IDENTIFIER
  | _LPARAN EXPR _RPARAN
  | _LPARAN UNOP EXPR _RPARAN
  | _LPARAN BINOP EXPR EXPR _RPARAN
  ;

BINOP :
  _PLUS
  | _MINUS
  | _TIMES
  | _DIVIDE
  | _MODULUS
  | _AMPERSAND
  | _BAR
  | _LESSER
  | _GREATER
  | _LESSEREQUAL
  | _GREATEREQUAL
  | _EQUALEQUAL
  | _NOTEQUAL
;

UNOP :
  _TILDE
  | _EXCLAMATION
;

%%
