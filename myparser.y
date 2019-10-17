%{
/****************************************************************************
myparser.y
ParserWizard generated YACC file.

Date: 2019Äê10ÔÂ17ÈÕ
****************************************************************************/

#include <iostream>
#include <cctype>
using namespace std;


%}

/////////////////////////////////////////////////////////////////////////////
// declarations section
%include{
#ifndef YYSTYPE
#define YYSTYPE double
#endif
}
// parser name
%name myparser

// class definition
{
 // place any extra class members here
 virtual int yygettoken();
 double yyvalue;
}

// constructor
{
 // place any extra initialisation code here
}

// destructor
{
 // place any extra cleanup code here
}

// place any declarations here
%token PLUS
%token MINUS
%token TIMES
%token OVER
%token LP
%token RP
%token NUMBER
%left PLUS MINUS
%left TIMES OVER
%right UMINUS



%%

/////////////////////////////////////////////////////////////////////////////
// rules section

// place your YACC rules here (there must be at least one)
lines : lines expr ';' {cout<<$2<<endl;}
      | lines ';'
      |
      ;
      
expr : expr PLUS expr {$$=$1+$3;}
  | expr MINUS expr {$$=$1-$3;}
  | expr TIMES expr {$$=$1*$3;}
  | expr OVER expr {$$=$1/$3;}
  | LP expr RP  {$$=$2;}
  | MINUS expr %prec UMINUS {$$=-$2;}
  | NUMBER {$$=yyvalue;}
  ;

%%

/////////////////////////////////////////////////////////////////////////////
// programs section

int YYPARSERNAME::yygettoken()
{
 // place your token retrieving code here
 int t;
 while(true)
 {
  t=getchar();
  if(t==' '||t=='\t'||t=='\n')
   continue;
  if(t=='+')
  return PLUS;
  if(t=='-')
  return MINUS;
  if(t=='*')
  return TIMES;
  if(t== '/')
  return OVER;
  if(t=='(')
  return LP;
  if(t==')')
  return RP;
  if(isdigit(t))
  {
   yyvalue=0.0;
   while(isdigit(t))
   {
    yyvalue=yyvalue*10+t-'0';
    t=getchar();
   }
   ungetc(t,stdin);
   return NUMBER;
   
   
  }
  
  return t;
 }
 // return getchar();
}
int main(void)
{
 int n = 1;
 myparser parser;
 if (parser.yycreate()) {
  n = parser.yyparse();
 }
 return n;
}