#include <stdio.h>
#include <stdlib.h>
#include "driver.h"

extern char *yytext;
extern int line_num;
extern int lexerror;

int yyerror(char *s) {
  if (lexerror)
    printf("Lexical error detected on line %d.\n",line_num);
  else
    printf("Syntax error detected on line %d.\n",line_num);
  return 0;
  
}

int main(int argc, char ** argv){

  if (!lexerror) {
    int error = yyparse();
        
    if (error==0)
      printf("Program is good to go");
      
  }
  
  return 0;
        
}

