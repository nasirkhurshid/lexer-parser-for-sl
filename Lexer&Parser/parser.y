%{
extern int yylex (void);
void yyerror(char *);
%}

%token _IF 
%token _ELSE 
%token _WHILE 
%token _BREAK 
%token _READ 
%token _WRITE 
%token _FUNCTION 
%token _LET 
%token _CALL  
%token _RETURN 
%token _PLUS 
%token _MINUS 
%token _TIMES 
%token _DIVIDE 
%token _MODULUS 
%token _TILDE 
%token _LESSER 
%token _GREATER 
%token _NOTEQUAL  
%token _EQUALEQUAL 
%token _LESSEREQUAL 
%token _GREATEREQUAL 
%token _EQUAL 
%token _AMPERSAND 
%token _BAR 
%token _EXCLAMATION 
%token _LBARACES 
%token _RBARACES 
%token _LPARAN 
%token _RPARAN 
%token _SEMICOLON 
%token _COMMA 
%token _NUMBER 
%token _IDENTIFIER 
%token _LEXICALERROR 


%start PROGRAM

%%

PROGRAM : FUNCTION_TIMES BLOCK
    ;

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



