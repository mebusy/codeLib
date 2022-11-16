
ws			[ \t]+
comment 	#.*
qstring 	\"[^\"\n]*[\"\n]
id		[a-zA-Z][a-zA-Z0-9]*
nl		\n

%%

{ws}		;
{comment}	;
{qstring}	{ yylval.string = strdup(yytext+1);  /* skip open quote */
			  if (yylval.string[yylen-2] != '"' )
				warning( "unterminated character string " , (char*)0 );
			  else
				yylval.string[yylen-2] = '' ;  /* remove close quote */
			  return QSTRING ; 
			}

screen		{return SCREEN;}
title 		{return TITLE;}
item		{return ITEM;}
command		{return COMMAND;}
action		{return ACTION;}
excute		{return EXECUTE;}
menu		{return MENU;}
quit		{return QUIT;}
ignore		{return IGNORE;}
attribute	{return ATTRIBUTE;}
visible		{return VISIBLE;}
invisible	{return INVISIBLE;}
end			{return END;}

{id}		{ yylval.string = strdup(yytext);
			  return ID ; 
			}

{nl}		{lineno++;}
.			{return yytext[0];}

