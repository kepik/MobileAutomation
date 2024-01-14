*** Settings ***
Library                AppiumLibrary
Resource                ../Resources/password.robot

*** Variables ***
# Test Variables
&{USER-LOGIN-DETAILS}    email=${EMAIL-LOGIN1}    password=${PASSWORD1}

${PLATFORM}            iOS
${PLATFORM-VER}        17.2
${DEVICE-NAME}         iPhone 15 Pro Max
${APP-PACKAGE}         ../Resources/MyRNDemoApp.app

# Elements
${MENU}                //XCUIElementTypeButton[@name="tab bar option menu"]
${LOGIN}               //XCUIElementTypeOther[@name="menu item log in"]
${USER-INPUT}          //XCUIElementTypeTextField[@name="Username input field"]
${PASSWORD-INPUT}      //XCUIElementTypeSecureTextField[@name="Password input field"]
${LOGIN-BUTTON}        //XCUIElementTypeSecureTextField[@name="Password input field"]
${LOGOUT}              //XCUIElementTypeOther[@name="menu item log out"]
${LOGOUT-CONFIRM}      //XCUIElementTypeButton[@name="Log Out"]
${LOGOUT-SUCCESS}      //XCUIElementTypeButton[@name="Log Out"]


*** Keywords ***
Start_Application
    Open Application    http://localhost:4723/wd/hub
    ...                 platformName=${PLATFORM}
    ...                 platformVersion=${PLATFORM-VER}
    ...                 deviceName=${DEVICE-NAME}
 #   ...                 app=${APP-PACKAGE}
    ...                 automationName=XCUITest
    Sleep                3
Login_App
    Wait Until Page Contains        ${MENU}
    Click Element                   ${MENU}
    Click Element                   ${LOGIN}
Input_UserLogin
    Wait Until Page Contains        ${USER-INPUT}
    Input Text                      ${USER-INPUT}        ${USER-LOGIN-DETAILS}[email]
    Input Password                  ${PASSWORD-INPUT}    ${USER-LOGIN-DETAILS}[password]
    Click Element                   ${LOGIN-BUTTON}
Logout_App
    Wait Until Page Contains        ${MENU}
    Click Element                   ${LOGOUT}
    Click Element                   ${LOGOUT-CONFIRM}
    Click Element                   ${LOGOUT-SUCCESS}


*** Test Cases ***
Login and Logout Application
    [Setup]            Start_Application
    Login_App
    Input_UserLogin
    Login_App