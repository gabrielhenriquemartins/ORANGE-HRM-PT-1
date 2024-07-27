*** Settings ***
Resource   ../Resources/5 - recruitment/kw_recruitment.robot
Resource   ../Resources/0 - login/kw_login.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Recruitment

*** Test Cases ***
Recruitment - Add Candidate
    Log To Console   Jira Issue: OTS-XXX 
    Add Candidate    first_name=Gabriel    last_name=Martins    email=gabriel@hotmail.com
    Check Toast Message    Successfully Saved

Recruitment - Delete Candidate
    Log To Console   Jira Issue: OTS-XXX 
    Delete Candidate   first_name=Gabriel Martins
    Check Toast Message    Successfully Deleted