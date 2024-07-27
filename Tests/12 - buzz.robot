*** Settings ***
Resource   ../Resources/12 - buzz/kw_buzz.robot
Resource   ../Resources/Common/common.robot
Suite Setup      Open Left Menu    Buzz

    
*** Test Cases ***
Buzz - Post a Message
    Log To Console   Jira Issue: OTS-XXX 
    Write and Post    message=Hello There
    Check Toast Message    Successfully Saved

Buzz - Check Published Message
    Log To Console   Jira Issue: OTS-XXX  
    Check Published Message    message=Hello There

Buzz - Like a Message
    Log To Console   Jira Issue: OTS-XXX 
    React to the first Message with a Heart