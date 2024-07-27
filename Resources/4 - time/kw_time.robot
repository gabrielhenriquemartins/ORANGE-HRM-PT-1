*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add Punch in Punch Out
    [Documentation]    Test the behavior when adding a punch in and punch out, with the default configuration.
    ...    The default description will be assigned as "Description of my punch in!" and "Description of my punch out!"
    ...
    ...    Example:
    ...    | Add Punch in Punch Out |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    Wait Until Keyword Succeeds    3x    2s    Select Sub Menu   Attendance      Punch In/Out     
    Validate and Click Button      ${punch_in_title}    ${bt_submit}
    Fill Text    ${description}    Description of my punch in!
    Click    ${bt_submit}
    Check Toast Message    Successfully Saved
    Fill Text    ${description}    Description of my punch out!
    Click    ${clock}   
    Click    ${hour_up}   
    Click    ${pm}     
    Click    ${clock}   
    Click    ${bt_submit}
    Check Toast Message    Successfully Saved
    Wait Until Keyword Succeeds    5x    2s    Get Element States   ${punch_in_title}
    Sleep    5s

Delete Punch in Punch Out
    [Documentation]    Test the behavior when deleting a existing punch in and punch out.
    ...    
    ...    Optional arguments: description
    ...    
    ...    Example:
    ...    | Delete Punch in Punch Out |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    [Arguments]     ${description}=Description of my punch in!
    Wait Until Keyword Succeeds   3x    2s    Select Sub Menu   Attendance      My Records    attendance/viewMyAttendanceRecord
    Wait Until Keyword Succeeds   5x    2s    Get Element States   ${my_records_title}
    ${index}    Find Checkbox     ${description}    start_count=3    step=7
    Click    (${general_table})[${index-2}]
    Click    (${general_table})[${index+4}]${bin}
    Click    ${warning_alert}
    
Add Customer
    [Documentation]    Test the behavior when adding a new customer.
    ...        
    ...    Arguments: customer
    ...    
    ...    Example:
    ...    | Add Customer | customer=Google |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    [Arguments]     ${customer}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Project Info       Customers     time/viewCustomers
    Click    ${button_add_v2}
    Fill Text    ${field_text}     ${customer}
    Fill Text    ${description}    Customer description!
    Click    ${bt_submit}

Delete Customer
    [Documentation]    Test the behavior when deleting an existing customer.
    ...        
    ...    Arguments: customer
    ...    
    ...    Example:
    ...    | Delete Customer | customer=Google |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    [Arguments]    ${customer}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Project Info       Customers     time/viewCustomers
    ${index}    Find Checkbox     ${customer}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+2}]${bin}
    Click    ${warning_alert}

Add Project and Activities
    [Documentation]    Test the behavior when adding a new project.
    ...        
    ...    Arguments: project_name, customer, activity
    ...    
    ...    Example:
    ...    | Add Project and Activities | project_name=WebSite | customer=Google | activity=Test |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    [Arguments]    ${project_name}    ${customer}    ${activity}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Project Info       Projects    time/viewProjects
    Click    ${button_add_v2}
    Fill Text     ${field_text}     ${project_name}
    Fill Text    (${autocomplete})[1]   ${customer}
    Click        //*[@class="oxd-autocomplete-option"]//*[contains(text(), '${customer}')]
    Click    ${bt_submit}
    Wait Until Keyword Succeeds   3x   2s     Click    ${button_add_v2}
    Fill Text    (${general_field_text})[3]    ${activity}
    Click        (${bt_save})[2]

Add Row in My Timesheet
    [Documentation]    Test the behavior when adding a new row in my timesheet.
    ...        
    ...    Arguments: project, activity
    ...    
    ...    Example:
    ...    | Add Row in My Timesheet | project=WebSite | activity=Test |
    ...
    ...    Dependency: Must be on the time page.
    ... 
    [Arguments]     ${project}    ${activity}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Timesheets     My Timesheets     time/viewMyTimesheet
    Run Keyword And Ignore Error    Click     ${bt_create_timesheet}
    Click    ${button_edit}
    ${status}    Run Keyword And Ignore Error    Get Element States    (${autocomplete})[1]
    IF    "${status}" == "FAIL"
        Click    ${add_row}
    END
    Fill Text    (${autocomplete})[1]    ${project}
    Click        //*[@class="oxd-autocomplete-option"]//*[contains(text(), '${project}')]
    Click    (${dropdown})[1]
    Click    //*[@class="oxd-select-option"]//*[contains(text(), '${activity}')]
    Click    ${bt_submit}