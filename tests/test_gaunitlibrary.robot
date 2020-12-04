*** Settings ***
Library      OperatingSystem
Library      GAUnitLibrary
Variables    test_vars.py

*** Variables ***
${tracking_plan}    ${CURDIR}/tracking_plan.json
${har_file}         ${CURDIR}/mock.har
${test_case}        mock_test_case


*** Test Cases ***
Test Check Tracking From HAR
    ${json}=              Get File                   ${har_file}
    ${har}=               Evaluate                   json.loads('''${json}''')    json
    ${checklist} =        Check Tracking From HAR    ${test_case}                 ${tracking_plan}    ${har}
    Should Not Contain    ${checklist}               ${False} 

Test Get Status Expected Events
    ${json}=                   Get File                      ${har_file}
    ${har}=                    Evaluate                      json.loads('''${json}''')    json
    Check Tracking From HAR    ${test_case}                  ${tracking_plan}             ${har}
    ${expected}=               Get Status Expected Events
    Should Be Equal            ${expected}                   ${expected_events}    # result defined in test_vars.py

Test Get Status Actual Events
    ${json}=                   Get File                    ${har_file}
    ${har}=                    Evaluate                    json.loads('''${json}''')    json
    Check Tracking From HAR    ${test_case}                ${tracking_plan}             ${har}
    ${actual}=                 Get Status Actual Events    url=False
    Should Be Equal            ${actual}                   ${actual_events}      # result defined in var.py

