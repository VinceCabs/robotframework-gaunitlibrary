*** Settings ***
Library    SeleniumLibrary
Library    BrowserMobProxyLibrary
Library    RequestsLibrary
Library    GAUnitLibrary

Suite Setup       Run Keywords    Start Proxy      AND    Start Browser
Suite Teardown    Run Keywords    Close Browser    AND    Close Proxy

*** Variables ***
# ${PAGE_URL}             https://particuliers.engie.fr?env_work=acc
${PAGE_URL}               https://particuliers.engie.fr
${bouton_souscription}    xpath=//*[@id='engie_fournisseur_d_electricite_et_de_gaz_naturel_headerhp_souscrire_a_une_offre_d_energie']
${tracking_plan}          ${CURDIR}/tracking_plan.json

*** Keywords ***

Start_Proxy
    # Init BrowserMob Proxy
    Start Local Server
    # Create dedicated proxy on BrowserMob Proxy
    # 'useEcc' is needed to have decent response time with HTTPS
    &{params}                Create Dictionary    port=8082    useEcc=True
   # Create dedicated proxy on BrowserMob Proxy
    ${BrowserMob_Proxy} =    Create Proxy         ${params}

Start Browser
    # Configure Webdriver to use BrowserMob Proxy
    ${options}=                   Evaluate      sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method                   ${options}    add_argument                                         --proxy-server\=localhost:8082
    Call Method                   ${options}    add_argument                                         --ignore-certificate-errors
    Create WebDriver              Chrome        chrome_options=${options}
    Set Selenium Implicit Wait    10

Close Browser
    Close All Browsers

Close Proxy
    Stop Local Server

*** Test Cases ***
home_engie
    New Har               ${TEST NAME}
    Go To                 ${PAGE_URL}
    Sleep                 1
    Click Element         ${bouton_souscription}
    Sleep                 1
    ${har} =              Get Har As Json
    ${checklist} =        Check Tracking From HAR    ${TEST NAME}    ${tracking_plan}    ${har}
    Should Not Contain    ${checklist}               ${False}

    # log results
    ${expected}=    Get Status Expected Events
    ${actual}=      Get Status Actual Events
    Log             ${expected}
    Log             ${actual}
