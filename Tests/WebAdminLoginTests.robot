*** Settings ***
Documentation       Page Object in Robot Framework

Library             Browser
Resource            ../Resources/PageObject/UserLoginPage/UserLoginPage.robot


*** Test Cases ***
Successful login to web-dashboard
    [Documentation]    This test case verifies that the user is able to successfully Login to web-dashboard page
    [Tags]    trial
    Init
    Login With Username and Password

Successful request web-admin access token
    Init
    Get And Save New Session

# Does not work: robotframework-openapitools not compatible with Setel Swagger docs
# Run Validate Using Test Endpoint Keyword
#    Validate Using Test Endpoint Keyword
#    ...    https://api-staging.setel.com/api/loyalty/admin/loyalty-members
#    ...    GET
#    ...    200
