*** Settings ***
Library    OperatingSystem
Library    GAUnitLibrary

*** Variables ***
${tracking_plan}    ${CURDIR}/tracking_plan.json
${har_file}         ${CURDIR}/home_engie.har
${test_case}        home_engie


*** Test Cases ***
Test Check Tracking From HAR
    ${json}=              Get File                   ${har_file}
    ${har}=               Evaluate                   json.loads('''${json}''')    json
    ${checklist} =        Check Tracking From HAR    ${test_case}                 ${tracking_plan}    ${har}
    Should Not Contain    ${checklist}               ${False} 

Test Get Status Expected Events
    ${json}=                       Get File                      ${har_file}
    ${har}=                        Evaluate                      json.loads('''${json}''')    json
    Check Tracking From HAR        ${test_case}                  ${tracking_plan}             ${har}
    ${expected}=                   Get Status Expected Events
    Log                            ${expected}
    ${length}=                     Get length                    ${expected}
    Should Be Equal As Integers    ${length}                     3
