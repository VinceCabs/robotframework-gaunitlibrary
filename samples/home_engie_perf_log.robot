*** Settings ***
Library           Collections
Library           SeleniumLibrary
Library           BrowserMobProxyLibrary
Library           RequestsLibrary
Library           GAUnitLibrary
Suite Setup       Start Browser
Suite Teardown    Close Browsers

*** Variables ***
# ${PAGE_URL}             https://particuliers.engie.fr?env_work=acc
${PAGE_URL}               https://particuliers.engie.fr
${bouton_souscription}    xpath=//*[@id='engie_fournisseur_d_electricite_et_de_gaz_naturel_headerhp_souscrire_a_une_offre_d_energie']
${tracking_plan}          ${CURDIR}/tracking_plan.json

*** Keywords ***
Start Browser
# Configure Webdriver to use BrowserMob Proxy
    ${dc}                Evaluate             sys.modules['selenium.webdriver'].DesiredCapabilities.CHROME    
    ${log_level}         Create Dictionary    performance                                                     ALL
    Set To Dictionary    ${dc}                goog:loggingPrefs                                               ${log_level}
    Create WebDriver     Chrome               desired_capabilities=${dc}

Close Browsers
    Close All Browsers

*** Test Cases ***
home_engie
    set selenium implicit wait    10
    Go To                         ${PAGE_URL}
    Sleep                         3
    Click Element                 ${bouton_souscription}
    Sleep                         1
    ${checklist} =                Check Tracking From Perf Log       ${TEST NAME}    ${tracking_plan} 
    Should Not Contain            ${checklist}                       ${False}
    Log                           Test Get Status Expected Events
    Log                           Test Get Status Actual Events
