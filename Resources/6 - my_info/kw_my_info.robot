*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add PDF to Profile
    [Documentation]    Test the behavior when adding a pdf to profile.
    ...
    ...    The path to the pdf file is fixed in this scenario, and the pdf is empty.
    ...
    ...    Example:
    ...    | Add PDF to Profile |
    ...
    ...    Dependency: Must be on the my_info page.
    ... 
    Click    ${button_add_1}
    ${promise}    Promise To Upload File       /opt/robotframework/Utils/files/pdf_test.pdf
    Click    ${upload_button}
    ${upload_result}=    Wait For    ${promise}
    Click    ${bt_submit}:nth-of-type(2)

Delete PDF from Profile
    [Documentation]    Test the behavior when deleting a pdf from profile.
    ...
    ...    This keyword requires only the pdf name.
    ...
    ...    Arguments: pdf
    ...
    ...    Example:
    ...    | Delete PDF to Profile |
    ...
    ...    Dependency: Must be on the my_info page.
    ... 
    [Arguments]    ${pdf}
    ${index}    Find Checkbox     ${pdf}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+6}]${bin}
    Click    ${warning_alert}