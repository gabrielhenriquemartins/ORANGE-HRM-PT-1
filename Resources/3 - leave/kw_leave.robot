*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Create Leave Type
    [Documentation]    Test the behavior when adding a new Leave Type.
    ...    
    ...    Arguments: type
    ...
    ...    Example:
    ...    | Create Leave Type | type=Vacation |
    ...
    ...    Dependency: Must be on the leave page.
    ... 
    [Arguments]    ${type}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configure     Leave Types    leave/leaveTypeList 
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${type}
    Click    ${bt_submit}

Delete Leave Type
    [Documentation]    Test the behavior when deleting an existing Leave Type.
    ...    
    ...    Arguments: type
    ...
    ...    Example:
    ...    | Delete Leave Type | type=Vacation |
    ...
    ...    Dependency: Must be on the leave page.
    ... 
    [Arguments]    ${type}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configure     Leave Types    leave/leaveTypeList
    ${index}    Find Checkbox     ${type}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}