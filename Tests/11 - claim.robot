*** Settings ***
Resource   ../Resources/11 - claim/kw_claim.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Claim

*** Test Cases ***
Claim - Create an Event
    Log to Console   Jira Issue: OTS-XXX 
    Create an Event    Event Test
    Check Toast Message    Successfully Saved

Claim - Create an Expense Type
    Log to Console   Jira Issue: OTS-XXX  
    Create an Expense Type    Expense Test
    Check Toast Message    Successfully Saved

Claim - Delete Expense Type
    Log to Console   Jira Issue: OTS-XXX 
    Delete Expense Type    Expense Test
    Check Toast Message    Successfully Deleted

Claim - Submit Claim
    Log to Console   Jira Issue: OTS-XXX  
    Wait Until Keyword Succeeds   3x   2s    Submit Claim   Event Test    Canadian Dollar
    Check Toast Message    Successfully Saved

Claim - Add Expenses
    Log To Console   Jira Issue: OTS-XXX 
    Add Expenses    Transport    20
    Check Toast Message    Successfully Saved
    Verify Added Expense    Transport

Claim - Add PDF File
    Log To Console   Jira Issue: OTS-XXX 
    Add PDF File
    Verify Pdf Uploaded    pdf_test.pdf
    Check Toast Message    Successfully Saved

Claim - Delete Event
    Log To Console   Jira Issue: OTS-XXX 
    Delete Event    Event Test
    Check Toast Message    Successfully Deleted