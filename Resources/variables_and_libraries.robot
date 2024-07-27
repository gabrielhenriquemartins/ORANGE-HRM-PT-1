*** Settings ***
Library    Browser     auto_closing_level=MANUAL     timeout=0:00:20
Library    FakerLibrary
Library    String
Library    Process
Library    OperatingSystem
Library    ../Utils/date_helper.py    WITH NAME    DateHelper

*** Variables ***
${URL}           https://opensource-demo.orangehrmlive.com/web/index.php
${orange_link}   //*[@href="http://www.orangehrm.com"]

${username}      input[name="username"]
${password}      input[name="password"]
${bt_submit}     button[type="submit"]
${tx_area}       textarea[placeholder="What's on your mind?"]

${invalid_credential_field}     //*[@class="oxd-text oxd-text--p oxd-alert-content-text"]
${invalid_credential_msg}       Invalid credentials
${username_required}            (//*[@class="oxd-input-group oxd-input-field-bottom-space"])[1]//*[@class="oxd-text oxd-text--span oxd-input-field-error-message oxd-input-group__message"]
${password_required}            (//*[@class="oxd-input-group oxd-input-field-bottom-space"])[2]//*[@class="oxd-text oxd-text--span oxd-input-field-error-message oxd-input-group__message"]
${required_msg}                 Required
${role_dropdown}                (//*[@class="oxd-select-text oxd-select-text--active"])[1]
${location_dropdown}            (//*[@class="oxd-select-text oxd-select-text--active"])[2]
${purge_records}                //*[@class="oxd-topbar-body-nav-tab-item"][contains(text(), 'Purge Records ')]
${candidate_records}            //*[@role="menuitem"][contains(text(),'Candidate Records')]
${type_hints}                   input[placeholder="Type for hints..."]
${purge_all}                    //*[@class="oxd-button oxd-button--medium oxd-button--secondary" and text()=' Purge All ']
${warning_alert}                //*[@class="oxd-button oxd-button--medium oxd-button--label-danger orangehrm-button-margin"]
${without_likes}                (//*[@class="orangehrm-buzz-stats-row"]//*[@class="oxd-text oxd-text--p"])[1]
${with_likes}                   (//*[@class="oxd-text oxd-text--p orangehrm-buzz-stats-active"])[1]
${general_table}                //*[@class="oxd-table-cell oxd-padding-cell"]
${bin}                          //*[@class="oxd-icon bi-trash"]
${pencil}                       //*[@class="oxd-icon bi-pencil-fill"]
${add_row}                      //*[@class="oxd-icon bi-plus"]

${forgot_password}      //*[@class="oxd-text oxd-text--p orangehrm-login-forgot-header"]
${reset_password}       //*[@class="oxd-text oxd-text--h6 orangehrm-forgot-password-title"]
${reset_password_msg}   Reset Password
${heart_button}         (//*[@id="heart-svg"])[1]  

${reset_password_1}     (//*[@class="oxd-text oxd-text--p"])[1]
${reset_password_2}     (//*[@class="oxd-text oxd-text--p"])[2]
${reset_password_3}     (//*[@class="oxd-text oxd-text--p"])[3]
${reset_password_msg_1}     A reset password link has been sent to you via email.
${reset_password_msg_2}     You can follow that link and select a new password.
${reset_password_msg_3}     If the email does not arrive, please contact your OrangeHRM Administrator.
${personal_details_title}    //*[@class="oxd-text oxd-text--h6 orangehrm-main-title" and text()='Personal Details']

${button_configuration}    //*[@class="oxd-topbar-body-nav-tab-item"][contains(text(), 'Configuration')]
${button_events}           //*[@class="oxd-topbar-body-nav-tab-link"][contains(text(), 'Events')]
${button_expense}          //*[@class="oxd-topbar-body-nav-tab-link"][contains(text(), 'Expense Types')]
${button_add}              //*[@type="button" and text()=' Add ']
${general_field_text}      //*[@class="oxd-input oxd-input--active"]
${field_text}              (//*[@class="oxd-input oxd-input--active"])[2]
${description}             //*[@class="oxd-textarea oxd-textarea--active oxd-textarea--resize-vertical"]
${dropdown}                //*[@class="oxd-icon bi-caret-down-fill oxd-select-text--arrow"]
${slider}                  (//*[@class="oxd-switch-input oxd-switch-input--active --label-right"])[1]
${bt_create_timesheet}     //*[@class="oxd-button oxd-button--medium oxd-button--secondary" and text()=" Create Timesheet "]
${bt_save}                 //*[@type='submit']
${clock}                   //*[@class="oxd-icon bi-clock oxd-time-input--clock"]
${hour_up}                 //*[@class="oxd-icon bi-chevron-up oxd-icon-button__icon oxd-time-hour-input-up"]
${pm}                      //*[@name="pm"]

${button_submit_claim}    //*[@class="oxd-topbar-body-nav-tab-item"][contains(text(), 'Submit Claim')]
${dropdown_1}             (//*[@class="oxd-select-text-input"])[1]
${dropdown_2}             (//*[@class="oxd-select-text-input"])[2]

${button_add_1}    (//*[@class="oxd-button oxd-button--medium oxd-button--text" and text()=' Add '])[1]
${button_add_v2}   //*[@class="oxd-button oxd-button--medium oxd-button--secondary" and text()=' Add ']
${button_edit}     //*[@type="button" and text()=" Edit "]
${input_text}      //*[@class="oxd-select-text-input"]
${date}            //*[@class="oxd-icon bi-calendar oxd-date-input-icon"]
${today_date}      //*[@class="oxd-calendar-date --selected --today"] | //*[@class="--holiday-full oxd-calendar-date --selected --today"]
${field_expense}   //*[@class="oxd-sheet oxd-sheet--rounded oxd-sheet--white oxd-dialog-sheet oxd-dialog-sheet--shadow oxd-dialog-sheet--gutters"]//*[@class="oxd-input oxd-input--active"]
${upload_button}   //*[@class="oxd-icon bi-upload oxd-file-input-icon"]
${button_add_2}    (//*[@class="oxd-button oxd-button--medium oxd-button--text" and text()=' Add '])[2]
${profile_photo}   //*[@class="oxd-userdropdown-img"]
${autocomplete}    //*[@placeholder="Type for hints..."]
${loading}         //*[@class="oxd-loading-spinner"]
${punch_in_title}    //*[@class="oxd-text oxd-text--h6 orangehrm-main-title" and text()="Punch In"]
${my_records_title}  //*[@class="oxd-text oxd-text--h5 oxd-table-filter-title" and text()="My Attendance Records"]

${tf_first_name}      //*[@name="firstName"]
${tf_middle_name}     //*[@name="middleName"]
${tf_last_name}       //*[@name="lastName"]
${tf_email}           //*[@placeholder="Type here"]

${custom_option}          //*[@class="oxd-select-option"]//*[contains(text(), 'custom')]
${custom_autocomplete}    //*[@class="oxd-autocomplete-option"]//*[contains(text(), 'custom')]
${custom_text}            //*[@class="oxd-text oxd-text--p" and text()="custom"]
${custom_table}           //*[@class="oxd-table-card-cell"]//*[contains(text(), 'custom')]
${custom_message}         //*[@class="oxd-text oxd-text--p orangehrm-buzz-post-body-text" and text()="custom"]
${custom_pdf}             //*[@class="oxd-text oxd-text--span" and text()='custom']
${custom_toast_msg}       //*[@class="oxd-text oxd-text--p oxd-text--toast-message oxd-toast-content-text" and text()='custom']
${custom_span}            //span[@class='oxd-text oxd-text--span oxd-main-menu-item--name' and text()='custom']
${custom_menu}            //*[@class="oxd-topbar-body-nav-tab-item"][contains(text(), 'custom')]
${custom_submenu}         //*[@class="oxd-topbar-body-nav-tab-link" and text()="custom"]

${ADMIN_USERNAME}    Admin
${ADMIN_PASSWORD}    admin123
${VIDEO_DIR}    /opt/robotframework/Results/


#setTimeout(() => { debugger }, 6000)