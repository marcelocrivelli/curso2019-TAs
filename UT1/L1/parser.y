{
module Grammar where
import Tokens
}

%name parseCalc
%tokentype { Token }
%error { parseError }

%token
    num { TokenNum $$ }
    '&&' { TokenAnd }
    '||' { TokenOr }
    '==' { TokenEq }
    '!=' { TokenDiff }
    '!' { TokenNeg }
    '+' { TokenPlus }
    '-' { TokenMinus }
    '*' { TokenStar }
    '(' { TokenOParen }
    ')' { TokenCParen }
    true { TokenTrue }
    false { TokenFalse }


%left '==' '!='
%left '+' '-'
%left '*'


%left '&&' '||'
%left '!'

%%

start : AExp { Left $1 } | BExp { Right $1 } 


AExp: AExp '+' AExp            { Plus $1 $3 }
    | AExp '-' AExp            { Minus $1 $3 }
    | AExp '*' AExp            { Times $1 $3 }
    | num               	 { Int $1 }
    | '(' AExp ')'            { $2 }
    | AExp '==' AExp           { Eq $1 $3}
    | AExp '!=' AExp           { Diff $1 $3}

BExp: '!' BExp                	 { Negate $1}
    | BExp '&&' BExp			 { And $1 $3}
    | BExp '||' BExp			 { Or $1 $3}
    | true                       { Bool True}
    | false                       { Bool False}
    | '(' BExp ')'               { $2 }



{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data AExp = Plus AExp AExp
         | Minus AExp AExp
         | Times AExp AExp
         | Int Int
         | Eq AExp AExp
         | Diff AExp AExp
         deriving Show

data BExp = Negate BExp 
		 | And BExp BExp
		 | Or BExp BExp
		 | Bool Bool
		 deriving Show


}

