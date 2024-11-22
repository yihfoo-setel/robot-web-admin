*** Settings ***
Library    Browser
Variables  ./Locators.py
Variables  ./Constants.py
Variables  ../Shared/Uri.py
Library  ../Shared/Methods.py

# Port of LoginOpsPage.class
*** Keywords ***
Init
    New Browser    browser=chromium  headless=false
    New Context    viewport={'width': 1280, 'height': 768}
    # Must have a page open to proceed without crashing Robot
    New Page  url=${{f'${get_uri_for_web_admin()}/login'}}

Login With Username and Password
    Log  "Login With Username and Password"
    Click  ${EmailInput}
    Type Text  ${EmailInput}  looiyih.foo@setel.com
    Click  ${PasswordInput}
    Type Text  ${PasswordInput}  GoLickD33zn**s
    Click  ${LoginBtn}
    Wait For Navigation  url=${{f'${get_uri_for_web_admin()}/landing-dashboard'}}  timeout=30 seconds  wait_until=networkidle

Get And Save New Session
    &{res}=  Http  ${AUTH_LOGIN_URI}  POST  {"namespace": "setel-admins", "email": "looiyih.foo@setel.com", "password": "GoLickD33zn**s"}
    Log  Body received: ${res.body}
    Should Be Equal  ${res.status}  ${{201}}
    SessionStorage Set Item  SESSION  ${res.body}