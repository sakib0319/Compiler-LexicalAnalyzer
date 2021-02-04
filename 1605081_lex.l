%option noyywrap

%x STRING
%x SINGLECMNT
%x MULTICMNT

%{

#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<string>
#include<string.h>
#include"1605081_symbolTable.cpp"
using namespace std;

int line_count=1;
int error_count=0;


ScopeTable st(10,1);

string logoutput,tokenoutput;
string logoutputSingleCmnt;
string logoutputMultiCmnt;
int lineString=0,lineSingle=0,lineMult=0;
%}

WHITESPACE [ \t\f\r\v]+ 
LETTER [a-zA-Z]
DIGIT [0-9]
NEWLINE \n

%%

{NEWLINE} {line_count++;}
{WHITESPACE} {}

"if"	{
			fprintf(tokenout,"<IF>");
			fprintf(logout,"Line no %d: TOKEN <IF> Lexeme %s found\n",line_count,yytext);
		}
		
"else"	{
			fprintf(tokenout,"<ELSE>");
			fprintf(logout,"Line no %d: TOKEN <ELSE> Lexeme %s found\n",line_count,yytext);
		}

"for"	{
			fprintf(tokenout,"<FOR>");
			fprintf(logout,"Line no %d: TOKEN <FOR> Lexeme %s found\n",line_count,yytext);
		}

"while"	{
			fprintf(tokenout,"<WHILE>");
			fprintf(logout,"Line no %d: TOKEN <WHILE> Lexeme %s found\n",line_count,yytext);
		}		

"do"	{
			fprintf(tokenout,"<DO>");
			fprintf(logout,"Line no %d: TOKEN <DO> Lexeme %s found\n",line_count,yytext);
		}

"break"	{
			fprintf(tokenout,"<BREAK>");
			fprintf(logout,"Line no %d: TOKEN <BREAK> Lexeme %s found\n",line_count,yytext);
		}

"int"	{
			fprintf(tokenout,"<INT>");
			fprintf(logout,"Line no %d: TOKEN <INT> Lexeme %s found\n",line_count,yytext);
		}

"char"	{
			fprintf(tokenout,"<CHAR>");
			fprintf(logout,"Line no %d: TOKEN <CHAR> Lexeme %s found\n",line_count,yytext);
		}

"float"	{
			fprintf(tokenout,"<FLOAT>");
			fprintf(logout,"Line no %d: TOKEN <FLOAT> Lexeme %s found\n",line_count,yytext);
		}

"double"	{
			fprintf(tokenout,"<DOUBLE>");
			fprintf(logout,"Line no %d: TOKEN <DOUBLE> Lexeme %s found\n",line_count,yytext);
		}

"void"	{
			fprintf(tokenout,"<VOID>");
			fprintf(logout,"Line no %d: TOKEN <VOID> Lexeme %s found\n",line_count,yytext);
		}		

"return"	{
			fprintf(tokenout,"<RETURN>");
			fprintf(logout,"Line no %d: TOKEN <RETURN> Lexeme %s found\n",line_count,yytext);
		}		

"switch"	{
			fprintf(tokenout,"<SWITCH>");
			fprintf(logout,"Line no %d: TOKEN <SWITCH> Lexeme %s found\n",line_count,yytext);
		}		

"case"	{
			fprintf(tokenout,"<CASE>");
			fprintf(logout,"Line no %d: TOKEN <CASE> Lexeme %s found\n",line_count,yytext);
		}

"default"	{
			fprintf(tokenout,"<DEFAULT>");
			fprintf(logout,"Line no %d: TOKEN <DEFAULT> Lexeme %s found\n",line_count,yytext);
		}

"continue"	{
			fprintf(tokenout,"<CONTINUE>");
			fprintf(logout,"Line no %d: TOKEN <CONTINUE> Lexeme %s found\n",line_count,yytext);
		}



"+"		|

