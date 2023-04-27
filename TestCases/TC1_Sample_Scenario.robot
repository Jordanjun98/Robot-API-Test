*** Settings ***

Library           RequestsLibrary

#Suite Setup       Create Session  example.com

*** Variables ***
${API_BASE_URL}     https://restful-booker.herokuapp.com
${headers}  {'token': '62fa88a061c56fb'}


*** Keywords ***
I send a POST request to get the token
    Create Session    create_session    https://restful-booker.herokuapp.com
    ${headers}     Create Dictionary      Content-Type=application/json
    ${data}      Create Dictionary    username=admin    password=password123
    ${response}    Post Request     create_session    /auth     json=${data}
    ${payload}    Set Variable    ${response.json()}
    ${token}    Set Variable        ${payload['token']}


I send a POST request to create a booking
    Create Session   create_session    https://restful-booker.herokuapp.com
    ${headers}    Create Dictionary    Content-Type=application/json     Accept=application/json
    ${date}     Create Dictionary     checkin=2023-05-02    checkout=2022-05-05
    ${data}      Create Dictionary     firstname=TESTEE2    lastname=002     totalprice=300    depositpaid=true       bookingdates=${date}      additionalneeds=mattress
    ${response}    Post Request       create_session      /booking      json=${data}    headers=${headers}
    ${payload}    Set Variable    ${response.json()}
    ${bookingID}    Set Variable     ${payload['bookingid']}
    ${status_code}    Set Variable    ${response.status_code}
    #Validating the status is either 200 or 201
#    Should Be True  ${response.status_code} == 200 or ${response.status_code} == 201

#    ${status}    Status Should Be   200  ${response.status_code}


I want to loop through array of objects of booking id
    ${response}  GET    ${API_BASE_URL}/booking
    ${payload}    Set Variable    ${response.json()}
    FOR  ${booking}  IN  @{payload}
        Log  ${booking['bookingid']}
    END

#I want to get the booking ID and check in date
#    ${response}    GET     ${API_BASE_URL}/

*** Test Cases ***
Verify POST Request
    Given I send a POST request to get the token
    When I send a POST request to create a booking


Verify the GET Request
    Given I want to loop through array of objects of booking id






