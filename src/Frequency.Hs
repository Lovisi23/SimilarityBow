module Frequency (
    frequencies
) where

import qualified Data.Map as Map

frequencies :: [String] -> [String] -> Map.Map String Int
frequencies reserved tokens =
    foldl update Map.empty tokens
  where
    update acc word =
        let weight =
                if word `elem` reserved
                    then 2
                    else 1
        in Map.insertWith (+) word weight acc