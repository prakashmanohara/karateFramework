
@tokenscripts
Feature: Login with token

    Background: Generate token one time and Define URL for other scenarios
        # Given url 'https://auth-api.gisqa.aws.greenwayhealth.com/oauth2/'
        # And header Authorization = call read('basicAuth.js') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}
        # And path 'as/token.oauth2'
        # And request {"grant_type":"client_credentials","scope":"test-scope gcs-scope cdc-scope"}
        # When method POST
        # Then status 200
        # And print response.access_token
        # * def authToken = response.access_token
        ## in the below tokenResponse two are given in that use either one
        # * def tokenResponse = callonce read('classpath:helpers/createToken.feature') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def authToken = tokenResponse.accessToken
        And print authToken
        Given url apiUrl

    # Background: Call the createToken.feature based on username and password. It's useful to login as different user. Calling username and password from karate.config sheet
    # To enable this activate scenario "Generate bearer token for different users based on calling parameters"
    #     Given url apiUrl
    #     * def tokenResponse = callonce read('classpath:helpers/createToken.feature') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}
    #     * def authToken = tokenResponse.accessToken


    # Background: Call the createToken.feature based on username and password. It's useful to login as different user. Using username and password in code 
    # To enable this activate scenario "Generate bearer token for different users based on calling parameters"
    #     * def tokenResponse = callonce read('classpath:helpers/createToken.feature') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}
    #     * def authToken = tokenResponse.accessToken
    #     And print authToken
    #     Given url 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30'

    # Scenario: Example to use header from above background
    #     #Given url 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30'      
    #     And header x-mac-address = 'cf:32:d4:43:b5,ae:43:ad:12:f4'
    #     Then header Authorization = 'Bearer '+ authToken
    #     When method GET
    #     Then status 200
    #     * def catchResponses = response
    #     And match catchResponses[0].tableName contains 'actionslu'

    Scenario: Get the tables list
        #The URL will be taken from the background. When the URl is given in both background and scenario then the priority will be given to scenario
        #Given url 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30'      
        #And header x-mac-address = 'cf:32:d4:43:b5,ae:43:ad:12:f4'
        Then header Authorization = 'Bearer '+ authToken
        When method GET
        Then status 200
        #And print response

    Scenario: Check the first table name is matches with actionslu
        #Given url 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30'      
        #And header x-mac-address = 'cf:32:d4:43:b5,ae:43:ad:12:f4'
        Then header Authorization = 'Bearer '+ authToken
        When method GET
        Then status 200
        * def catchResponses = response
        And match catchResponses[0].tableName contains 'actionslu'