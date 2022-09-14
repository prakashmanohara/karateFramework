

Feature: Test for Get request

    Background: Definition of url
        Given url 'https://reqres.in/api/'


@regression 

    Scenario: Get all the users
        Given path 'users?page=2'
        When method Get
        Then status 200

@ignore @endtoendtest
    #two parameters can be passed in same time
    Scenario: Get all the users with parameters 
        Given params {page:2,delay:false}
        Given url 'https://reqres.in/api/users'
        When method Get
        Then status 200

@ignore
    #using path
    Scenario: Get all the users with path 
        Given params {page:2,delay:false}
        Given path 'users'
        When method Get
        Then status 200
        And match response.per_page == 6
        * assert response.per_page == 6
        And match response.per_page != 7
        And match response.per_page != "#string"
       Then print response.data
       And match response.data == '#[6]'
       And match response.support.text contains 'To keep ReqRes free, contributions towards server costs are appreciated!'