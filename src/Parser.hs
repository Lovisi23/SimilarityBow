module Parser (
    processCode
) where

import Utils.String

processCode :: [Char] -> String -> [String]
processCode seps code =
    tokenize (sanitize seps code)