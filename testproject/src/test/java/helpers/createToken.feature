
Feature: Create token

    # Scenario: Generate bearer token - Single user
    #     Given url 'https://auth-api.gisqa.aws.greenwayhealth.com/oauth2/'
    #     #username and password in bellow lines are paratmeters
    #     And header Authorization = call read('classpath:helpers/basicAuth.js') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}
    #     And path 'as/token.oauth2'
    #     And request {"grant_type":"client_credentials","scope":"test-scope gcs-scope cdc-scope"}
    #     When method POST
    #     Then status 200
    #     And print response.access_token
    #     * def accessToken = response.access_token

    #Another way of paramterization on username and password so that different users can be used
    Scenario: Generate bearer token for different users based on calling parameters
        Given url 'https://auth-api.gisqa.aws.greenwayhealth.com/oauth2/'
        #username and password in bellow lines are paratmeters
        And header Authorization = call read('classpath:helpers/basicAuth.js') {username:"#(userName)",password:"#(userPassword)"}
        And path 'as/token.oauth2'
        And request {"grant_type":"client_credentials","scope":"test-scope gcs-scope cdc-scope"}
        When method POST
        Then status 200
        And print response.access_token
        * def accessToken = response.access_token