"-"		{
			fprintf(tokenout,"<ADDOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ADDOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"ADDOP");
		}

"*"		|

"/"		|

"%"		{
			fprintf(tokenout,"<MULOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <MULOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"MULOP");
		}

"++"		|

"--"		{
			fprintf(tokenout,"<INCOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <INCOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"INCOP");
		}

"<"		|

"<="		|

">"		|

">="		|

"=="		|

"!="		{
			fprintf(tokenout,"<RELOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RELOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"RELOP");
		}

"="		{
			fprintf(tokenout,"<ASSIGNOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <ASSIGNOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"ASSIGNOP");
		}

"&&"		|

"||"		{
			fprintf(tokenout,"<LOGICOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LOGICOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"LOGICOP");
		}

"&"		|

"^"		|

">>"		|

"<<"		|

"|"		{
			fprintf(tokenout,"<BITOP,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <BITOP> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"BITOP");
		}

"!"		{
			fprintf(tokenout,"<NOT,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <NOT> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"NOT");
		}

"("		{
			fprintf(tokenout,"<LPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LPAREN> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"LPAREN");
		}

")"		{
			fprintf(tokenout,"<RPAREN,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RPAREN> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"RPAREN");
		}

"{"		{
			fprintf(tokenout,"<LCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LCURL> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"LCURL");
		}		

"}"		{
			fprintf(tokenout,"<RCURL,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RCURL> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"RCURL");
		}

"["		{
			fprintf(tokenout,"<LTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <LTHIRD> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"LTHIRD");
		}

"]"		{
			fprintf(tokenout,"<RTHIRD,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <RTHIRD> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"RTHIRD");
		}

","		{
			fprintf(tokenout,"<COMMA,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <COMMA> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"COMMA");
		}

";"		{
			fprintf(tokenout,"<SEMICOLON,%s>",yytext);
			fprintf(logout,"Line no %d: TOKEN <SEMICOLON> Lexeme %s found\n",line_count,yytext);
			//insert in symbol table and print symbol table content(only non empty buckets)
			// There is a '|' in "+"'s rule, this means match execute the action for following rule
			st.insertItem(yytext,"SEMICOLON");
		}


{DIGIT}+ 	{
				fprintf(tokenout,"<CONST_INT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_INT> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_INT");
			}

({DIGIT}*[\.]{DIGIT}+|{DIGIT}+[\.]?)(E(-)?{DIGIT}+)? {

				fprintf(tokenout,"<CONST_FLOAT,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <CONST_FLOAT> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_FLOAT");
}

'' {
	 fprintf(logout,"Error at line no %d: Empty character constant error %s \n",line_count,yytext);
	 error_count++;
 }

'[^\\\n]'			{	fprintf(tokenout,"<CONST_CHAR,%c>",yytext[1]);
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
} 

'\\n' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\n');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\t' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\t');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\a' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\a');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\f' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\f');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\r' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\r');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\b' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\b');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\v' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\v');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\0' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\0');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}

'\\\\' {
				fprintf(tokenout,"<CONST_CHAR,%c>",'\\');
				fprintf(logout,"Line no %d: TOKEN <CONST_CHAR> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"CONST_CHAR");
}
 
[a-zA-Z_][a-zA-Z0-9]* {
				fprintf(tokenout,"<ID,%s>",yytext);
				fprintf(logout,"Line no %d: TOKEN <ID> Lexeme %s found\n",line_count,yytext);
				st.insertItem(yytext,"ID");

}

\" { 
	BEGIN STRING;
	logoutput = logoutput + yytext;
	tokenoutput = tokenoutput + yytext;
	lineString = line_count;
}

<STRING>[^\\\"\n] {
	logoutput = logoutput + yytext;
	tokenoutput = tokenoutput + yytext;
}

<STRING>\\[^ntafrbv0\\\n] {
			logoutput = logoutput+yytext;
			tokenoutput = tokenoutput+yytext[1];
}

<STRING>\\n {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\n';
				}
<STRING>\" {
				BEGIN INITIAL;
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + yytext;
				fprintf(tokenout,"<STRING, %s>",tokenoutput.c_str());
				fprintf(logout,"Line no %d: TOKEN <String> Lexeme %s found\n",lineString,logoutput.c_str());
				logoutput = "";
				tokenoutput = "";
}

<STRING>\\t {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\t';
}

<STRING>\\a {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\a';
}

<STRING>\\f {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\f';
}

<STRING>\\r {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\r';
}

<STRING>\\b {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\b';
}

<STRING>\\v {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\v';
}

<STRING>\\0 {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\0';
}

<STRING>\\\\ {
				logoutput = logoutput + yytext;
				tokenoutput = tokenoutput + '\\';
}

<STRING>\\\n 	{
				logoutput = logoutput + yytext ;
				line_count++;
}

<STRING>\n {
	fprintf(logout,"Error at line no %d: Unfinished string %s \n",lineString,logoutput.c_str());
	error_count++;
	line_count++;
	logoutput = "";
	BEGIN INITIAL;
}

"//" {
				BEGIN SINGLECMNT;
				lineSingle = line_count ;
				logoutputSingleCmnt = logoutputSingleCmnt + yytext;
}
<SINGLECMNT>[^\n] {
				logoutputSingleCmnt = logoutputSingleCmnt + yytext ;
}

<SINGLECMNT>\n {
	BEGIN INITIAL;
	line_count++;
	fprintf(logout,"Line no %d: TOKEN <Comment> Lexeme %s found\n",lineSingle,logoutputSingleCmnt.c_str());
	logoutputSingleCmnt = "";			
}

<SINGLECMNT>\\\n {
				logoutputSingleCmnt = logoutputSingleCmnt + yytext ;
				line_count++;
}

"/*" {
				BEGIN MULTICMNT;
				lineMult = line_count;
				logoutputMultiCmnt = logoutputMultiCmnt + yytext ;
}

<MULTICMNT>([^*\n])|. {
	logoutputMultiCmnt = logoutputMultiCmnt + yytext ;
}
<MULTICMNT>\n {
	logoutputMultiCmnt = logoutputMultiCmnt + '\n' ;
	line_count++;
}

<MULTICMNT>"*/" {
	BEGIN INITIAL;
	logoutputMultiCmnt = logoutputMultiCmnt + yytext ;
	fprintf(logout,"Line no %d: TOKEN <Comment> Lexeme %s found\n",lineMult,logoutputMultiCmnt.c_str());
	logoutputMultiCmnt = "";
}
<MULTICMNT><<EOF>> {
	fprintf(logout,"Error at line no %d: Unterminated comment %s \n",lineMult,logoutputMultiCmnt.c_str());
	error_count++;
	BEGIN INITIAL;
	logoutputMultiCmnt = "";
}


{DIGIT}*[\.]({DIGIT}+[\.])+{DIGIT}* {
	fprintf(logout,"Error at line no %d: Too many decimal point %s \n",line_count,yytext);
	error_count++;
}

{DIGIT}*([\.])*{DIGIT}+(E(-)?{DIGIT}+)([\.])+{DIGIT}* {
	fprintf(logout,"Error at line no %d: Ill formed number %s \n",line_count,yytext);
	error_count++;
}

{DIGIT}+[a-zA-Z]+{DIGIT}* {
	fprintf(logout,"Error at line no %d: Invalid prefix on ID or invalid suffix on Number %s \n",line_count,yytext);
	error_count++;
}

'..+' {
	fprintf(logout,"Error at line no %d: Multi character constant error %s \n",line_count,yytext);
	error_count++;
}

'. |
' |
'\\[ntafrbv0\\] |
'\\' {
	fprintf(logout,"Error at line no %d: Unterminated character %s \n",line_count,yytext);
	error_count++;
}

'\[^ntafrbv0\\\n]' {
	fprintf(logout,"Error at line no %d: Unrecognized character %s \n",line_count,yytext);
	error_count++;
}

<<EOF>> {
	fprintf(logout,"\n");
	fprintf(logout,"Total Line Number: %d and error number: %d\n",line_count-1,error_count); return 0;
}
%%

int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	
	logout= fopen("1605081_log.txt","w");
	tokenout= fopen("1605081_token.txt","w");

	yyin= fin;
	yylex();
	fclose(yyin);
	fclose(tokenout);
	fclose(logout);
	return 0;
}

