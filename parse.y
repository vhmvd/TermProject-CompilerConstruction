%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
void yyerror(const char *s);

struct Node {
    struct Node* child;
    struct Node* sibling;
    char str[150];
};
struct Node* makeNode(char* s);
void printTree(struct Node* root,int level);
%}

%start program

%union{
  struct Node* node;
}

%token <node> CREATE
%token <node> DELETE
%token <node> DROP
%token <node> DATABASE
%token <node> TABLE
%token <node> SELECT
%token <node> INSERT_INTO
%token <node> UPDATE
%token <node> SET
%token <node> FROM
%token <node> WHERE
%token <node> AS
%token <node> ALL
%token <node> ANY
%token <node> DATATYPE
%token <node> NUMBER
%token <node> STRING
%token <node> IDENTIFIER
%token <node> SELECTALL
%token <node> COMMA
%token <node> SUM
%token <node> EXISTS
%token <node> MINIMUM
%token <node> MAXIMUM
%token <node> VALUES
%token <node> RELATIONAL_OPERATOR
%token <node> OR
%token <node> AND
%token <node> EQUALITY_OPERATOR
%token <node> NOT
%token <node> '(' ')'

%type <node> program database_stmt create_db drop_db table_stmt create_table declare_col drop_table insert_table valuelist query_stmt from_stmt origintable rename select_col selectways aggfunc aggfunctypes diffcolumns where_stmt conditions relational_stmt query_bracket value logical_op rel_oper delete_stmt update_stmt intializelist

%%

program 	: database_stmt ';' 	{ 	
            $$ = makeNode("program");
            $$->child = $1;
            printf("\n\n<Parsing tree>\n");
            printTree($$,0);
            printf("INPUT ACCEPTED\n\n");
            exit(0);
          }
    | table_stmt ';'	{ 
            $$ = makeNode("program");
            $$->child = $1;
            printf("\n\n<Parsing tree>\n");
            printTree($$,0);
            printf("INPUT ACCEPTED\n\n");
            exit(0);
          };

database_stmt	: create_db 		{ $$ = makeNode("database_stmt"); $$->child = $1; }
    | drop_db		{ $$ = makeNode("database_stmt"); $$->child = $1; };

create_db	: CREATE DATABASE IDENTIFIER 	{	
              $$ = makeNode("create_db");
              $1 = makeNode("CREATE");
              $2 = makeNode("DATABASE");
              $3 = makeNode("IDENTIFIER");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
            };

drop_db		: DROP DATABASE IDENTIFIER   	{	
              $$ = makeNode("drop_db");
              $1 = makeNode("DROP");
              $2 = makeNode("DATABASE");
              $3 = makeNode("IDENTIFIER");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
            };

table_stmt	: create_table 			{ $$ = makeNode("table_stmt"); $$->child = $1;}
    | drop_table			{ $$ = makeNode("table_stmt"); $$->child = $1;}
    | insert_table			{ $$ = makeNode("table_stmt"); $$->child = $1;}
    | query_stmt 			{ $$ = makeNode("table_stmt"); $$->child = $1;}
    | delete_stmt			{ $$ = makeNode("table_stmt"); $$->child = $1;}
    | update_stmt			{ $$ = makeNode("table_stmt"); $$->child = $1;};

create_table	: CREATE TABLE IDENTIFIER '(' declare_col ')' 	{
                  $$ = makeNode("create_table");
                  $1 = makeNode("CREATE");
                  $2 = makeNode("TABLE");
                  $3 = makeNode("IDENTIFIER");
                  $4 = makeNode("(");
                  $6 = makeNode(")");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                  $5->sibling=$6;
                }
    | CREATE TABLE IDENTIFIER AS query_stmt		{
                  $$ = makeNode("create_table");
                  $1 = makeNode("CREATE");
                  $2 = makeNode("TABLE");
                  $3 = makeNode("IDENTIFIER");
                  $4 = makeNode("AS");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                };

declare_col	: IDENTIFIER DATATYPE COMMA declare_col 	{
                  $$ = makeNode("declare_col");
                  $1 = makeNode("IDENTIFIER");
                  $2 = makeNode("DATATYPE");
                  $3 = makeNode("COMMA");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                }
    | IDENTIFIER DATATYPE				{
                  $$ = makeNode("declare_col");
                  $1 = makeNode("IDENTIFIER");
                  $2 = makeNode("DATATYPE");
                  $$->child = $1; 
                  $1->sibling=$2;
                };

drop_table	: DROP TABLE IDENTIFIER				{
                  $$ = makeNode("drop_table");
                  $1 = makeNode("DROP");
                  $2 = makeNode("TABLE");
                  $3 = makeNode("IDENTIFIER");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                };


