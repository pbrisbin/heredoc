{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Data.Text.Heredoc.DedentSpec
    ( spec
    ) where

import Data.Text.Heredoc
import Test.Hspec
import Text.Shakespeare.Text (st)

spec :: Spec
spec = do
    describe "dedent" $ do
        it "dedents text correctly" $ do
            dedent
                [st|

                    Some text that is naturally indented
                    Because it would be ugly...

                    To define it over at that left margin in the
                    QuasiQuote.

                |]

                `shouldBe` mconcat
                [ "\n"
                , "Some text that is naturally indented\n"
                , "Because it would be ugly...\n"
                , "\n"
                , "To define it over at that left margin in the\n"
                , "QuasiQuote.\n"
                , "\n"
                ]

        it "handles single-line quasi-quotes correctly" $ do
            dedent
                [st|This is just one line|]
                `shouldBe` mconcat
                [ "This is just one line"
                ]
