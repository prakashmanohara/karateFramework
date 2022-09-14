Feature: dataDriven to use multiple data in same request

    Background: Precondition
        * url requressUrl
        * def dataGenerator = Java.type('helpers.dataGenerator') 
        * def timeValdator = read('classpath:helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomString = dataGenerator.getRandomUsername()

    @datadriven
        Scenario Outline: only for random data generation using static method

        Given path 'login'
        And request 
        """
            { 
                "email": "<email>",
                "password": "<password>"
            }
        """
        When method POST
        And status 400
        Then print 'The random email is: ', randomEmail
        Then print 'The random string is: ', randomString
        And match response == <errorMessage>

        Examples:
            | email           | password        | errorMessage                           |
            | #(randomEmail)  | #(randomString) | {"error":"user not found"}             |
            | #(randomEmail)  |                 | {"error":"Missing password"}           |
            |                 |                 | {"error":"Missing email or username"}  |
            |                 | #(randomString) | {"error":"Missing email or username"}  |