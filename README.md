# Compiler-LexicalAnalyzer

In this project I constructed a lexical analyzer. Lexical analysis is the process of scanning the source program as a sequence of characters and converting them into sequence 
of tokens. A program that performs this task is called a lexical analyzer or a lexer or a scanner. For example if a portion of source program contains int x=5; the scanner 
would convert in a sequence of tokens like <INT><ID,x><ASSIGNOP,=><COST_NUM,5> <SEMICOLON>. After successfully(!) completing the construction of a simple symbol table, I 
constructed a scanner for a subset of C language. The task is performed using a tool named flex (Fast Lexical Analyzer Generator) which is a popular tool for generating scanners.

The following tasks were completed:
  
  1.Identifying tokens:
    a.Keywords
    b.Constants
    c.Operators and Punctuators
    d.Identifiers
    e.Strings
    f.Comments
    g.White Space
    
  2.Line Count
  
  3.Detection of Lexical errors
  
