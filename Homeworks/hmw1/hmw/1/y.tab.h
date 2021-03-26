/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEGER = 258,
    OP_OP = 259,
    OP_CP = 260,
    OP_PLUS = 261,
    OP_MINUS = 262,
    OP_DIV = 263,
    OP_MULT = 264,
    KW_DEFVAR = 265,
    IDENTIFIER = 266,
    KW_SET = 267,
    BOOLEAN = 268,
    KW_AND = 269,
    KW_OR = 270,
    KW_NOT = 271,
    KW_EQUAL = 272,
    OP_QUO = 273,
    KW_NULL = 274,
    KW_CONCAT = 275,
    KW_APPEND = 276,
    KW_DEFFUN = 277,
    KW_IF = 278,
    KW_WHILE = 279,
    KW_FOR = 280,
    KW_LIST = 281,
    KW_LOAD = 282,
    KW_DISP = 283,
    KW_EXIT = 284,
    OP_COMMA = 285,
    OP_DBLMULT = 286
  };
#endif
/* Tokens.  */
#define INTEGER 258
#define OP_OP 259
#define OP_CP 260
#define OP_PLUS 261
#define OP_MINUS 262
#define OP_DIV 263
#define OP_MULT 264
#define KW_DEFVAR 265
#define IDENTIFIER 266
#define KW_SET 267
#define BOOLEAN 268
#define KW_AND 269
#define KW_OR 270
#define KW_NOT 271
#define KW_EQUAL 272
#define OP_QUO 273
#define KW_NULL 274
#define KW_CONCAT 275
#define KW_APPEND 276
#define KW_DEFFUN 277
#define KW_IF 278
#define KW_WHILE 279
#define KW_FOR 280
#define KW_LIST 281
#define KW_LOAD 282
#define KW_DISP 283
#define KW_EXIT 284
#define OP_COMMA 285
#define OP_DBLMULT 286

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 29 "gpp_parser.y"

    int intValue;
    char *stringValue;
    struct list* liste;

#line 125 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
