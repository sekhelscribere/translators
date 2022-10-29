{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-#LANGUAGE QuasiQuotes #-}
module Handler.Parsed where

import Import
import Handler.ModalParser
import Handler.AST
import Handler.Parser
import Text.Parsec


postParsedR :: Handler Html
postParsedR = do
    ((result, widget), enctype) <- runFormPost wffForm
    case result of
        FormSuccess wff -> defaultLayout
            [whamlet|
                <p>#{showParsed $ parse parseFormula ""  $ unpack $ getFormula wff}
            |]
        _ -> defaultLayout
            [whamlet|
                <p>Invalid input, let's try again.
                <form method=post action=@{ParsedR} enctype=#{enctype}>
                    ^{widget}
                    <button> Submit
            |]