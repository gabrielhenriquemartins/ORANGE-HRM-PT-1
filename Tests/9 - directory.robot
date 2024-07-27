*** Settings ***
Resource   ../Resources/9 - directory/kw_directory.robot
Resource   ../Resources/Common/common.robot
Suite Setup      Open Left Menu    Directory
Suite Teardown   Close Browser

*** Test Cases ***
Directory - Find Profession Role
    Log To Console    Jira Issue: OTS-XXX 
    Find Profession Role    Automaton Tester

Directory - Find Location
    Log To Console    Jira Issue: OTS-XXX 
    Find Location    Texas R&D