import re


fp = open( "/Volumes/WORK/WORK/mebusy_git_notes/dev_notes/ansic_lex_yacc/ansic.y" )
lines = fp.readlines()
fp.close()



list_nonterminal = []
out = ""

bGrammarStart = False ;
bGrammarEnd = False 
for line in lines:
	
	l = line.strip()
	if l.startswith ( "%token" ):
		out += line  
		out += line.replace( "%token", "%type <text>" )  
		continue

	if l == "%%":
		if not bGrammarStart:
			bGrammarStart = True
		else:
			bGrammarEnd = True

		out += line  
		continue

	 
	if bGrammarEnd:
		out += line  
		continue

	if bGrammarStart:
		if l == "":
			out += line  
			continue 

		words = l.split();

		if len(words) == 1:
			if words[0] == ';' :
				out += line  
				continue
			else:
				list_nonterminal.append( words[0] )
				out += line  
				continue

		out += line.rstrip() + "\t\t"

		action = "{ stringncatAndAssignment ( &$$ , "
		for x in xrange( 1, len(words) , 1 ):
			item = words[x] 
			if len(item) >= 3 and item[0] == '\'' and item[ -1]  == '\'':
				action += "\"%s\", " %   item[1: -1] 
			else:
				action += "$%d, " % x 

		out += action + " 0 );   }  \n"
		continue

	#default
	out += line 
	pass

type_nonterminal = "%type <text> "
for nonterminal in list_nonterminal:
	type_nonterminal +=  " " + nonterminal

out = out.replace( r"%start translation_unit" ,   "\n" + type_nonterminal + "\n\n\n" + r"%start translation_unit"  );

fp = open( "ansic-pre.y" , "w" )
fp.write(out)
fp.close()

print 'done'

