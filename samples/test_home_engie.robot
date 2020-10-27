*** Settings ***
Library                     SeleniumLibrary
Library                     BrowserMobProxyLibrary
Library                     RequestsLibrary
Library                     GAUnitLibrary
Suite Setup                 Start_Proxy
Suite Teardown              Close Browsers

*** Variables ***
# ${PAGE_URL}                 https://particuliers.engie.fr?env_work=acc
${PAGE_URL}                 https://particuliers.engie.fr
${bouton_souscription}      xpath=//*[@id='engie_fournisseur_d_electricite_et_de_gaz_naturel_headerhp_souscrire_a_une_offre_d_energie']

*** Keywords ***
Start_Proxy
    [Documentation]         Start chrome browser
    Set Selenium Implicit Wait  10
    ## Init BrowserMob Proxy
    Start Local Server
    ## Create dedicated proxy on BrowserMob Proxy
    &{port}    Create Dictionary    port=8082
   # Create dedicated proxy on BrowserMob Proxy 
    ${BrowserMob_Proxy}=    Create Proxy    ${port}

# Configure Webdriver to use BrowserMob Proxy
    ${options}=  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --proxy-server\=localhost:8082
    Call Method    ${options}    add_argument     --ignore-certificate-errors
    ${options.add_argument}=  Set Variable  --allow-running-insecure-content
    ${options.add_argument}=  Set Variable  --disable-web-security
    ${options.add_argument}=  Set Variable  --ignore-certificate-errors
    Create WebDriver    Chrome     chrome_options=${options}
Close Browsers
    Close All Browsers
    Stop Local Server

*** Test Cases ***
home_engie
    set selenium implicit wait    10
    New Har    ${TEST NAME}
    Go To    ${PAGE_URL}
    Click Element    ${bouton_souscription}
    ${har} =            Get Har As Json
    ${checklist} =      Check Tracking From HAR     ${TEST NAME}    ${har}
    Should Not Contain   ${checklist}  ${False}
