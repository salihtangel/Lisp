all:	compile

compile: 
	lex gpp_lexer.l
	yacc   gpp_parser.y -d
	gcc lex.yy.c  y.tab.c -w
	./a.out
clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h calc calc.dSYM

	yacc   gpp_parser.y -d
	gcc lex.yy.c  y.tab.c -w

	./a.out
