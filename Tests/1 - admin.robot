*** Settings ***
Resource   ../Resources/1 - admin/kw_admin.robot
Resource   ../Resources/Common/common.robot
Suite Setup    Open Left Menu   Admin

*** Test Cases ***
Admin - Add Job Title
    Log To Console   Jira Issue: OTS-XXX 
    Add Job Title          Senior DevOps
    Sleep    3s
    Check Toast Message    Successfully Saved

Admin - Delete Job Title
    Log To Console   Jira Issue: OTS-XXX  
    Delete Job Title       Senior DevOps
    Check Toast Message    Successfully Deleted

Admin - Add Location
    Log To Console   Jira Issue: OTS-XXX  
    Add Location           name=R&D   city=New York  state=California  
    Check Toast Message    Successfully Saved

Admin - Delete Location
    Log To Console   Jira Issue: OTS-XXX 
    Delete Location        name=R&D
    Check Toast Message    Successfully Deleted

Admin - Add Language
    Log To Console   Jira Issue: OTS-XXX 
    Add Language           language=Brazilian
    Check Toast Message    Successfully Saved

Admin - Delete Language
    Log To Console   Jira Issue: OTS-XXX 
    Delete Language        language=Brazilian
    Check Toast Message    Successfully Deleted

Admin - Add Membership
    Log To Console   Jira Issue: OTS-XXX 
    Add Membership     membership=ISTQB
    Check Toast Message    Successfully Saved

Admin - Delete Membership
    Log To Console   Jira Issue: OTS-XXX 
    Delete Membership    membership=ISTQB
    Check Toast Message    Successfully Deleted

Admin - Add Nationality
    Log To Console   Jira Issue: OTS-XXX 
    ${random_number}     Generate Random String     length=8   chars=[NUMBERS]
    Set Global Variable    ${random_number}    ${random_number}
    Add Nationality    nationality=Brazilian${random_number}
    Check Toast Message    Successfully Saved

Admin - Delete Nationality
    Log To Console   Jira Issue: OTS-XXX 
    Delete Nationality    nationality=Brazilian${random_number}
    Check Toast Message    Successfully Deleted
    
Admin - Send Email Configuration
    Log To Console   Jira Issue: OTS-XXX 
    Send Email Configuration   email_sender=test_sender@hotmail.com       email_destination=test_destination@hotmail.com
    Check Toast Message    Successfully Saved
    Check Toast Message    Test Email Sent

Admin - Add Social Media Authentication
    Log To Console   Jira Issue: OTS-XXX 
    Add Social Media Authentication       name=provider_test   provider_url=provider.com   client_id=123456   client_secret=123456
    Check Toast Message    Successfully Saved

Admin - Delete Social Media Authentication
    Log To Console   Jira Issue: OTS-XXX 
    Delete Social Media Authentication    name=provider_test
    Check Toast Message    Successfully Deleted