
%{
%}

%%

[ \n\t]+
(C|c)(R|r)(E|e)(A|a)(T|t)(E|e)			    	{printf("%-20sCREATE\n",yytext); return CREATE; }
(D|d)(E|e)(L|l)(E|e)(T|t)(E|e)			    	{printf("%-20sDELETE\n",yytext); return DELETE; }
(D|d)(R|r)(O|o)(P|p)				            	{printf("%-20sDROP\n",yytext); return DROP; }
(D|d)(A|a)(T|t)(A|a)(B|b)(A|a)(S|s)(E|e)	{printf("%-20sDATABASE\n",yytext); return DATABASE; }
(S|s)(E|e)(L|l)(E|e)(C|c)(T|t)				    {printf("%-20sSELECT\n",yytext); return SELECT; }
"INSERT INTO"						                  {printf("%-20sINSERT_INTO\n",yytext); return INSERT_INTO; }
(U|u)(P|p)(D|d)(A|a)(T|t)(E|e)				    {printf("%-20sUPDATE\n",yytext); return UPDATE; }
(F|f)(R|r)(O|o)(M|m)					            {printf("%-20sFROM\n",yytext); return FROM; }
(W|w)(H|h)(E|e)(R|r)(E|e)			          	{printf("%-20sWHERE\n",yytext); return WHERE; }
(A|a)(L|l)(L|l)						                {printf("%-20sALL\n",yytext); return ALL; }
(S|s)(U|u)(M|m)					                	{printf("%-20sSUM\n",yytext); return SUM; }
(M|m)(I|i)(N|n)					                	{printf("%-20sMINIMUM\n",yytext); return MINIMUM; }
(M|m)(A|a)(X|x)				                		{printf("%-20sMAXIMUM\n",yytext); return MAXIMUM; }
(S|s)(E|e)(T|t)				                		{printf("%-20sSET\n",yytext); return SET; }
"="						                          	{printf("%-20sEQUALITY_OPERATOR\n",yytext); return EQUALITY_OPERATOR; }
("<"|">"|"<="|">="|"<>"|"!=")			      	{printf("%-20sRELATIONAL_OPERATOR\n",yytext); return RELATIONAL_OPERATOR; }
(A|a)(N|n)(D|d) 				                	{printf("%-20sAND\n",yytext); return AND; }
(O|o)(R|r) 				                    		{printf("%-20sOR\n",yytext); return OR; }
(N|n)(O|o)(T|t)						                {printf("%-20sNOT\n",yytext); return NOT; }
"("						                          	{printf("%-20s(\n",yytext); return '('; }
")"						                          	{printf("%-20s)\n",yytext); return ')'; }
";"						                          	{printf("%-20s;\n",yytext); return ';'; }
","							                          {printf("%-20sCOMMA\n",yytext); return COMMA; }
([a-zA-Z]+[0-9]*)		{printf("%-20sIDENTIFIER\n",yytext); return IDENTIFIER; }
\'(([^\']|\\\')*[^\\])?\'		    {printf("%-20sSTRING\n",yytext); return STRING; }
\"(([^\"]|\\\")*[^\\])?\"				{printf("%-20sSTRING\n",yytext); return STRING; }
[0-9]+				            			{printf("%-20sNUMBER\n",yytext); return NUMBER; }
"*"						                	{printf("%-20sSELECTALL\n",yytext); return SELECTALL; }
%%
