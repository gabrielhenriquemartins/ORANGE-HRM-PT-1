*** Settings ***
Resource   ../Resources/8 - dashboard/kw_dashboard.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Dashboard

*** Test Cases ***
Dashboard - Check If the main seven dashboards exists
    Log To Console   Jira Issue: OTS-XXX 
    Check If Dashboard Time at Work exists
    Check If Dashboard My Actions exists
    Check If Dashboard Quick Launch exists
    Check If Dashboard Buzz Latest Posts exists
    Check If Dashboard Employees on Leave Today exists
    Check If Dashboard Employee Distribution by Sub Unit exists
    Check If Dashboard Employee Distribution by Location exists