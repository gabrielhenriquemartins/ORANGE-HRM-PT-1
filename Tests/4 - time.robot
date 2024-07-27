*** Settings ***
Resource   ../Resources/4 - time/kw_time.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Time

*** Test Cases ***
Time - Add Punch in Punch Out
    Log To Console   Jira Issue: OTS-XXX 
    Add Punch in Punch Out

Time - Delete Punch in Punch Out
    Log To Console   Jira Issue: OTS-XXX 
    Delete Punch in Punch Out
    Check Toast Message    Successfully Deleted

Time - Add Costumer
    Log To Console   Jira Issue: OTS-XXX 
    Add Customer    customer=Amazon
    Check Toast Message    Successfully Saved

Time - Add Project and Activities
    Log To Console   Jira Issue: OTS-XXX 
    Add Project and Activities    project_name=Arquiteture    customer=Amazon    activity=Bug Fix
    Check Toast Message    Successfully Saved

Time - Add Row in My Timesheet
    Log To Console   Jira Issue: OTS-XXX 
    Add Row in My Timesheet    project=Arquiteture    activity=Bug Fix
    Check Toast Message    Successfully Saved

Time - Delete Costumer
    Log To Console   Jira Issue: OTS-XXX  
    Delete Customer    customer=Amazon
    Check Toast Message    Successfully Deleted