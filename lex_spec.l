%{
#include <stdio.h>
#include "y.tab.h"

int current_dtype;
%}

D               [0-9]
L               [a-zA-Z]
A               {D}|{L}|_
H               [a-fA-F0-9]

%%
"int"               { current_dtype= 4; return(T_INT);}
"char"              { current_dtype= 1; return(T_CHAR);}
"double"            { current_dtype= 8; return(T_DOUBLE);}
"float"             { current_dtype= 4; return(T_FLOAT);}
"long"              { current_dtype= 8; return(T_LONG);}
"short"             { current_dtype= 2; return(T_SHORT);}
"unsigned"          { return(T_UNSIGNED);}
"const"             { return(T_CONST);}

"for"               { return(T_FOR);}
"while"             { return(T_WHILE);}
"do"                { return(T_DO);}
"if"                { return(T_IF);}
"else"              { return(T_ELSE);}
"switch"            { return(T_SWITCH);}
"case"              { return(T_CASE);}
"default"           { return(T_DEFAULT);}
"break"             { return(T_BREAK);}
"continue"          { return(T_CONTINUE);}

"//".*				{}
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       {}
[/][*]                                    {}
"goto"              { return(T_GOTO);}
"return"            { return(T_RETURN);}
"static"            { return(T_STATIC);}
"struct"            { return(T_STRUCT);}
"typedef"           { return(T_TYPEDEF);}
"void"              { return(T_VOID);}

({L}|_){A}*       {insert(symbol_table, yytext, current_dtype, 0, yylineno); return(T_IDENTIFIER);}
{D}+({L}|_)+      {insert(symbol_table, "invalid token", current_dtype, 0, yylineno); return(T_IDENTIFIER);}
0[xX]{H}+           { return(T_CONSTANT);}
{D}+                { return(T_CONSTANT);}
L?'(\\.|[^\\'])+'   { return(T_CONSTANT);}
\n                  {yylineno++;}

{D}+[Ee][+-]?{D}+             { return(T_CONSTANT);}
{D}*"."{D}+([Ee][+-]?{D}+)?   { return(T_CONSTANT);}
{D}+"."{D}*([Ee][+-]?{D}+)?   { return(T_CONSTANT);}

\"(\\.|[^\\"])*\" { return(T_STRING_LITERAL);}

">>="               { return(T_RIGHT_ASSIGN);}
"<<="               { return(T_LEFT_ASSIGN);}
"+="                { return(T_ADD_ASSIGN);}
"-="                { return(T_SUB_ASSIGN);}
"*="                { return(T_MUL_ASSIGN);}
"/="                { return(T_DIV_ASSIGN);}
"%="                { return(T_MOD_ASSIGN);}
"&="                { return(T_AND_ASSIGN);}
"^="                { return(T_XOR_ASSIGN);}
"|="                { return(T_OR_ASSIGN);}
">>"                { return(T_RIGHT_OP);}
"<<"                { return(T_LEFT_OP);}
"++"                { return(T_INC_OP);}
"--"                { return(T_DEC_OP);}
"->"                { return(T_PTR_OP);}
"&&"                { return(T_AND_OP);}
"||"                { return(T_OR_OP);}
"<="                { return(T_LE_OP);}
">="                { return(T_GE_OP);}
"=="                { return(T_EQ_OP);}
"!="                { return(T_NE_OP);}
";"                 { return(';');}
("{"|"<%")          { return('{');}
("}"|"%>")          { return('}');}
","                 { return(',');}
":"                 { return(':');}
"="                 { return('=');}
"("                 { return('(');}
")"                 { return(')');}
("["|"<:")          { return('[');}
("]"|":>")          { return(']');}
"."                 { return('.');}
"&"                 { return('&');}
"!"                 { return('!');}
"~"                 { return('~');}
"-"                 { return('-');}
"+"                 { return('+');}
"*"                 { return('*');}
"/"                 { return('/');}
"%"                 { return('%');}
"<"                 { return('<');}
">"                 { return('>');}
"^"                 { return('^');}
"|"                 { return('|');}
"?"                 { return('?');}

[ \t\v\n\f]        {}
.            {/* ignore bad characters */}

%%

yywrap()
{
    return(1);
}

