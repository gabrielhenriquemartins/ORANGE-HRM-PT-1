*** Settings ***
Resource   ../variables_and_libraries.robot

*** Keywords ***
Find Profession Role
    [Documentation]    Test to find a profession "${profession}" in the directory menu.
    ...    
    ...    Arguments: profession
    ...    
    ...    Example:
    ...    |     Directory - Find Profession Role  |   profession=Software Engineer   |
    ...    
    ...    Dependency: Must be at Directory menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                    |   Directory           |
    ...    | Directory - Find Profession Role  |   Software Engineer   |
    ...    
    [Arguments]    ${profession}
    Click     ${role_dropdown}
    Click     //*[@class="oxd-select-option"]//*[contains(text(), '${profession}')]
    Click     ${bt_submit}

Find Location
    [Documentation]    Test to find a location "${location}" in the directory menu.
    ...    
    ...    Arguments: location
    ...    
    ...    Example:
    ...    |     Directory - Find Location  |   profession=Texas R&D   |
    ...    
    ...    Dependency: Must be at Directory menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                    |   Directory           |
    ...    | Directory - Find Location         |   Texas R&D           |
    ...    
    [Arguments]    ${location}
    Click    ${location_dropdown}
    Click    //*[@class="oxd-select-option"]//*[contains(text(), '${location}')]
    Click    ${bt_submit}