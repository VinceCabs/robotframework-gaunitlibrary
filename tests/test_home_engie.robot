*** Settings ***
Library    OperatingSystem
Library    GAUnitLibrary

*** Variables ***
${tracking_plan}    ${CURDIR}/tracking_plan.json
${har_file}         ${CURDIR}/home_engie.har

*** Test Cases ***
home_engie
    ${json}=              Get File                   ${har_file}
    ${har}=               Evaluate                   json.loads('''${json}''')    json
    ${checklist} =        Check Tracking From HAR    ${TEST_NAME}                 ${tracking_plan}    ${har}
    Should Not Contain    ${checklist}               ${False} 
