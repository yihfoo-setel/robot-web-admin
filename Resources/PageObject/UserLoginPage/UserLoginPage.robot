*** Settings ***
Library    Browser
Variables  ./Locators.yaml
Variables  ./Constants.py
Library  ../../Shared/Methods.py

*** Variables ***
# ${web_admin_uri}  ${{ Methods.get_base_uri_for_web_admin() }}
${web_admin_uri}  https://staging-admin.setel.my

# Port of LoginOpsPage.class
*** Keywords ***
Init
    New Browser    browser=chromium  headless=false
    New Context    viewport={'width': 1280, 'height': 768}
    # Must have a page open to proceed without crashing Robot
    New Page  url=${{f'${web_admin_uri}/login'}}

Login With Username and Password
    Log  "Login With Username and Password"
    Click  ${user_inputs.EmailInput}
    Type Text  ${user_inputs.EmailInput}  looiyih.foo@setel.com
    Click  ${user_inputs.PasswordInput}
    Type Text  ${user_inputs.PasswordInput}  GoLickD33zn**s
    Click  ${user_inputs.LoginBtn}
    Wait For Navigation  url=${{f'${web_admin_uri}/landing-dashboard'}}  timeout=30 seconds  wait_until=networkidle

Get And Save New Session
    Log  Target endpoint: ${{Methods.get_uri_by_api_and_endpoint("idp","login")}}
    &{res}=  Http  ${{ Methods.get_uri_by_api_and_endpoint("idp","login") }}  POST  {"namespace": "setel-admins", "email": "looiyih.foo@setel.com", "password": "GoLickD33zn**s"}
    Log  Body received: ${res.body}
    Should Be Equal  ${res.status}  ${{201}}
    SessionStorage Set Item  SESSION  ${res.body}