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
    Log  "Here"

Get And Save New Session
    # &{res}=  Http  https://api-staging.setel.com/api/loyalty-members/health  GET
    # Log  res.body: ${res.body}
    &{res}=  Http  ${AUTH_LOGIN_URI}  POST  {"namespace": "setel-admins", "email": "looiyih.foo@setel.com", "password": "GoLickD33zn**s"}
    Log  Body received: ${res.body}
    Should Be Equal  ${res.status}  ${{201}}
    # SessionStorage Set Item  key=access-token  value=${res.body.accessToken}
    # SessionStorage Set Item  SESSION  ${{Methods.convert_dictionary_to_json_string({"accessToken": ${res.body.accessToken}, "namespace": "setel-merchants", "refreshToken": ${res.body.refreshToken}, "expiresAt": ${res.body.expiresIn}, "permissions": getattr(${res.body}, "permissions", None) || None, "email": ${res.body.email}, "username": ""})}}
    # SessionStorage Set Item  SESSION  ${{ Methods.convert_dictionary_to_json_string({"accessToken": ${res.body}.json().accessToken, "namespace": "setel-merchants", "refreshToken": ${res.body.refreshToken}, "expiresAt": ${res.body.expiresIn}, "permissions": getattr(${res.body}, "permissions", None) || None, "email": ${res.body.email}, "username": "" })}}
    # Log  Joined body for SESSION store: ${{res.body.update({"namespace": "setel-merchants", "username": ""})}}
    # SessionStorage Set Item  SESSION  ${{ res.body.update({"namespace": "setel-merchants", "username": ""}) }}
    SessionStorage Set Item  SESSION  ${res.body}

    &{res}=  Http  ${AUTH_LOGIN_URI}  POST  {"namespace": "setel-admins", "email": "looiyih.foo@setel.com", "password": "GoLickD33zn**s"}
    SessionStorage Set Item  SESSION  ${res.body}
    # SessionStorage Set Item  key=SESSION  value=${{ Methods.convert_dictionary_to_json_string({}) }}

Open Home Page
    # Wait For Navigation  url=${{f'${get_uri_for_web_admin()}/landing-dashboard'}}  timeout=30 seconds  wait_until=networkidle
    # Close Page
    Reload
    Wait For Navigation  url=${{f'${get_uri_for_web_admin()}/landing-dashboard'}}  timeout=30 seconds  wait_until=networkidle
    # New Page  url=${{f'${get_uri_for_web_admin()}/landing-dashboard'}}  wait_until=domcontentloaded

# Set Dashboard Token
#     DashboardStorage dashboardStorage = new DashboardStorage(loginResponse, setelMerchants);
#     setDashBoardToken(dashboardStorage);
#     openAnyUrl(Url.DASHBOARD + LANDING_URI);
#     waitForPageLoaded();
#     return new MerchantsPage();

# Input Username
#     Input Text  ${LoginUsernameInputBox}  ${Username}

# Input Password
#     Input Text  ${LoginPasswordInputBox}  ${Password}

# Click Login
#     Click Element  ${LoginButton}