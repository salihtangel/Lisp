//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%{
    #include <stdio.h>
    #include <string.h>
    int yylex(void);
    void yyerror(char *);
    struct node {//struct for symbol table
        char* id;
        int val; 
    };
    struct list {//Struct for linked list of list values
        int val;
        struct list* next; 
    };
    struct node table[1024];//Symbol table
    int changeSymbol(char* id, int val);//Set function handler
    int getSymbol(char* id);//Gets symbol from table
    int createSymbol(char* id, int val);//Creates new symbol
    void printList(struct list* head);//Prints list in lisp manner
    int indexOf = 0;//Stores the last index of symbol table
    int flag = 0;//Flag for symbol errors
    int listFlag = 0;//Flag for current returned value is list
    int funcDecFlag = 0; //Flag for identifier handling of function decleration
%}

%union//Union for indicating yylval value
{
    int intValue;
    char *stringValue;
    struct list* liste;
}

%token <intValue>INTEGER
%token OP_OP
%token OP_CP
%token OP_PLUS
%token OP_MINUS
%token OP_DIV
%token OP_MULT
%token KW_DEFVAR
%token <stringValue>IDENTIFIER
%token KW_SET
%token BOOLEAN
%token KW_AND
%token KW_OR
%token KW_NOT
%token KW_EQUAL
%token OP_QUO
%token KW_NULL
%token KW_CONCAT
%token KW_APPEND
%token KW_DEFFUN
%token KW_IF
%token KW_WHILE
%token KW_FOR
%token KW_LIST
%token KW_LOAD
%token KW_DISP
%token KW_EXIT
%token OP_COMMA
%token OP_DBLMULT

%%
start:
        start input {
                        if(flag == 0 && listFlag == 0){//If is integer print integer if not print list. If flag 1 don't print anything
                            printf("SYNTAX OK!\n");
                            printf("Result: %d\n", $<intValue>2);
                        }else if(flag == 0 && listFlag == 1){
                            printf("SYNTAX OK!\n");
                            printf("Result: ");
                            printList($<liste>2);
                            listFlag = 0;
                        }else {
                            flag = 0;
                            }
                        
                    }
        | input {   
                    if(flag == 0 && listFlag == 0){
                            printf("SYNTAX OK!\n");
                                printf("Result: %d\n", $<intValue>1);
                    }else if(flag == 0 && listFlag == 1){
                        printf("SYNTAX OK!\n");
                        printf("Result: ");
                        printList($<liste>1);
                        listFlag = 0;
                    }else {
                        flag = 0;
                        }
                }
        |'\n'
     ;

input:
        expi '\n' {funcDecFlag = 0; $<intValue>$ = $<intValue>1;}//For '\n' version, in reading from file to not give error.
        |explisti '\n' {listFlag = 1; $<liste>$ = $<liste>1;}
        |expi { funcDecFlag = 0; $<intValue>$ = $<intValue>1;}
        |explisti {listFlag = 1; $<liste>$ = $<liste>1;}
        ;

expi:
        INTEGER
        | IDENTIFIER                                { if(funcDecFlag == 0 && getSymbol($<stringValue>1) == NULL){//If in symbol table return, if not flag that
                                                            yyerror("Not in symbol table");
                                                            flag = 1;
                                                        }else {
                                                            $<intValue>$ = getSymbol($<stringValue>1);
                                                        }
                                                    }
        | OP_OP OP_PLUS expi expi OP_CP            { $<intValue>$ = $<intValue>3 + $<intValue>4; }
        | OP_OP OP_MINUS expi expi OP_CP            { $<intValue>$ = $<intValue>3 - $<intValue>4; }
        | OP_OP OP_MULT expi expi OP_CP            { $<intValue>$ = $<intValue>3 * $<intValue>4; }
        | OP_OP OP_DIV expi expi OP_CP            { $<intValue>$ = $<intValue>3 / $<intValue>4; $<intValue>$ = (int)$<intValue>$; }
        | OP_OP KW_SET IDENTIFIER expi OP_CP        { if(changeSymbol($<stringValue>3, $<intValue>4) == NULL){ //LOOK AGAIN TABLE
                                                            yyerror("Not in symbol table");
                                                            flag = 1;
                                                        } else {
                                                            $<intValue>$ =  $<intValue>4;
                                                        }
                                                    }
        |OP_OP KW_DEFVAR IDENTIFIER expi OP_CP      {if(getSymbol($<stringValue>3) == NULL){//LOOK AGAIN TABLE
                                                            $<intValue>$ = createSymbol($<stringValue>3, $<intValue>4);
                                                        } else{
                                                            yyerror("Already in symbol table");
                                                            flag = 1;
                                                        }
                                                    }
	|OP_OP KW_DEFFUN IDENTIFIER OP_OP idlist OP_CP explisti OP_CP { 
									$<intValue>$ = 0;
									funcDecFlag = 1;
								      }
	|OP_OP IDENTIFIER explisti OP_CP	     { 
							$<intValue>$ = 0;
							funcDecFlag = 1;
						}
	|OP_OP KW_IF exbi explisti OP_CP	{
							listFlag = 1;//If is expi but it returns explist so we need to indicate that
							if($<intValue>3 == 1){
								$<liste>$ = $<liste>4;							
							}else {
								$<liste>$ = NULL;
							}						
						}
	|OP_OP KW_IF exbi explisti explisti OP_CP	{
							listFlag = 1;
							if($<intValue>3 == 1){
								$<liste>$ = $<liste>4;							
							}else {
								$<liste>$ = $<liste>5;
							}						
						}
	|OP_OP KW_WHILE exbi explisti OP_CP {
								$<intValue>$ = $<intValue>3;
							}
	|OP_OP KW_FOR OP_OP IDENTIFIER expi expi OP_CP explisti OP_CP {
									funcDecFlag = 1;
									$<intValue>$ = 0;
								      }
    |OP_OP KW_EXIT OP_CP    { exit(0); }//Exit interpreter			
    |error { yyerrok; yyclearin; yylex_destroy(); printf("SYNTAX_ERROR Expression not recognized!\n"); yyparse();}//If there is error, it's OK. Show that and continue parsing.
    ;

