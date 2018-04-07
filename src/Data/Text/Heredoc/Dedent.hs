{-# LANGUAGE OverloadedStrings #-}

module Data.Text.Heredoc.Dedent
    ( dedent
    ) where

import Data.Semigroup ((<>))
import Data.Text (Text)
import qualified Data.Text as T

-- | Dedent lines, preserving relative indentation
dedent :: Text -> Text
dedent =
    dropNewlineEnd . T.unlines . reindentLinesTo 0 . T.lines . chompNewlines

reindentLinesTo :: Int -> [Text] -> [Text]
reindentLinesTo n ts = map
    ((<> newIndentation) . T.drop currentIndendationLevel)
    ts
  where
    newIndentation = T.replicate n " "
    currentIndendationLevel = minimumIndentationLevel ts

minimumIndentationLevel :: [Text] -> Int
minimumIndentationLevel [] = 0
minimumIndentationLevel ts =
    minimum . map indentationLevel $ filter (not . blank) ts

indentationLevel :: Text -> Int
indentationLevel = T.length . T.takeWhile (== ' ')

blank :: Text -> Bool
blank = T.null . T.strip

chompNewlines :: Text -> Text
chompNewlines = dropNewline . dropNewlineEnd

dropNewline :: Text -> Text
dropNewline t
    | "\n" `T.isPrefixOf` t = T.drop 1 t
    | otherwise = t

dropNewlineEnd :: Text -> Text
dropNewlineEnd t
    | "\n" `T.isSuffixOf` t = T.dropEnd 1 t
    | otherwise = t
