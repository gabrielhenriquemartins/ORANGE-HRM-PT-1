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
    Get Element States    //*[@class="oxd-text oxd-text--p" and text()="${dashboard_name}"]     validate    value & visible    