insert_table	: INSERT_INTO IDENTIFIER VALUES '(' valuelist ')'{
                  $$ = makeNode("insert_table");
                  $1 = makeNode("INSERT_INTO");
                  $2 = makeNode("IDENTIFIER");
                  $3 = makeNode("VALUES");
                  $4 = makeNode("(");
                  $6 = makeNode(")");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                  $5->sibling=$6;
                }
    | INSERT_INTO IDENTIFIER '(' origintable ')' VALUES '(' valuelist ')' 	{
                  $$ = makeNode("insert_table");
                  $1 = makeNode("INSERT_INTO");
                  $2 = makeNode("IDENTIFIER");
                  $3 = makeNode("(");
                  $5 = makeNode(")");
                  $6 = makeNode("VALUES");
                  $7 = makeNode("(");
                  $9 = makeNode(")");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                  $5->sibling=$6;
                  $6->sibling=$7;
                  $7->sibling=$8;
                  $8->sibling=$9;
                      }
    | INSERT_INTO IDENTIFIER '(' origintable ')' query_stmt	{
                  $$ = makeNode("insert_table");
                  $1 = makeNode("INSERT_INTO");
                  $2 = makeNode("IDENTIFIER");
                  $3 = makeNode("(");
                  $5 = makeNode(")");
                  $$->child = $1; 
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                  $5->sibling=$6;
                  }
    | INSERT_INTO IDENTIFIER query_stmt			{
                    $$ = makeNode("insert_table");
                    $1 = makeNode("INSERT_INTO");
                    $2 = makeNode("IDENTIFIER");
                    $$->child = $1; 
                    $1->sibling=$2;
                    $2->sibling=$3;
                  };
    
valuelist	: value COMMA valuelist					{
                    $$ = makeNode("valuelist");
                    $2 = makeNode("COMMA");
                    $$->child = $1; 
                    $1->sibling=$2;
                    $2->sibling=$3;
                  }
    | value					{ $$ = makeNode("valuelist"); $$->child = $1;};
    
query_stmt	: SELECT select_col from_stmt where_stmt
              {
                $$ = makeNode("query_stmt");
                $1 = makeNode("SELECT");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;
                $3->sibling=$4;
              };


from_stmt	: FROM origintable		{	
              $$ = makeNode("from_stmt");
              $1 = makeNode("FROM");
              $$->child = $1; 
              $1->sibling=$2;
            }
    | FROM '(' query_stmt ')'	{
              $$ = makeNode("from_stmt");
              $1 = makeNode("FROM");
              $2 = makeNode("(");
              $4 = makeNode(")");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
              $3->sibling=$4;
            };

origintable	: IDENTIFIER rename		{
              $$ = makeNode("origintable");
              $1 = makeNode("IDENTIFIER");
              $$->child = $1; 
              $1->sibling=$2;
            }
    | IDENTIFIER rename COMMA origintable	{
                $$ = makeNode("origintable");
                $1 = makeNode("IDENTIFIER");
                $3 = makeNode("COMMA");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;
                $3->sibling=$4;
              };

rename		: AS IDENTIFIER 		{
              $$ = makeNode("rename");
              $1 = makeNode("AS");
              $2 = makeNode("IDENTIFIER");
              $$->child = $1;
              $1->sibling=$2; 
            }
    | 				{$$ = makeNode("rename");};

select_col	: selectways rename COMMA select_col 		{
                $$ = makeNode("select_col");
                $3 = makeNode("COMMA");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;
                $3->sibling=$4;
              }
    | selectways rename			{ $$ = makeNode("select_col");$$->child = $1;$1->sibling = $2;};
              
selectways	: diffcolumns 			{ $$ = makeNode("selectways");$$->child = $1;	}
    | aggfunc			{ $$ = makeNode("selectways");$$->child = $1;	};
    
aggfunc		: aggfunctypes '(' IDENTIFIER ')' 	{
              $$ = makeNode("aggfunc");
              $2 = makeNode("(");
              $3 = makeNode("IDENTIFIER");
              $4 = makeNode(")");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
              $3->sibling=$4;
              };

aggfunctypes	: SUM 			{ $$ = makeNode("aggfunctypes");$1 = makeNode("SUM");$$->child = $1;}
    | MINIMUM 		{ $$ = makeNode("aggfunctypes");$1 = makeNode("MINIMUM");$$->child = $1;}
    | MAXIMUM		{ $$ = makeNode("aggfunctypes");$1 = makeNode("MAXIMUM");$$->child = $1;};
              


diffcolumns	: SELECTALL 		{ $$ = makeNode("diffcolumns");$1 = makeNode("SELECTALL");$$->child = $1;}
    | IDENTIFIER 		{ $$ = makeNode("diffcolumns");$1 = makeNode("IDENTIFIER");$$->child = $1;};
  
where_stmt	: WHERE conditions 		{
              $$ = makeNode("where_stmt");
              $1 = makeNode("WHERE");
              $$->child = $1;	
              $1->child = $2;
            }
    | 			{	$$ = makeNode("where_stmt");	};

conditions	: relational_stmt logical_op conditions 	{
              $$ = makeNode("conditions");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
              }
    | NOT relational_stmt logical_op conditions	{
              $$ = makeNode("conditions");
              $1 = makeNode("NOT");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
              $3->sibling=$4;
              }
    | NOT relational_stmt			{
              $$ = makeNode("conditions");
              $1 = makeNode("NOT");
              $$->child = $1; 
              $1->sibling=$2;
              }
    | relational_stmt		{$$ = makeNode("conditions");$$->child = $1; };
              
