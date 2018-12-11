{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Login where

import Text.Lucius
import Text.Julius
import Import

formLogin :: Form (Text,Text)
formLogin = renderBootstrap $ (,) 
    <$> areq textField "Login: " Nothing
    <*> areq passwordField "Senha: " Nothing

getLoginR :: Handler Html
getLoginR = do 
    (widgetFormLogin, enctype) <- generateFormPost formLogin
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
        $(whamletFile "templates/views/acesso.hamlet")
        
postLogoutR :: Handler Html
postLogoutR = do 
    deleteSession "_USR"
    redirect HomeR