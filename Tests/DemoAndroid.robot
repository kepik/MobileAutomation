*** Settings ***
Library                AppiumLibrary
Resource                ../Resources/password.robot

*** Variables ***
# Test Variables
&{USER-LOGIN-DETAILS}    email=${EMAIL-LOGIN}    password=${PASSWORD}

${PLATFORM}            Android
${DEVICE-NAME}         emulator-5554
${APP-PACKAGE}         com.android.vending
${APP-ACTIVITY}        com.android.vending.AssetBrowserActivity

# Playstore elements
${SEARCH-BOX}              //androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View[2]
${SEARCH-INPUT}            //android.widget.EditText
${SEARCH-RESULT}           //androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[2]/android.view.View[1]/android.view.View[1]

${INSTALL-BUTTON}         //androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[1]/android.view.View[3]/android.view.View[1]/android.view.View/android.widget.Button
${SELECT-APP}             //androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[1]/android.view.View[3]/android.view.View[1]
${APP-INSTALLED}          //android.widget.TextView[@content-desc="Uninstall"]
${OPEN-APP-BUTTON}        //android.widget.TextView[@content-desc="Open"]
${UNINSTALL-BUTTON}       //androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[1]/android.view.View[2]/android.widget.Button
${VERIFY-UNINSTALL}       //android.widget.TextView[@content-desc="Uninstall"]

# Goodreads elemets
${SIGN-IN}                //android.widget.TextView[@resource-id="com.goodreads:id/sign_in_button"]
${INPUT-EMAIL}            id=com.goodreads:id/email
${INPUT-PASSWORD}         id=com.goodreads:id/password
${SIGNIN-BUTTON}          id=com.goodreads:id/login_button
${VERIFY-LOGIN}           id=com.goodreads:id/find_friends_button
${MENU}                   id=com.goodreads:id/bottom_navigation_more
${MENU-SETTINGS}          id=com.goodreads:id/btn_settings
${SIGN-OUT-BUTTON}        id=com.goodreads:id/sign_out_button


*** Keywords ***
Start_PlayStore
    Open Application    http://localhost:4723/wd/hub
    ...                 platformName=${PLATFORM}
    ...                 deviceName=${DEVICE-NAME}
    ...                 appPackage=${APP-PACKAGE}
    ...                 appActivity=${APP-ACTIVITY}
    ...                 automationName=Uiautomator2
    Sleep                3
Search_Application
    Wait Until Element Is Visible        ${SEARCH-BOX}
    Click Element                        ${SEARCH-BOX}
    Input Text                           ${SEARCH-INPUT}    goodreads
    Wait Until Element Is Visible        ${SEARCH-RESULT}
    Click Element                        ${SEARCH-RESULT}
Install_Application
    Wait Until Page Contains Element     ${INSTALL-BUTTON}
    Click Element                        ${INSTALL-BUTTON}
    Click Element                        ${SELECT-APP}
    Sleep                                30
    Wait Until Page Contains             ${APP-INSTALLED}
Open_Installed_App
    Wait Until Element Is Visible        ${OPEN-APP-BUTTON}
    Click Element                        ${OPEN-APP-BUTTON}
Login_Application
    Wait Until Page Contains Element    ${SIGN-IN}
    Click Element                       ${SIGN-IN}
    Wait Until Page Contains            ${INPUT-EMAIL}
    Input Text                          ${INPUT-EMAIL}        ${USER-LOGIN-DETAILS}[email]
    Input Password                      ${INPUT-PASSWORD}     ${USER-LOGIN-DETAILS}[password]
    Click Element                       ${SIGNIN-BUTTON}
    Wait Until Page Contains Element    ${VERIFY-LOGIN}
Logout_Application
    Wait Until Page Contains Element    ${MENU}
    Click Element                       ${MENU}
    Click Element                       ${MENU-SETTINGS}
    Click Element                       ${SIGN-OUT-BUTTON}
Quit_Application
    Close Application
Uninstall_App
    Wait Until Page Contains            ${UNINSTALL-BUTTON}
    Click Element                       ${UNINSTALL-BUTTON}
    Click Element                       ${VERIFY-UNINSTALL}

*** Test Cases ***
Install and Login to an Application
    [Setup]        Start_PlayStore
    Search_Application
    Install_Application
    Open_Installed_App
    Login_Application
    Logout_Application
    Quit_Application
    [Teardown]    Start_PlayStore
    Search_Application
    Click Element                        ${SELECT-APP}
    Uninstall_App