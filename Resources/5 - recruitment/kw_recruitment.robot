*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add Candidate
    [Documentation]    Test the behavior when adding a new Candidate.
    ...    
    ...    Arguments: first_name, last_name, email
    ...
    ...    Example:
    ...    | Add Candidate | first_name=Aroldo | last_name=Macedo | email=aroldo@hotmail.com |
    ...
    ...    Dependency: Must be on the recruitment page.
    ... 
    [Arguments]     ${first_name}    ${last_name}    ${email}
    Wait Until Keyword Succeeds    3x    2s    Select Sub Menu   Candidates    endpoint=recruitment/viewCandidates
    Click    ${button_add_v2}
    Fill Text    ${tf_first_name}    ${first_name}
    Fill Text    ${tf_last_name}     ${last_name}
    Fill Text    (${tf_email})[1]    ${email}
    Click    ${bt_submit}

Delete Candidate
    [Documentation]    Test the behavior when deleting an existing Candidate.
    ...    
    ...    Arguments: first_name
    ...
    ...    Example:
    ...    | Delete Candidate | first_name=Aroldo |
    ...
    ...    Dependency: Must be on the recruitment page.
    ... 
    [Arguments]     ${first_name}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Candidates    endpoint=recruitment/viewCandidates
    ${index}    Find Checkbox     ${first_name}
    Click    (${general_table})[${index-2}]
    Click    (${general_table})[${index+4}]${bin}
    Click    ${warning_alert}