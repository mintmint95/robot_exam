*** Settings ***
Library    Selenium2Library
Library    String
Library    OperatingSystem
Library    DateTime
Resource    ../Resources/Locators.robot
Suite Setup    Go To Pagespeed Insights
Suite Teardown    Close All Browsers

*** Variables ***
${timeout_10m}    10
#---URL---#
@{URL_CHECK}    ***URL_1
   ...   ***URL_2
#----Lab Data----#
@{LAB_DATA}    first-contentful-paint
    ...    first-meaningful-paint
    ...    speed-index
    ...    first-cpu-idle
    ...    interactive
    ...    max-potential-fid

*** Test Cases ***
Step : Input URL To Analyze
    Input URL To Analyze    @{URL_CHECK}

*** Keywords ***
Go To Pagespeed Insights
    Open Browser    https://developers.google.com/speed/pagespeed/insights   gc

Input URL To Analyze
    [Arguments]    @{URL_CHECK}
    :For    ${URL}    IN    @{URL_CHECK}
    \    Wait Until Element Is Visible    ${txt_url}    ${timeout_10m}
    \    Wait Until Element Is Visible    ${btn_analyze}    ${timeout_10m}
    \    Input Text    ${txt_url}    ${URL}
    \    Click Element    ${btn_analyze}
    \    Click On Tab Desktop
    \    Show Metric By Lab Data ID    ${URL}    @{LAB_DATA}
    \    Go To Pagespeed Insights

Click On Tab Desktop
    Wait Until Element Is Visible    ${div_desktop_tab}    30
    Click Element    ${div_desktop_tab}

Show Metric By Lab Data ID
    [Arguments]    ${URL}    @{LAB_DATA}
    :For    ${lab_data_id}    IN    @{LAB_DATA}
    \    ${locator_lbl_first_contentful_paint}    Replace String    ${lbl_lab_data_id}    v_lab_data_id    ${lab_data_id}
    \    Wait Until Element Is Visible    ${locator_lbl_first_contentful_paint}    ${timeout_10m}
    \    ${text}    Get Text    ${locator_lbl_first_contentful_paint}
    # \    Log    ${lab_data_id} is ${text}
    \    ${current_date}    Get Current Date    result_format=datetime
    # \    Log    ${current_date}
    # \    Write Variable In File    ${lab_data_id} ${text}\n
    \    ${existing_lab_data}    Get File    ***FilePath/FileName.txt
    # \    Log    ${y}
    \    ${new_lab_data}    Set Variable    ${URL}    ${lab_data_id} ${text} ${current_date}
    \    ${lab_data}    Set Variable    ${existing_lab_data}${new_lab_data}
    # \    Log    ${x}
    \    Write Variable In File    ${lab_data}\n

Write Variable In File
  [Arguments]  ${variable}
  Create File  ***FilePath/FileName.txt  ${variable}
