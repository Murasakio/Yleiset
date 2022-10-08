*** Settings ***
Library     SeleniumLibrary

*** Keywords ***

Luo Webdriver
    [Arguments]    ${SELAIN}    ${INCOGNITO}
    # Luodaan webdriver halutulle selaimella, halutuilla asetuksilla
    IF    "${SELAIN}" == "Chrome"
        ${options}    Evaluate    selenium.webdriver.ChromeOptions()
        Call Method    ${options}    add_argument    --start-maximized
        IF    ${INCOGNITO}
           Call Method    ${options}    add_argument    --incognito
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
    [Arguments]    ${LINKKI}    ${SELAIN}    ${INCOGNITO}=False
    Luo Webdriver    ${SELAIN}    ${INCOGNITO}
    Go To    ${LINKKI}