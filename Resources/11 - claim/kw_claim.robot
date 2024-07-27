*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Create an Event
    [Documentation]    Test to create an event.
    ...    
    ...    Arguments: event
    ...    
    ...    Example:
    ...    |     Create an Event  |   event=Party   |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                    |   Claim         |
    ...    | Create an Event                   |   Party         |
    ...    
    [Arguments]   ${event}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration    Events     claim/viewEvents
    click    ${button_add}
    Fill Text    ${field_text}     ${event}
    Fill Text    ${description}   Some description will be saved here!
    Click    ${bt_submit}

Create an Expense Type
    [Documentation]    Test to create an Expense.
    ...    
    ...    Arguments: Expense
    ...    
    ...    Example:
    ...    |     Create an Expense Type  |   Expense=Fuel   |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                      |   Claim         |
    ...    | Create an Expense                   |   Fuel          |
    ...    
    [Arguments]    ${expense}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration     Expense Types    claim/viewExpense
    click    ${button_add}
    Fill Text    ${field_text}     ${expense}
    Fill Text    ${description}   Some description will be saved here!
    Click    ${bt_submit}

Delete Expense Type
    [Arguments]    ${expense}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration     Expense Types    claim/viewExpense
    ${index}    Find Checkbox     ${expense}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+2}]${bin}
    Click    ${warning_alert}

Delete Event
    [Arguments]    ${event}
    Reload
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration     Events     claim/viewEvents
    ${index}    Find Checkbox     ${event}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+2}]${bin}
    Click    ${warning_alert}

Submit Claim
    [Documentation]    Test to submit claim.
    ...    
    ...    Arguments: event, currency
    ...    
    ...    Example:
    ...    |     Submit Claim  |   event=Party  |   currency=Canadian Dollar  |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu    |   Claim        |
    ...    | Submit Claim      |   event=Party  |   currency=Canadian Dollar  |
    ...    
    [Arguments]    ${event}    ${currency}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Submit Claim    endpoint=claim/submitClaim
    click    ${dropdown_1}
    ${custom_event}   Replace String    ${custom_option}    custom    ${event}
    Click    ${custom_event}
    click    ${dropdown_2}
    ${custom_currency}   Replace String    ${custom_option}    custom    ${currency}
    Click    ${custom_currency}
    Click    ${bt_submit}

Add Expenses
    [Documentation]    Test to add an expense inside a claim.
    ...    
    ...    Arguments: expense, amount
    ...    
    ...    Example:
    ...    |    Add Expenses   |   expense=Transport  |   amount=30  |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu    |   Claim        |
    ...    | Submit Claim      |   Party        |   Canadian Dollar  |
    ...    | Add Expenses      |   Transport    |   150              |
    ...    
    [Arguments]    ${expense}    ${amount}    
    Click   ${button_add_1}
    Click   ${input_text}
    ${custom_expense}   Replace String    ${custom_option}    custom    ${expense}
    Click    ${custom_expense}
    Click   ${date}
    Click   ${today_date}
    Fill Text    ${field_expense}    ${amount}  
    Click    ${bt_submit}  

Add PDF File
    [Documentation]    Test to add an PDF file inside a claim. At this moment, this keyword does not accept
    ...    a path, it fixed, so there's no arguments necessary. A blank pdf will be insert to verify if it is possible
    ...    to upload a file.
    ...    
    ...    Example:
    ...    |    Add PDF File     |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu    |   Claim        |
    ...    | Submit Claim      |   Party        |   Canadian Dollar  |
    ...    | Add PDF File      |
    ...    
    Click      ${button_add_2}
    ${promise}    Promise To Upload File       /opt/robotframework/Utils/files/pdf_test.pdf
    Click    ${upload_button}
    ${upload_result}=    Wait For    ${promise}
    Click    ${bt_submit}  


Verify Added Expense
    [Documentation]    Verify if a file name exist in the page.
    ...    
    ...    Arguments: expense
    ...    
    ...    Example:
    ...    |    Verify Added Expense     |
    ...    
    ...    Dependency: Must be at Claim menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu    |   Claim        |
    ...    | Submit Claim      |   Party        |   Canadian Dollar  |
    ...    | Add Expenses      |   Transport    |   150              |
    ...    | Verify Added Expense     |
    ...    
    [Arguments]    ${expense}
    ${custom_expense}   Replace String    ${custom_table}    custom    ${expense}
    Get Element States    ${custom_expense}