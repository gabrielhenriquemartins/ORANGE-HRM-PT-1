*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Candidate Records
    [Documentation]    Test to purge all records from a profession.
    ...    
    ...    Arguments: profession
    ...    
    ...    Example:
    ...    |     Candidate Records  |   profession=Software Engineer   |
    ...    
    ...    Dependency: Must be at Maintenance menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                    |   Maintenance         |
    ...    | Candidate Records                 |   Texas R&D           |
    ...    
    [Arguments]    ${profession}
    Maintenance Password
    Click     ${purge_records}
    Click     ${candidate_records}
    Fill Text     ${type_hints}    Software Engineer
    ${custom_profession}   Replace String    ${custom_autocomplete}    custom    ${profession}
    Click     ${custom_profession}
    Click     ${bt_submit}
    ${status}     Run Keyword And Return Status    Check Toast Message    No Records Found
    IF    '${status}' == 'False'
        Click     ${purge_all}
        Click     ${warning_alert}
        Check Toast Message    Successfully Purged
    END
