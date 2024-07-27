*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add KPI
    [Documentation]    Test the behavior when adding a new KPI.
    ...
    ...    Arguments: kpi, job_title
    ...
    ...    Example:
    ...    | Add KPI | kpi=Bug Fixed | job_title=Software Tester |
    ...
    ...    Dependency: Must be on the performance page.
    ... 
    [Arguments]   ${kpi}    ${job_title}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configure    KPIs    performance/searchKpi
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${kpi}
    Click    ${dropdown}
    Click    //*[@class="oxd-select-option"]//*[contains(text(), '${job_title}')]
    Click    ${bt_submit}

Delete KPI
    [Documentation]    Test the behavior when deleting an existing KPI.
    ...
    ...    Arguments: kpi
    ...
    ...    Example:
    ...    | Delete KPI | kpi=Bug Fixed |
    ...
    ...    Dependency: Must be on the performance page.
    ... 
    [Arguments]   ${kpi}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configure    KPIs     performance/searchKpi
    ${index}    Find Checkbox     ${kpi}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+5}]${bin}
    Click    ${warning_alert}