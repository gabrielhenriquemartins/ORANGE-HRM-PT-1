*** Settings ***
Resource   ../Resources/10 - maintenance/kw_maintenance.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Maintenance

*** Test Cases ***
Maintenance - Candidate Records
    Log To Console    Jira Issue: OTS-XXX  
    Candidate Records    Software Engineer