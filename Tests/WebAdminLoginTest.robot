*** Settings ***
Documentation  Page Object in Robot Framework
Library  Browser
Resource  ../Resources/PageObject/UserLoginPage/UserLoginPage.robot

*** Test Cases ***
Verify successful login to web-dashboard
    [documentation]  This test case verifies that the user is able to successfully Login to web-dashboard page
    [tags]  Trial
    Init
    Get New Session
        Log To Console  message=AUTH_LOGIN_URI: ${AUTH_LOGIN_URI}
    Open Home Page