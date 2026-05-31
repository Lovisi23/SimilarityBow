module Similarity (
    similarity
) where

import qualified Data.Map as Map

similarity :: Map.Map String Int
           -> Map.Map String Int
           -> Double

similarity f1 f2 =
    let pairs = Map.toList f1

        m = sum
            [ fromIntegral v1
            | (word, v1) <- pairs
            , let v2 = Map.findWithDefault 0 word f2
            , closeEnough v1 v2
            ]

        total = fromIntegral (sum (Map.elems f1))

    in if total == 0
       then 0
       else m / total

closeEnough :: Int -> Int -> Bool
closeEnough f1 f2 =
    abs (fromIntegral (f1 - f2))
    <= 0.1 * fromIntegral f1