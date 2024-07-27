*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add Employee
    [Documentation]    Test the behavior when adding a new Employee.
    ...    
    ...    Arguments: first_name, middle_name, last_name
    ...
    ...    Example:
    ...    | Add Employee | first_name=Armando | middle_name=Miguel  | last_name=Pascoal |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]   ${first_name}    ${middle_name}    ${last_name}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Add Employee     endpoint=pim/addEmployee
    ${random_id}     Generate Random String     length=8   chars=[NUMBERS]
    Fill Text    ${tf_first_name}     ${first_name}
    Fill Text    ${tf_middle_name}    ${middle_name}
    Fill Text    ${tf_last_name}      ${last_name}
    Fill Text    ${field_text}        ${random_id}
    Click    ${bt_submit}
    Get Element States      ${personal_details_title}
    Return From Keyword     ${random_id}

Delete Employee
    [Documentation]    Test the behavior when deleting an existing Employee.
    ...    
    ...    Arguments: id
    ...
    ...    Example:
    ...    | Delete Employee | id=4321 |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]   ${id}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Employee List    endpoint=pim/viewEmployeeList
    ${index}    Find Checkbox     ${id}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+7}]${bin}
    Click    ${warning_alert}

Add Termination Reason
    [Documentation]    Test the behavior when adding a new Termination Reason.
    ...    
    ...    Arguments: reason
    ...
    ...    Example:
    ...    | Add Termination Reason | reason=Injury |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]     ${reason}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu     Configuration     Termination Reasons     pim/viewTerminationReasons
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${reason}
    Click    ${bt_submit}

Delete Termination Reason
    [Documentation]    Test the behavior when deleting an existing Termination Reason.
    ...    
    ...    Arguments: reason
    ...
    ...    Example:
    ...    | Delete Termination Reason | reason=Injury |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]     ${reason}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu     Configuration     Termination Reasons    pim/viewTerminationReasons
    ${index}    Find Checkbox     ${reason}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}

Add Reporting Method
    [Documentation]    Test the behavior when adding a new Reporting Method.
    ...    
    ...    Arguments: method
    ...
    ...    Example:
    ...    | Add Reporting Method | method=One-o-One |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]     ${method}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu     Configuration     Reporting Methods      endpoint=pim/viewReportingMethods
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${method}
    Click    ${bt_submit}

Delete Reporting Method
    [Documentation]    Test the behavior when deleting an existing Reporting Method.
    ...    
    ...    Arguments: method
    ...
    ...    Example:
    ...    | Delete Reporting Method | method=One-o-One |
    ...
    ...    Dependency: Must be on the pim page.
    ... 
    [Arguments]     ${method}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu     Configuration     Reporting Methods     endpoint=pim/viewReportingMethods
    ${index}    Find Checkbox     ${method}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}