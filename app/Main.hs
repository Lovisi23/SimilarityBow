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
            
            putStrLn ""

            putStrLn "Frequências de palavras reservadas e tokens no código 1:"

            putStrLn ""

            mapM_ print sortedFreq

            putStrLn ""
            
            let m = similarity freq1 freq2
            
            let total = fromIntegral (sum (Map.elems freq1))
            
            let indice = if total == 0 then 0 else m / total

            putStrLn ("Valor de m: " ++ show m)
            putStrLn ("Indice de similaridade: " ++ show indice)

        _ -> do
            putStrLn ""
            putStrLn "Erro: Quantidade incorreta de argumentos fornecida."
            putStrLn "Por favor, forneca exatamente 4 arquivos de texto."
            putStrLn ""
