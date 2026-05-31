module Main where

import System.Environment
import qualified Data.Map as Map

import Parser
import Frequency
import Similarity

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

            mapM_ print
                (Map.toList freq1)

            putStrLn ""

            print (similarity freq1 freq2)

        _ ->
            putStrLn
            "Uso: ./program res.txt sep.txt code1.c code2.c"