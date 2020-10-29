*** Settings ***
Library                     OperatingSystem
Library                     GAUnitLibrary

*** Variables ***
${tracking_plan}    ./tests/tracking_plan.json

*** Keywords ***
Tracking Should be Correct
    [Documentation]  takes the name of a Test case and a har file for inputs and check if tracking is correct
    [Arguments]     ${test_case}    ${har}
    ${checklist} =      Check Tracking From HAR     ${test_case}    ${har}   tracking_plan=${tracking_plan}
    Should Not Contain   ${checklist}  ${False} 

*** Test Cases ***
home_engie
    ${json}=     Get File    ./tests/home_engie.har
    ${har}=     Evaluate    json.loads('''${json}''')   json
    Tracking Should be Correct   ${TEST NAME}    ${har}
