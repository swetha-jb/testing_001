*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    http://172.24.131.218:8085/api/auth/login
${VALID_USERNAME}    sfitvvdntenant@yopmail.com
${VALID_PASSWORD}    PassWord@1
${INVALID_PASSWORD}    WrongPass@1
${INVALID_USERNAME}    invaliduser@yopmail.com
${AUTH_TOKEN}    Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZml0dnZkbnRlbmFudEB5b3BtYWlsLmNvbSIsImF1dGhvcml0aWVzIjpbeyJhdXRob3JpdHkiOiJWSUVXX1BST0pFQ1QifSx7ImF1dGhvcml0eSI6IkVESVRfVVNFUiJ9LHsiYXV0aG9yaXR5IjoiVklFV19SRVBPUlQifSx7ImF1dGhvcml0eSI6IkNSRUFURV9VU0VSIn0seyJhdXRob3JpdHkiOiJERUxFVEVfVVNFUiJ9LHsiYXV0aG9yaXR5IjoiRURJVF9QRVJNSVNTSU9OIn0seyJhdXRob3JpdHkiOiJWSUVXX1JPTEUifSx7ImF1dGhvcml0eSI6IkVESVRfUk9MRV9QRVJNSVNTSU9OX01BUFBJTkcifSx7ImF1dGhvcml0eSI6IkVESVRfUk9MRSJ9LHsiYXV0aG9yaXR5IjoiREVMRVRFX1BFUk1JU1NJT04ifSx7ImF1dGhvcml0eSI6IlJPTEVfU1VQRVJfQURNSU4ifSx7ImF1dGhvcml0eSI6IlZJRVdfUk9MRV9QRVJNSVNTSU9OX01BUFBJTkcifSx7ImF1dGhvcml0eSI6IkRFTEVURV9ST0xFIn0seyJhdXRob3JpdHkiOiJDUkVBVEVfUk9MRSJ9LHsiYXV0aG9yaXR5IjoiQ1JFQVRFX1JPTEVfUEVSTUlTU0lPTl9NQVBQSU5HIn0seyJhdXRob3JpdHkiOiJFRElUX1BST0pFQ1QifSx7ImF1dGhvcml0eSI6IkRFTEVURV9QUk9KRUNUIn0seyJhdXRob3JpdHkiOiJERUxFVEVfUk9MRV9QRVJNSVNTSU9OX01BUFBJTkcifSx7ImF1dGhvcml0eSI6IkNSRUFURV9QUk9KRUNUIn0seyJhdXRob3JpdHkiOiJWSUVXX1BFUk1JU1NJT04ifSx7ImF1dGhvcml0eSI6IkFTU0lHTl9ST0xFX1RPX1VTRVIifSx7ImF1dGhvcml0eSI6IlZJRVdfVVNFUiJ9LHsiYXV0aG9yaXR5IjoiQ1JFQVRFX1BFUk1JU1NJT04ifV0sIm9yZ2FuaXphdGlvbiI6IlZWRE5fQkJTUiIsInRlbmFudF9pZCI6InNmaXR2dmRuc2NoZW1hIiwiaWF0IjoxNzQxNjcwNzE2LCJleHAiOjE3NDE3NTcxMTZ9.S1Fca8o-a7XreCQ-9D5aURQuUWduUhXtg0-9Nx8H5b4

&{HEADERS}    Accept=application/json    Content-Type=application/json    Authorization=${AUTH_TOKEN}

*** Test Cases ***
Valid Login Should Return 200
    [Documentation]    Ensure login with valid credentials is successful
    &{data}    Create Dictionary    username=${VALID_USERNAME}    password=${VALID_PASSWORD}
    ${response}    POST    ${BASE_URL}    headers=&{HEADERS}    json=&{data}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}

Valid Login Should Return Auth Token
    [Documentation]    Ensure login response contains authentication token
    &{data}    Create Dictionary    username=${VALID_USERNAME}    password=${VALID_PASSWORD}
    ${response}    POST    ${BASE_URL}    headers=&{HEADERS}    json=&{data}
    ${json_response}    Convert To String    ${response.json()}
    Should Contain    ${json_response}    token
