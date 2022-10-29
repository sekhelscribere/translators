{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-#LANGUAGE QuasiQuotes #-}
module Handler.Parser where

import Import
import Handler.ModalParser
import Handler.AST
import Text.Parsec


data Wff = Wff {getFormula :: Text} deriving Show

wffForm :: Html -> MForm Handler (FormResult Wff, Widget)
wffForm = renderDivs $ Wff
    <$> areq textField "" Nothing


getParserR :: Handler Html
getParserR = do
     -- Generate the form to be displayed
    (widget, enctype) <- generateFormPost wffForm
    defaultLayout
         [whamlet|
             <p>
                Type your DEL formula
            <form method=post action=@{ParsedR} enctype=#{enctype}>
              ^{widget}
                <br>
                <button>Submit
                <br>
                <br>
                <ul>How to type a well-formed formula:
                <li> Use p1, p2, p3,... for propositional variables
                <li> Use &, v, ->, ~ for conjunction, disjuntion, implication and negation 
                <li> If i is an agent and &phi; is a formula, then use K i &phi; for modalised formula (don't forget whitespaces!). You can use any string for an agent's name: K Daniil p1^p2 will work
                <li>If &phi; and &psi; are wffs, then use [!&psi;]&phi; for a formula with  public anouncement modality (no whitespaces this time!)
                |]