relational_stmt	: IDENTIFIER rel_oper value 		{
              $$ = makeNode("relational_stmt");
              $1 = makeNode("IDENTIFIER");
              $$->child = $1; 
              $1->sibling=$2;
              $2->sibling=$3;
              }
    | IDENTIFIER EQUALITY_OPERATOR IDENTIFIER 	{
                  $$ = makeNode("relational_stmt");
                $1 = makeNode("IDENTIFIER");
                $2 = makeNode("EQUALITY_OPERATOR");
                $3 = makeNode("IDENTIFIER");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;
                }
    | IDENTIFIER rel_oper ANY query_bracket		{
                  $$ = makeNode("relational_stmt");
                $1 = makeNode("IDENTIFIER");
                $3 = makeNode("ANY");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;$3->sibling=$4;
                }
    | IDENTIFIER rel_oper ALL query_bracket		{
                  $$ = makeNode("relational_stmt");
                $1 = makeNode("IDENTIFIER");
                $3 = makeNode("ALL");
                $$->child = $1; 
                $1->sibling=$2;
                $2->sibling=$3;$3->sibling=$4;
                }
    | EXISTS query_bracket 				{
                  $$ = makeNode("relational_stmt");
                $1 = makeNode("EXISTS");$$->child = $1; 
                $1->sibling=$2;
                };

query_bracket	: '(' query_stmt ')'	{
            $$ = makeNode("query_bracket");
            $1 = makeNode("(");
            $3 = makeNode(")");
            $$->child = $1; 
            $1->sibling=$2;
            $2->sibling=$3;
          };


value		: NUMBER 		{ $$ = makeNode("value");$1 = makeNode("NUMBER");$$->child = $1;}
    | STRING		{ $$ = makeNode("value");$1 = makeNode("STRING");$$->child = $1;};


logical_op	: AND 			{ $$ = makeNode("logical_op");$1 = makeNode("AND");$$->child = $1; }
    | OR			{ $$ = makeNode("logical_op");$1 = makeNode("OR");$$->child = $1; };
    
rel_oper	: RELATIONAL_OPERATOR		{ 	$$ = makeNode("rel_oper");
              $1 = makeNode("RELATIONAL_OPERATOR");
              $$->child = $1;	}
    | EQUALITY_OPERATOR		{ 	$$ = makeNode("rel_oper");
              $1 = makeNode("EQUALITY_OPERATOR");
              $$->child = $1;	};


delete_stmt	: DELETE from_stmt where_stmt	{	$$ = makeNode("delete_stmt");
              $1 = makeNode("DELETE");
              $$->child = $1;	
              $1->sibling=$2;
              $2->sibling=$3;
            };

update_stmt	: UPDATE IDENTIFIER SET intializelist where_stmt	{ $$ = makeNode("update_stmt");
                  $1 = makeNode("UPDATE");
                  $2 = makeNode("IDENTIFIER");
                  $3 = makeNode("SET");
                  $$->child = $1;	
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                  };

intializelist	: IDENTIFIER EQUALITY_OPERATOR value COMMA intializelist	{$$ = makeNode("intializelist");
                  $1 = makeNode("IDENTIFIER");
                  $2 = makeNode("EQUALITY_OPERATOR");
                  $4 = makeNode("COMMA");
                  $$->child = $1;	
                  $1->sibling=$2;
                  $2->sibling=$3;
                  $3->sibling=$4;
                  $4->sibling=$5;
                    }
    | IDENTIFIER EQUALITY_OPERATOR value		{
                  $$ = makeNode("intializelist");
                  $1 = makeNode("IDENTIFIER");
                  $2 = makeNode("EQUALITY_OPERATOR");
                  $$->child = $1;	
                  $1->sibling=$2;
                  $2->sibling=$3;
                };

%%
#include"lex.yy.c"

struct Node* makeNode(char* s) {
  struct Node *node = malloc(sizeof(struct Node));
  node->child = NULL;
  node->sibling = NULL;
  strcpy(node->str,s);
  return node;
}

int yywrap()
{
  return 1;
}

void yyerror (char const *s) {
  fprintf (stderr, "%s\n", s);
}

void printTree(struct Node* root,int level)
{
  if(root==NULL)
    return;
  if(root->child==NULL && root->str[0] >= 97 && root->str[0]<=122)
    return;
  for(int i=0;i<level;i++)
    printf("    ");
  if( root->str[0] >= 65 && root->str[0]<=90)
  {
    printf("-%s\n",root->str);
  }
  else
  {
    printf("-%s\n",root->str);
  }
  if(root->child!=NULL)
  {
    root = root->child;
    while(root!=NULL)
    {
      printTree(root,level+1);
      root = root->sibling;
    }
  }
}

int main() 
{
  yyin = fopen("infile","r");
  yyparse();
  return 1;
}
