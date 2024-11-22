*** Settings ***
Documentation  Page Object in Robot Framework
Library  Browser
Resource  ../Resources/PageObject/UserLoginPage/UserLoginPage.robot

*** Test Cases ***
Successful login to web-dashboard
    [documentation]  This test case verifies that the user is able to successfully Login to web-dashboard page
    [tags]  Trial
    Init
    Login With Username and Password