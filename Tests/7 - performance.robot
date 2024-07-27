*** Settings ***
Resource   ../Resources/7 - performance/kw_performance.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Performance

*** Test Cases ***
Performance - Add KPI
    Log To Console   Jira Issue: OTS-XXX 
    Add KPI       kpi=Active Defects    job_title=Account Assistant 
    Check Toast Message    Successfully Saved

Performance - Delete KPI
    Log To Console   Jira Issue: OTS-XXX 
    Delete KPI    kpi=Active Defects
    Check Toast Message    Successfully Deleted