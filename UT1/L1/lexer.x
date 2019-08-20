{
module Tokens where
}

--$num = ([0-9]+(\.[0-9]+)?[e,E][-+]?[0-9]+?)
$num = [0-9]

tokens :-

  [\t\n\r\f]+                   { \s -> TokenWSP} 
  $num                          { \s -> TokenNum (read s) }
  &&                            { \s -> TokenAnd }
  \|\|                          { \s -> TokenOr }
  ==                            { \s -> TokenEq }
  !=                            { \s -> TokenDiff }
  !                             { \s -> TokenNeg }
  \+                            { \s -> TokenPlus }
  \-                            { \s -> TokenMinus }
  \*                            { \s -> TokenStar }
  \(                            { \s -> TokenOParen }
  \)                            { \s -> TokenCParen }
  true                          { \s -> TokenTrue }
  false                         { \s -> TokenFalse }


{
-- The token type:
data Token = TokenWSP
           | TokenNum Num
           | TokenAnd 
           | TokenOr 
           | TokenEq
           | TokenDiff
           | TokenNeg
           | TokenPlus
           | TokenMinus
           | TokenStar
           | TokenOParen
           | TokenCParen
           | TokenTrue
           | TokenFalse
           deriving (Eq,Show)
           
scanTokens = alexScanTokens
}
