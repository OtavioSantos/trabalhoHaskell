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

widgetNav :: Maybe Text -> Widget
widgetNav logado = $(whamletFile "templates/views/inset/nav.hamlet")

getHomeR :: Handler Html
getHomeR = do
        defaultLayout $ do 
                addStylesheet $ StaticR css_bootstrap_css
                addStylesheet $ StaticR css_style_css
                addStylesheet $ StaticR css_fontawesome_min_css
                addStylesheet $ StaticR css_solid_min_css
                $(whamletFile "templates/views/home.hamlet")