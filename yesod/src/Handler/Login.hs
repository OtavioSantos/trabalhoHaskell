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
    msg <- getMessage
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
        
postLoginR :: Handler Html 
postLoginR = do 
    ((res,_),_) <- runFormPost formLogin
    case res of 
        FormSuccess (apelido,senha) -> do
            logado <- runDB $ selectFirst [UsuarioApelido ==. apelido,
                                          UsuarioSenha ==. senha] []
            case logado of
                Just (Entity usrid usuario) -> do 
                    setSession "_USR" (pack $ show usuario)
                    redirect HomeR
                Nothing -> do
                    setMessage [shamlet|
                        Usuario não encontrado!
                    |]
                    redirect LoginR
        _ -> redirect LoginR
        
postLogoutR :: Handler Html
postLogoutR = do 
    deleteSession "_USR"
    redirect HomeR