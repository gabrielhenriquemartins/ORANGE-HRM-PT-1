*** Settings ***
Resource   ../variables_and_libraries.robot

*** Keywords ***
Write and Post
    [Documentation]    This test will write a message and post it.
    ...    
    ...    Arguments: message
    ...    
    ...    Example:
    ...    |     Write and Post  |   message=Holla amigos!   |
    ...    
    ...    Dependency: Must be at Buzz menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                 |   Buzz                    |
    ...    | Write and Post                 |   Holla amigos!           |
    ...    
    [Arguments]    ${message}
    Click    ${tx_area}
    Fill Text    ${tx_area}    ${message}
    Click    ${bt_submit}
    
Check Published Message
    [Documentation]    This test will check a published message.
    ...    
    ...    Arguments: message
    ...    
    ...    Example:
    ...    |     Write and Post  |   message=Holla amigos!   |
    ...    
    ...    Dependency: Must be at Buzz menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                 |   Buzz                    |
    ...    | Write and Post                 |   Holla amigos!           |
    ...    | Check Published Message        |   Holla amigos!           |
    ...    
    [Arguments]    ${message}
    ${custom_post}   Replace String    ${custom_message}    custom    ${message}
    Get Element States    (${custom_post})[1]

React to the first Message with a Heart
    [Documentation]    This test will like the first message, it must be a new message or
    ...    a post without any interaction. This keyword just verify the change from 0 to 1 like.
    ...    
    ...    Example:
    ...    |     React to the first Message with a Heart  |
    ...    
    ...    Dependency: Must be at Buzz menu.
    ...    
    ...    Minimum Case:
    ...    | Open Left Menu                 |   Buzz                    |
    ...    | React to the first Message with a Heart                    |
    ...    
    wait until keyword Succeeds   5x  2s   Get Text and Should be Equal    ${without_likes}    0 Likes
    Click    ${heart_button}
    wait until keyword Succeeds   5x  2s   Get Text and Should be Equal    ${with_likes}    1 Like

Get Text and Should be Equal
    [Documentation]    Do not use this keyword alone, it is part of the React to the first Message with a Heart KW.
    [Arguments]     ${selector}    ${message}
    ${text}    Get Text    ${selector}
    Should Be Equal As Strings    ${text}    ${message}