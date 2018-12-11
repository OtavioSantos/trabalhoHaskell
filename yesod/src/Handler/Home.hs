{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Home where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

import Prelude (read)

import Import
import Text.Lucius
import Text.Julius

getHomeR :: Handler Html
getHomeR = defaultLayout $ do 
        toWidgetHead [hamlet|
                <script src=@{StaticR js_jquery_min_js}>
                <script src=@{StaticR js_script_js}>
        |]
        addStylesheet $ StaticR css_bootstrap_min_css
        addStylesheet $ StaticR css_geral_css
        $(whamletFile "templates/home.hamlet")
