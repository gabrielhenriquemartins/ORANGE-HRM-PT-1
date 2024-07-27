*** Settings ***
Resource   ../variables_and_libraries.robot

*** Keywords ***
Check If Dashboard ${dashboard_name} exists
    [Documentation]    Test the visibility of the dashboard "${dashboard_name}".
    ...    
    ...    Example:
    ...    |     Check If Dashboard Employees on Leave Today exists  |
    ...    
    ...    Dependency: Must be at Dashboard menu.
    ...    
    ...    Minimum Case: 
    ...    | Open Left Menu  | Dashboard |
    ...    | Check If Dashboard Employees on Leave Today exists |
    ${custom_dashboard}   Replace String    ${custom_text}    custom    ${dashboard_name}   
    Get Element States    ${custom_dashboard}     validate    value & visible    