*** Settings ***
Resource   ../variables_and_libraries.robot
Resource   ../Common/common.robot

*** Keywords ***
Add Job Title
    [Documentation]    Test the behavior when adding a job title.
    ...    
    ...    Arguments: job_title
    ...
    ...    Example:
    ...    | Add Job Title | Software Enginner | 
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${job_title}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Job    Job Titles   admin/viewJobTitleList
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${job_title}
    Fill Text    (${description})[1]   This is the job description!
    Click    ${bt_submit}

Delete Job Title
    [Documentation]    Test the behavior when deleting a job title.
    ...    
    ...    Arguments: job_title
    ...
    ...    Example:
    ...    | Delete Job Title | Software Enginner | 
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${job_title}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Job    Job Titles    admin/viewJobTitleList
    ${index}    Find Checkbox     ${job_title}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+2}]${bin}
    Click    ${warning_alert}

Add Location
    [Documentation]    Test the behavior when adding a new location.
    ...    
    ...    Arguments: name, city, state, country, zip_code, phone, fax
    ...
    ...    The Arguments: country, zip_code, phone, fax are optional.
    ...
    ...    Example:
    ...    | Add Location | name=R&D | city=Lincoln | state=Nebraska | country=USA |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${name}   ${city}  ${state}   ${country}=Brazil    ${zip_code}=1000   ${phone}=1000    ${fax}=1000
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Organization    Locations    admin/viewLocations
    Click    ${button_add_v2}
    Click    ${dropdown}
    ${custom_country}   Replace String    ${custom_option}    custom    ${country}
    Click        ${custom_country}
    Fill Text    ${field_text}    ${name}
    Fill Text    (${general_field_text})[2]    ${city}
    Fill Text    (${general_field_text})[3]    ${state}
    Fill Text    (${general_field_text})[4]    ${zip_code}
    Fill Text    (${general_field_text})[5]    ${phone}
    Fill Text    (${general_field_text})[6]    ${fax}
    Click    ${bt_submit}

Delete Location
    [Documentation]    Test the behavior when deleting an existing location.
    ...    
    ...    Arguments: name
    ...
    ...    The Arguments: country, zip_code, phone, fax are optional.
    ...
    ...    Example:
    ...    | Delete Location | name=R&D |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${name}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Organization    Locations     admin/viewLocations
    ${index}    Find Checkbox     ${name}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+5}]${bin}
    Click    ${warning_alert}

Add Language
    [Documentation]    Test the behavior when adding a new language.
    ...    
    ...    Arguments: language
    ...
    ...    Example:
    ...    | Add Language | language=Spanish |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${language}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Qualifications    Languages     admin/viewLanguages
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${language}
    Click    ${bt_submit}

Delete Language
    [Documentation]    Test the behavior when deleting an existing language.
    ...    
    ...    Arguments: language
    ...
    ...    Example:
    ...    | Delete Language | language=Spanish |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]    ${language}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Qualifications    Languages    admin/viewLanguages
    ${index}    Find Checkbox     ${language}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}

Add Membership
    [Documentation]    Test the behavior when adding a new membership.
    ...    
    ...    Arguments: membership
    ...
    ...    Example:
    ...    | Add membership | membership=ISTQB |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${membership}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Qualifications    Memberships     admin/membership
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${membership}
    Click    ${bt_submit}

Delete Membership
    [Documentation]    Test the behavior when deleting an existing membership.
    ...    
    ...    Arguments: membership
    ...
    ...    Example:
    ...    | Delete membership | membership=ISTQB |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]    ${membership}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Qualifications    Memberships     admin/membership
    ${index}    Find Checkbox     ${membership}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}

Add Nationality
    [Documentation]    Test the behavior when adding a new nationality.
    ...    
    ...    Arguments: nationality
    ...
    ...    Example:
    ...    | Add nationality | nationality=Brazilian |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${nationality}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Nationalities     endpoint=admin/nationality
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${nationality}
    Click    ${bt_submit}

Delete Nationality
    [Documentation]    Test the behavior when deleting an existing nationality.
    ...    
    ...    Arguments: nationality
    ...
    ...    Example:
    ...    | Delete nationality | nationality=Brazilian |
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${nationality}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Nationalities    endpoint=admin/nationality
    ${index}    Find Checkbox     ${nationality}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}

Send Email Configuration
    [Documentation]    Test the behavior when sending a email with the standard configuration.
    ...    
    ...    Arguments: email_sender, email_destination
    ...
    ...    Example:
    ...    | Send Email Configuration | email_sender=my_email@hotmail.com |  email_destination=other_email@hotmail.com | 
    ...    
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]    ${email_sender}    ${email_destination}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration    Email Configuration     admin/listMailConfiguration
    Click    ${slider}
    Fill Text    ${field_text}    ${email_sender}
    Fill Text    ${field_text}    ${email_destination}
    Click    ${bt_submit}

Add Social Media Authentication
    [Documentation]    Test the behavior when adding a new Media Authentication.
    ...    
    ...    Arguments: name, provider_url, client_id, client_secret
    ...
    ...    Example:
    ...    | Add Social Media Authentication | name=provider_test | provider_url=provider.com  | client_id=123456 | client_secret=123456 |
    ...
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${name}    ${provider_url}    ${client_id}    ${client_secret}    
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu    Configuration    Social Media Authentication      admin/openIdProvider
    Click    ${button_add_v2}
    Fill Text    ${field_text}    ${name}
    Fill Text    (${general_field_text})[2]    ${provider_url}
    Fill Text    (${general_field_text})[3]    ${client_id}
    Fill Text    (${general_field_text})[4]    ${client_secret}
    Click    ${bt_submit}

Delete Social Media Authentication
    [Documentation]    Test the behavior when deleting an existing Media Authentication.
    ...    
    ...    Arguments: name
    ...
    ...    Example:
    ...    | Delete Social Media Authentication | name=provider_test |
    ...
    ...    Dependency: Must be on the admin page.
    ... 
    [Arguments]   ${name}
    Wait Until Keyword Succeeds   3x   2s    Select Sub Menu   Configuration    Social Media Authentication    admin/openIdProvider
    ${index}    Find Checkbox     ${name}
    Click    (${general_table})[${index-1}]
    Click    (${general_table})[${index+1}]${bin}
    Click    ${warning_alert}

