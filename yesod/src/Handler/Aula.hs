{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Aula where

import Network.HTTP.Types.Status
import Database.Persist.Postgresql

import Prelude (read)

import Import
import Text.Lucius
import Text.Julius
import Data.Int

-- formEnvAula :: UsuarioId -> Form Aula
-- formEnvAula usuarioid = renderBootstrap $ Aula
--     <$> areq textField "Titulo: " Nothing
--     <*> areq textField "Descricao: " Nothing
--     <*> areq textField "Tutorial: " Nothing
--     <*> areq fileField "img: " Nothing
--     <*> areq fileField "Video: " Nothing
--     <*> pure usuarioid
    
widgetNav :: Maybe Text -> Widget
widgetNav logado = $(whamletFile "templates/views/inset/nav.hamlet")

getAulaR :: AulaId -> Handler Html
getAulaR aulaid= do
        aula <- runDB $ get404 aulaid
        logado <- lookupSession "_USR"
        defaultLayout $ do 
                toWidgetHead [hamlet|
                    <script src=@{StaticR js_jquery_js}>
                    <script src=@{StaticR js_bootstrap_min_js}>
                    <script src=@{StaticR js_fontawesome_min_js}>
                    <script src=@{StaticR js_solid_min_js}>
                |]
                addStylesheet $ StaticR css_bootstrap_css
                addStylesheet $ StaticR css_style_css
                addStylesheet $ StaticR css_fontawesome_min_css
                addStylesheet $ StaticR css_solid_min_css
                $(whamletFile "templates/views/visualizarAula.hamlet")
                
-- getEnviarAulaR :: UsuarioId -> Handler Html
-- getEnviarAulaR userid = do
--         logado <- lookupSession "_USR"
--         (widgetFormEnvAula, enctype) <- generateFormPost (formEnvAula userid)
--         defaultLayout $ do 
--                 toWidgetHead [hamlet|
--                     <script src=@{StaticR js_jquery_js}>
--                     <script src=@{StaticR js_bootstrap_min_js}>
--                     <script src=@{StaticR js_fontawesome_min_js}>
--                     <script src=@{StaticR js_solid_min_js}>
--                 |]
--                 addStylesheet $ StaticR css_bootstrap_css
--                 addStylesheet $ StaticR css_style_css
--                 addStylesheet $ StaticR css_fontawesome_min_css
--                 addStylesheet $ StaticR css_solid_min_css
--                 $(whamletFile "templates/views/enviarAula.hamlet")
    
postDadosAulaR :: Handler TypedContent
postDadosAulaR = do 
    addHeader "Access-Control-Allow-Origin" "*"
    aula <- runDB $ selectList [] [Asc AulaId]
    sendStatusJSON ok200 (object ["resp" .= aula])