idlist:	IDENTIFIER idlist
	|IDENTIFIER
	;

exbi:
        BOOLEAN
        |OP_OP KW_AND exbi exbi OP_CP               {$<intValue>$ = $<intValue>3 && $<intValue>4;}//Done with 1's and 0's 
        |OP_OP KW_OR exbi exbi OP_CP               {$<intValue>$ = $<intValue>3 || $<intValue>4;}
        |OP_OP KW_NOT exbi OP_CP               {$<intValue>$ = !($<intValue>3);}
        |OP_OP KW_EQUAL expi expi OP_CP          {if($<intValue>3 == $<intValue>4){
                                                        $<intValue>$ = 1;
                                                    }else{
                                                            $<intValue>$ = 0;
                                                    }
                                                 }
        |OP_OP KW_EQUAL exbi exbi OP_CP          {if($<intValue>3 == $<intValue>4){
                                                        $<intValue>$ = 1;
                                                    }else{
                                                            $<intValue>$ = 0;
                                                    }
                                                 }
          ;

explisti:
        list                                        {$<liste>$ = $<liste>1;}
        |OP_OP KW_CONCAT explisti explisti OP_CP     {//Concatane lists with connecting their next values.
                                                        if($<liste>3 == NULL){
                                                            $<liste>$ = $<liste>4;
                                                        } else {
                                                            $<liste>$ = $<liste>3;
                                                            struct list* iter = $<liste>3;
                                                            while(iter->next != NULL)
                                                                iter = iter->next;
                                                            iter->next = $<liste>4;                                                      
                                                        }
                                                    }
        |OP_OP KW_APPEND expi explisti OP_CP     {
                                                        if($<liste>4 == NULL){//Go list until next value is nil and add as next value.
                                                            $<liste>$ = malloc(sizeof(struct list));
                                                            $<liste>$->next = NULL;
                                                            $<liste>$->val = $<intValue>3;
                                                        } else {
                                                            $<liste>$ = $<liste>4;
                                                            struct list* iter = $<liste>4;
                                                            while(iter->next != NULL)
                                                                iter = iter->next;
                                                            struct list* append = malloc(sizeof(struct list));
                                                            append->next = NULL;
                                                            append->val = $<intValue>3;
                                                            iter->next = append;                                                              
                                                        }
                                                    }
        |OP_OP KW_LIST values OP_CP              {
                                                    $<liste>$ = $<liste>3;
                                                }
        ;
list:
        OP_QUO OP_OP values OP_CP                   {
                                                       $<liste>$ = $<liste>3;
                                                    }
        |OP_QUO OP_OP OP_CP                         {
                                                       $<liste>$ = NULL;
                                                    }
        |KW_NULL                                    {
                                                       $<liste>$ = NULL;
                                                    }
        ;

values:
        INTEGER values                        {$<liste>$ = malloc(sizeof(struct list));//Constuct list
                                               $<liste>$->next = $<liste>2;
                                               $<liste>$->val = $<intValue>1;
                                              }
        |INTEGER                              {$<liste>$ = malloc(sizeof(struct list));
                                               $<liste>$->next = NULL;
                                               $<liste>$->val = $<intValue>1;
                                              }

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    char g[] = "g++";
    char buffer[50];
    char filename[40];
    FILE *file;
    printf("$");
    scanf("%[^\n]", buffer);//Read interpreter starter
    for(int j = 0; j < 3; j++)//Determine g++ started
            if(buffer[j] != g[j]){
                    printf("g++ lexer must be used\n");
                    return -1;
            }
    //Determine we have file or not
    if((buffer[3] == ' ') && (buffer[4] != '\0')){
            int i = 0;
            while(buffer[i+4] != '\0'){
                    filename[i] = buffer[i+4];
                    i++;
            }
            file = fopen(filename, "r");
            if(!file){
                    printf("File couldnt'be opened\n");
                    return -1;
            }
            //Check file is opened and if it is opened set as input
            yyset_in(file);
            yyparse();
            yylex_destroy();     //Destroy previous scanning
            fclose(file);
    }
    yyset_in(stdin);//Again make input as console
    yyparse();
    return 0; 
}

int createSymbol(char* id, int val){
    struct node newSym;
    newSym.id = malloc(sizeof(char)*strlen(id));
    strcpy(newSym.id, id);
    newSym.val = val;
    table[indexOf++] = newSym;
    return val;
}

int changeSymbol(char* id, int val){
    for(int i = 0; i < indexOf; i++){
        if(strcmp(table[i].id, id) == 0){
            table[i].val = val;
            return val;
        }
    }
    return NULL;
}
int getSymbol(char* id){
    for(int i = 0; i < indexOf; i++){
        if(strcmp(table[i].id, id) == 0){
            return table[i].val;
        }
    }
    return NULL;
}

void printList(struct list* head){
    struct list* iter = head;
    printf("(");
    while(iter != NULL){
        if(iter->next == NULL){
            printf("%d)\n", iter->val);
            return;
        }
        printf("%d ", iter->val);
        iter = iter->next;
    }
    printf(")\n");
    return;
}
