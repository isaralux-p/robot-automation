*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Suite Teardown     Close Browser

*** Variable ***
${Browser}                                    chrome
${url}                                        https://mysocialprimate.web.app/login
${url_homepage}                               https://mysocialprimate.web.app
${txt_login}                                  //*[@id="root"]/div/div/div/div[2]/h2
${input_user}                                 //*[@id="email"]
${input_pass}                                 //*[@id="password"]
${btn_login}                                  //*[@id="root"]/div/div/div/div[2]/form/button
${location_email_invalid}                     //*[@id="email-helper-text"]
${txt_email_invalid}                          Email must not be empty!
${location_password_invalid}                  //*[@id="password-helper-text"]
${txt_password_invalid}                       Password Must not be empty!
${location_wrong_credential}                  //*[@id="root"]/div/div/div/div[2]/form/p
${txt_wrong_credential}                       Wrong Credentials, Please try again
${username_valid}                             user@email.com   
${password_valid}                             123456
${username_invalid}                           xxxx@email.com
${password_invalid}                           123456789
${empty}


*** Test Cases ***

Login Test - Success
    [tags]                              Success_Scenario
    Open Browser                        about:blank                         ${Browser}
    Set Screenshot Directory            Robot/Login_Pass
    Go To                               ${url}
    Input Text                          ${input_user}                       ${username_valid}     
    Input Text                          ${input_pass}                       ${password_valid}
    Click Button                        ${btn_login}
    Wait Until Location Contains        ${url_homepage}
    Maximize Browser Window             
    Capture Page Screenshot             Pass.png   
    [Teardown]    Close Browser

Login Test - Fail - Invalid Username & Password
    [tags]                              Fail_Scenario        
    Open Browser                        about:blank                         ${Browser} 
    Set Screenshot Directory            Robot/Login_Fail
    Go To                               ${url}
    Title Should Be                     React App
    Input Text                          ${input_user}                       ${username_invalid}     
    Input Text                          ${input_pass}                       ${password_invalid}
    Click Button                        ${btn_login}
    Wait Until Element Contains         ${location_wrong_credential}        ${txt_wrong_credential} 
    Maximize Browser Window       
    Capture Page Screenshot             Invalid_User_Password.png   
    [Teardown]    Close Browser

Login Test - Fail - Invalid Username
    [tags]                              Fail_Scenario  
    Open Browser                        about:blank                         ${Browser} 
    Set Screenshot Directory            Robot/Login_Fail
    Go To                               ${url}
    Title Should Be                     React App
    Input Text                          ${input_user}                       ${username_invalid}     
    Input Text                          ${input_pass}                       ${password_valid}
    Click Button                        ${btn_login}
    Wait Until Element Contains         ${location_wrong_credential}        ${txt_wrong_credential} 
    Maximize Browser Window       
    Capture Page Screenshot             Invalid_User.png    
    [Teardown]    Close Browser

Login Test - Fail - Invalid Password
    [tags]                              Fail_Scenario  
    Open Browser                        about:blank                         ${Browser} 
    Set Screenshot Directory            Robot/Login_Fail
    Go To                               ${url}
    Title Should Be                     React App
    Input Text                          ${input_user}                       ${username_valid}     
    Input Text                          ${input_pass}                       ${password_invalid}
    Click Button                        ${btn_login}
    Wait Until Element Contains         ${location_wrong_credential}        ${txt_wrong_credential} 
    Maximize Browser Window       
    Capture Page Screenshot             Invalid_Password.png   
    [Teardown]    Close Browser
    
Login Test - Fail - Empty Username
    [tags]                              Fail_Scenario  
    Open Browser                        about:blank                         ${Browser} 
    Set Screenshot Directory            Robot/Login_Fail
    Go To                               ${url}
    Title Should Be                     React App
    Input Text                          ${input_user}                       ${empty}
    Input Text                          ${input_pass}                       ${password_valid}
    Click Button                        ${btn_login}
    Wait Until Element Contains         ${location_email_invalid}           ${txt_email_invalid} 
    Maximize Browser Window       
    Capture Page Screenshot             Invalid_empty_user.png   
    [Teardown]    Close Browser

Login Test - Fail - Empty Password
    [tags]                              Fail_Scenario  
    Open Browser                        about:blank                         ${Browser} 
    Set Screenshot Directory            Robot/Login_Fail
    Go To                               ${url}
    Title Should Be                     React App
    Input Text                          ${input_user}                       ${username_valid}     
    Input Text                          ${input_pass}                       ${empty}
    Click Button                        ${btn_login}
    Wait Until Element Contains         ${location_password_invalid}        ${txt_password_invalid} 
    Maximize Browser Window       
    Capture Page Screenshot             Invalid_empty_password.png   
    [Teardown]    Close Browser
    
    