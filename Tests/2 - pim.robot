*** Settings ***
Resource   ../Resources/2 - pim/kw_pim.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   PIM

*** Test Cases ***
Pim - Add Employee
    Log To Console  Jira Issue: OTS-XXX 
    ${id}     Add Employee     first_name=Aroldo    middle_name=Henrique    last_name=Martins
    Set Global Variable    ${id}    ${id}
    Check Toast Message    Successfully Saved

Pim - Delete Employee
    Log To Console  Jira Issue: OTS-XXX 
    Delete Employee    id=${id}
    Check Toast Message    Successfully Deleted

Pim - Add Termination Reason
    Log To Console  Jira Issue: OTS-XXX 
    Add Termination Reason    reason=Vacation
    Check Toast Message    Successfully Saved

Pim - Delete Termination Reason
    Log To Console  Jira Issue: OTS-XXX 
    Delete Termination Reason   reason=Vacation
    Check Toast Message    Successfully Deleted

Pim - Add Reporting Method
    Log To Console  Jira Issue: OTS-XXX 
    Add Reporting Method   method=One-o-One
    Check Toast Message    Successfully Saved

Pim - Delete Reporting Method
    Log To Console  Jira Issue: OTS-XXX 
    Delete Reporting Method   method=One-o-One
    Check Toast Message    Successfully Deleted