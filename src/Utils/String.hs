module Utils.String (
    sanitize,
    tokenize
) where

import Data.Char

sanitize :: [Char] -> String -> String
sanitize seps =
    map (\c -> if c `elem` seps then ' ' else c)

tokenize :: String -> [String]
tokenize = words