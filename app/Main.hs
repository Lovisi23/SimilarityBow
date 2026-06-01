module Main where

import System.Environment
import qualified Data.Map as Map
import Data.List (sortBy)

import Parser
import Frequency
import Similarity

compareFreq :: (String, Int) -> (String, Int) -> Ordering
compareFreq (w1, f1) (w2, f2)
    | f1 /= f2  = compare f2 f1
    | otherwise = compare w1 w2

main :: IO ()
main = do
    args <- getArgs

    case args of
        [resFile, sepFile, c1File, c2File] -> do

            reserved <- lines <$> readFile resFile
            seps     <- concat <$> lines <$> readFile sepFile

            c1 <- readFile c1File
            c2 <- readFile c2File

            let tokens1 = processCode seps c1
            let tokens2 = processCode seps c2

            let freq1 = frequencies reserved tokens1
            let freq2 = frequencies reserved tokens2

            let sortedFreq =
                    sortBy compareFreq (Map.toList freq1)

            mapM_ print sortedFreq

            putStrLn ""

            print (similarity freq1 freq2)

        _ ->
            putStrLn
                "Uso: ./similarity.exe res.txt sep.txt c1.c c2.c"