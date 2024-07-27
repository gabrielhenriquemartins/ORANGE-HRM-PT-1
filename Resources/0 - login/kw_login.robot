*** Settings ***
Resource   ../variables_and_libraries.robot

*** Keywords ***
Open Orange Home Page
    [Documentation]    This keywords is only executed once, at the begining of the test.
    ...    
    ...    This keyword is defined in the first Suite Setup to initiate all the tests. It is highly recomended to be executed with WUKS keyword, as in the example bellow. 
    ...    The page can not be found in the first execution, and take some time to initialyze. 
    ...    
    ...    Example:
    ...    | Suite Setup   |   Wait Until Keyword Succeeds    5x    2s     Open Orange Home Page   |
    ...    
    ...    Dependency: Must be on the login page.
    ... 
    Close Browser
    ${current_date}=    Get Current Date
    New Browser    chromium    headless=Yes  
    New Context    recordVideo={'dir': '${VIDEO_DIR}${current_date}'}
    Set Browser Timeout    20s
    New Page       ${URL}
    Get Title    ==    OrangeHRM
      
Invalid Login
    [Documentation]    Test the behavior when entering an invalid login.
    ...    
    ...    A random value will be fill as an username and password.
    ...    Will be evaluated if the invalid credentials message is being show correctly.
    ...
    ...    Example:
    ...    | Invalid Login |
    ...    
    ...    Dependency: Must be on the login page.
    ... 
    Reload
    ${random_username}     Generate Random String     length=8
    ${random_password}     Generate Random String     length=8
    Fill Text    ${username}    ${random_username}
    Fill Text    ${password}    ${random_password}
    Click    ${bt_submit}
    ${msg}   Get Text      ${invalid_credential_field}
    Should Be Equal As Strings    ${msg}    ${invalid_credential_msg}

Password Required
    [Documentation]    Test the behavior when not entering a password.
    ...    
    ...    A random value will be fill as a password.
    ...    Will be evaluated if the password required message is being show correctly.
    ...
    ...    Example:
    ...    | Password Required |
    ...    
    ...    Dependency: Must be on the login page.
    ...    
    Reload
    ${random_username}          Generate Random String     length=8
    Fill Text    ${username}    ${random_username}
    Click        ${bt_submit}
    ${msg}   Get Text           ${password_required}
    Should Be Equal As Strings  ${msg}    ${required_msg}

Username Required
    [Documentation]    Test the behavior when not entering an Username.
    ...    
    ...    A random value will be fill as an Username.
    ...    Will be evaluated if the Username required message is being show correctly.
    ...
    ...    Example:
    ...    | Username Required |
    ...    
    ...    Dependency: Must be on the login page.
    ...       
    Reload
    ${random_password}     Generate Random String     length=8
    Fill Text    ${password}    ${random_password}
    Click        ${bt_submit}
    ${msg}   Get Text    ${username_required}
    Should Be Equal As Strings    ${msg}    ${required_msg}

Username and Password Required
    [Documentation]    Test the behavior when not entering the username and password.
    ...    
    ...    Will be evaluated if the username and password required message are being show correctly.
    ...
    ...    Example:
    ...    | Username and Password Required |
    ...    
    ...    Dependency: Must be on the login page.
    ...    
    Reload
    Click    ${bt_submit}
    ${msg}   Get Text    ${username_required}
    Should Be Equal As Strings    ${msg}    ${required_msg}
    ${msg}   Get Text    ${password_required}
    Should Be Equal As Strings    ${msg}    ${required_msg}

Check Orange HRM link
    [Documentation]    Check if the oficial WebSite is available.
    ...    
    ...    Example:
    ...    | Check Orange HRM link |
    ...    
    ...    Dependency: Must be on the login page.
    Reload
    Click     ${orange_link}
    Switch Page        NEW
    Get Title    ==    Human Resources Management Software | OrangeHRM   
    Close Page
    Get Title    ==    OrangeHRM

Check Forgot Password
    [Documentation]    Test the behavior of the Forgot Password button.
    ...
    ...    Check if a reset password link has been sent to you via email, using a random username.
    ...    
    ...    Example:
    ...    | Check Forgot Password |
    ...    
    ...    Dependency: Must be on the login page.
    Reload
    Click     ${forgot_password}
    ${msg}    Get Text    ${reset_password}
    Should Be Equal As Strings    ${msg}    ${reset_password_msg}
    ${random_username}     Generate Random String     length=8
    Fill Text    ${username}    ${random_username}
    Click    ${bt_submit}
    ${msg}   Get Text    ${reset_password_1}
    Should Be Equal As Strings    ${msg}    ${reset_password_msg_1}
    ${msg}   Get Text    ${reset_password_2}
    Should Be Equal As Strings    ${msg}    ${reset_password_msg_2}
    ${msg}   Get Text    ${reset_password_3}
    Should Be Equal As Strings    ${msg}    ${reset_password_msg_3}
    Go To    ${URL}

Login With the User Admin
    [Documentation]    Test the behavior of successful login as admin.
    ...
    ...    The default access credentials are: Admin / admin123
    ...    
    ...    Example:
    ...    | Login With the User Admin |
    ...    
    ...    Dependency: Must be on the login page.
    Reload
    Fill Text    ${username}    ${ADMIN_USERNAME}
    Fill Text    ${password}    ${ADMIN_PASSWORD}
    Click    ${bt_submit}
    Get Element    ${profile_photo}