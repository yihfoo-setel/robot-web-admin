*** Comments ***
# Port of LoginOpsPage.class


*** Settings ***
Library                                                                                                                                                                                                                             Browser
Variables                                                                                                                                                                                                                           ./Locators.yaml
Variables                                                                                                                                                                                                                           ./Constants.py
Library                                                                                                                                                                                                                             ../../Shared/Methods.py
# Does not work: Blocked on err 401: Unauthorised
# But this works ok: curl -X GET 'https://api-staging.setel.com/docs/idp/swagger.json' -H 'Authorization: Basic YWRtaW46bWFlUGhlaXNoZWoxZ29v'
# Encoded base64 is 'admin:maePheishej1goo'
# Library    OpenApiDriver
# ...    source=https://api-staging.setel.com/docs/loyalty
# ...    username=admin
# ...    password=maePheishej1goo
Library                                                                                                                                                                                                                             OpenApiDriver
# Ref: https://forum.robotframework.org/t/how-to-use-auth-parameter-in-get/4977/2
# Does not work: Cannot resolve reference "https://admin:maePheishej1goo@api-staging.setel.com/docs/loyalty/swagger.json#/components/schemas
# Error from GET uri not returning schemas as expected. Returns '' instead. But api-loyalty and api-idp are on openapi v3 as required here: https://github.com/MarketSquare/robotframework-openapitools/blob/main/docs/driver.md
# Chk vs boilerplate nestjs app: Works as expected: http://admin:maePheishej1goo@localhost:3000/docs/swagger
...                                                                                                                                                                                                                                     source=https://admin:maePheishej1goo@api-staging.setel.com/docs/loyalty/swagger.json


*** Variables ***
${web_admin_uri}    ${{ Methods.get_base_uri_for_web_admin() }}


*** Keywords ***
Init
    New Browser    browser=chromium    headless=false
    New Context    viewport={'width': 1280, 'height': 768}
    # Must have a page open to proceed without crashing Robot
    New Page    url=${{f'${web_admin_uri}/login'}}

Login With Username and Password
    Log    "Login With Username and Password"
    Click    ${user_inputs.EmailInput}
    Type Text    ${user_inputs.EmailInput}    looiyih.foo@setel.com
    Click    ${user_inputs.PasswordInput}
    Type Text    ${user_inputs.PasswordInput}    GoLickD33zn**s
    Click    ${user_inputs.LoginBtn}
    Wait For Navigation
    ...    url=${{f'${web_admin_uri}/landing-dashboard'}}
    ...    timeout=30 seconds
    ...    wait_until=networkidle

Get And Save New Session
    Log    Target endpoint: ${{Methods.get_uri_by_api_and_endpoint("idp","login")}}
    &{res}=    Http
    ...    ${{ Methods.get_uri_by_api_and_endpoint("idp","login") }}
    ...    POST
    ...    {"namespace": "setel-admins", "email": "looiyih.foo@setel.com", "password": "GoLickD33zn**s"}
    Log    Body received: ${res.body}
    Should Be Equal    ${res.status}    ${{201}}
    SessionStorage Set Item    SESSION    ${res.body}

# Get And Save New Session With Swagger
#    &{res}=    health
#    Log    Body received: ${res.body}
#    Should Be Equal    ${res.status}    ${{201}}
#    SessionStorage Set Item    SESSION    ${res.body}

Validate Using Test Endpoint Keyword
    [Arguments]    ${endpoint}    ${method}    ${status_code}
    Test Endpoint
    ...    endpoint=${endpoint}    method=${method}    status_code=${status_code}
