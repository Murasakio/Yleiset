*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Python/file_utils.py

*** Keywords ***

Luo Webdriver
    [Arguments]    ${SELAIN}    ${INCOGNITO}    ${HEADLESS}
    # Luodaan webdriver halutulle selaimella, halutuilla asetuksilla
    IF    "${SELAIN}" == "Chrome"
        ${options}    Evaluate    selenium.webdriver.ChromeOptions()
        Call Method    ${options}    add_argument    --start-maximized
        IF    ${INCOGNITO}
           Call Method    ${options}    add_argument    --incognito
        END
        IF    ${HEADLESS}
            Call Method    ${options}   add_argument    --headless
            Call Method    ${options}   add_argument    window-size\=1920,1080
        END
        Create WebDriver    Chrome    options=${options}
    ELSE IF    "${SELAIN}" == "Firefox"
        ${options}    Evaluate    selenium.webdriver.FirefoxOptions()
        #Call Method    ${options}    add_argument    --start-maximized
        IF    ${INCOGNITO}
           Call Method    ${options}    add_argument    --private
        END
        Create WebDriver    Firefox    options=${options}
        Maximize Browser Window
    END


Aseta Selenium Ajat
    [Arguments]    ${SEL_SPEED}=0.3    ${SEL_TIMEOUT}=3
    # Asetetaan testin suoritusnopeus ja avainsanojen odotusaika
    Set Selenium Speed           ${SEL_SPEED}
    Set Selenium Timeout         ${SEL_TIMEOUT}


Avaa Selain Sivulle
    [Arguments]    ${LINKKI}    ${SELAIN}    ${INCOGNITO}=False    ${HEADLESS}=False
    Luo Webdriver    ${SELAIN}    ${INCOGNITO}    ${HEADLESS}
    Go To    ${LINKKI}


Klikkaa Nappi Xp
    [Arguments]    ${xpath}
    Wait Until Page Contains Element    ${xpath}
    Click Element    ${xpath}


Lataa Tiedosto
    [Arguments]    ${latauslinkki_xp}    ${tiedostopolku}    ${tiedostonimi}
    Wait Until Page Contains Element          ${latauslinkki_xp}
    ${imagesrc}    Get Element Attribute      ${latauslinkki_xp}    src
    ${tiedosto_tyyppi}    Fetch From Right    ${imagesrc}    /
    ${tiedosto_tyyppi}    Fetch From Right    ${tiedosto_tyyppi}    .
    ${tiedostonimi}    Catenate    SEPARATOR=.    ${tiedostonimi}    ${tiedosto_tyyppi}
    Download File    ${imagesrc}    ${tiedostopolku}    ${tiedostonimi}
    Wait Until Created    ${tiedostopolku}\\${tiedostonimi}


Hae Tiedostot Pvm
    [Arguments]    ${tiedostopolku}    ${tiedostonimi}
    ${tiedosto_lista}    List Files Date    ${tiedostopolku}    ${tiedostonimi}    False
    [Return]    ${tiedosto_lista}


Hae Uusin Tiedosto
    [Arguments]    ${tiedostopolku}    ${tiedostonimi}
    ${uusin_tiedostopolku}    Latenew File    ${tiedostopolku}    ${tiedostonimi}    True
    [Return]    ${uusin_tiedostopolku}


Hae Vanhin Tiedosto
    [Arguments]    ${tiedostopolku}    ${tiedostonimi}
    ${vanhin_tiedostopolku}    Latenew File    ${tiedostopolku}    ${tiedostonimi}    False
    [Return]    ${vanhin_tiedostopolku}