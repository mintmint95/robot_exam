*** Settings ***
Library    CSVLib

*** Variables ***
${Filepath}    /Users/khwankamolnakbanlang/Desktop/page_speed_insight/TestPageSpeedLog.csv

*** Test Cases ***
Test CSV
    # Read CSV As Single List    ${Filepath}
    
	${singlelist}=		Read CSV As Single List		/Users/khwankamolnakbanlang/Desktop/page_speed_insight/test.csv
	Log    ${singlelist}

	${list}=		read csv as list		/Users/khwankamolnakbanlang/Desktop/page_speed_insight/test.csv
	Log    ${list}

	${dict}=		read csv as dictionary		/Users/khwankamolnakbanlang/Desktop/page_speed_insight/test_dict.csv		Animal		Legs		,
	Log    ${dict}

	${value}=		create list			Legs			Eyes
	${dictWList}=		read csv as dictionary		/Users/khwankamolnakbanlang/Desktop/page_speed_insight/test_dict1.csv		Animal		${value}	,
	log to console		${dictWList}

*** Keywords ***
# Read CSV As Single List
#     [Arguments]    ${Filepath}