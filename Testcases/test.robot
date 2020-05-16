*** Settings ***
Library    Selenium2Library
Library    String
Library    OperatingSystem
Library    DateTime
Library    Collections
Library    ../Resources/Libwritefile.py
# Library    ExcelLibrary
# Library    CSVLibrary
Library    CSVLib
Resource    ../Resources/Locators.robot
# Suite Setup    Go To Pagespeed Insights
# Suite Teardown    Close All Browsers

*** Variables ***
${timeout_10m}    10
#---URL---#
@{URL_CHECK}    https://www.wemall.com/
    ...    https://www.wemall.com/truepoint
#----Lab Data----#
@{LAB_DATA}    first-contentful-paint
    ...    first-meaningful-paint
    ...    speed-index
    ...    first-cpu-idle
    ...    interactive
    ...    max-potential-fid
${PATH}    /Users/khwankamolnakbanlang/Desktop/page_speed_insight/TestPageSpeedLog.csv

*** Test Cases ***
Step : Input URL To Analyze
    Input URL To Analyze    @{URL_CHECK}

*** Keywords ***
Go To Pagespeed Insights
    Open Browser    https://developers.google.com/speed/pagespeed/insights   gc

Input URL To Analyze
    [Arguments]    @{URL_CHECK}

    ${Header}  Create List    URL   TYPE   TIME   DATE


    FOR    ${URL}    IN    @{URL_CHECK}
        Go To Pagespeed Insights
        Wait Until Element Is Visible    ${txt_url}    ${timeout_10m}
        Wait Until Element Is Visible    ${btn_analyze}    ${timeout_10m}
        Input Text    ${txt_url}    ${URL}
        Click Element    ${btn_analyze}
        Click On Tab Desktop
        # Show Metric By Lab Data ID
        # pure get value
        # Wait Until Element Is Visible    ${locator_lbl_first_contentful_paint}    ${timeout_10m}

        # implement log file
        Show Metric By Lab Data ID     ${URL}    @{LAB_DATA}
        # write file to csv    ${URL}


        # Go To Pagespeed Insights
    END

Click On Tab Desktop
    Wait Until Element Is Visible    ${div_desktop_tab}    30
    Click Element    ${div_desktop_tab}

Show Metric By Lab Data ID
    [Arguments]    ${URL}    @{LAB_DATA}
    FOR    ${lab_data_id}    IN    @{LAB_DATA}
        ${locator_lbl_first_contentful_paint}    Replace String    ${lbl_lab_data_id}    v_lab_data_id    ${lab_data_id}
        Wait Until Element Is Visible    ${locator_lbl_first_contentful_paint}    ${timeout_10m}
        ${resp}    Get Text    ${locator_lbl_first_contentful_paint}
        write file to csv    ${URL}   ${lab_data_id}   ${resp}
    END