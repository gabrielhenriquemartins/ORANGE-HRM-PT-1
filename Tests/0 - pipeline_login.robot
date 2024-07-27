*** Settings ***
Resource   ../Resources/0 - login/kw_login.robot
Suite Setup      Wait Until Keyword Succeeds    5x    2s     Open Orange Home Page

*** Test Cases ***
Home - Check Invalid Credentials
    Log To Console  Jira Issue: OTS-XXX
    Invalid Login

Home - Check Required Username Message
    Log To Console  Jira Issue: OTS-XXX 
    Username Required

Home - Check Required Password Message
    Log To Console  Jira Issue: OTS-XXX 
    Password Required

Home - Check Required Username and Password Message
    Log To Console  Jira Issue: OTS-XXX 
    Username and Password Required

Home - Check Official Orange Home Page
    Log To Console  Jira Issue: OTS-XXX 
    Check Orange HRM link

Home - Check Forgot Password and Email Message Sent
    Log To Console  Jira Issue: OTS-XXX 
    Check Forgot Password

Home - Login as Admin
    Log To Console  Jira Issue: OTS-XXX 
    Login With the User Admin