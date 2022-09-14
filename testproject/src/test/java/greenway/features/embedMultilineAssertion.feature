Feature: sample script for embed and multiline

    Background: Precondition
        Given url 'https://reqres.in/api/'
        * def dataGenerator = Java.type('helpers.dataGenerator') 
        * def timeValdator = read('classpath:helpers/timeValidator.js')

@embed
Scenario: Register a client in requress site
    Given def userdata = {"email": "eve.holt@reqres.in","password": "pistol"}

    Given path 'register'
    #And request {"email": "eve.holt@reqres.in","password": "pistol"}
    And request 
    """
        {
            "email": #(userdata.email),
            "password": #(userdata.password)
        }
    """
    When method POST
    Then status 200
    And match response.id == 4            // integer so it doesn't need quotes and finding out the exact value
    And match response.token == "#string" // checking the token tag is string or not
    And match response.token contains "QpwL5tke4Pnpja7X4"
    And match response.token !contains "test"
    #And match response contains any ['token']

@embed
Scenario: List of users to try differen assertions
    Given path 'users?page=2'
    When method GET
    And status 200
    And match response.per_page == 6
    And print "matching value is :", response.data[0].name
    And match response.data[0].name contains any 'abcd', 'cerulean'
    And match response.data[*].name contains 'blue turquoise'
    And match response..name contains 'blue turquoise'
    # If its list provide like below
    # And match response.data[0].name contains any ['abcd', 'cerulean']
    And match response.support == {"url":"#string","text":"#string"} 
    And match each response..name == '#string'
    And match response.data == '#[6]'
    And match each response.data ==
    """
        {
            "id":'#number',
            "name":'#string',
            "year":'#number',
            "color":'#string',
            "pantone_value":'##string'
        }
    """

@embed
Scenario: Update the users and current time assertion
          URL for time function github:  https://github.com/karatelabs/karate/blob/master/karate-junit4/src/test/java/com/intuit/karate/junit4/demos/time-validator.js

    * def timeValdator = read('classpath:helpers/timeValidator.js')

    Given path 'users/2'
    And request { "name": "morpheus","job": "zion resident"}
    When method PUT
    And status 200
    And print "the response is ", response
    And match response == 
    """
        {
            "name": "morpheus",
            "job": "zion resident",
            "updatedAt": '#? timeValdator(_)'
        }
    """

@embeding
Scenario: only for random data generation using static method
    * def  randomEmail = dataGenerator.getRandomEmail()
    * def  randomString = dataGenerator.getRandomUsername()

    Given path 'users/2'
    And request 
    """
        { 
            "name": #(randomString),
            "job": "zion resident"
        }
    """
    When method PUT
    And status 200
    Then print 'The random email is: ', randomEmail
    Then print 'The random string is: ', randomString
    And match response == 
    """
        {
            "name": #(randomString),
            "job": "zion resident",
            "updatedAt": '#? timeValdator(_)'
        }
    """

@embeding
Scenario: Random data generation using instance method. Not recommended just used for practice

    * def jsFunction =
    """
        function (){
            var dataGenerator = Java.type('helpers.dataGenerator')
            var generator = new dataGenerator()
            return generator.getRandomUsername2()
        }
    """
    * def randomUsername2 = call jsFunction

    Given path 'users/2'
    And request 
    """
        { 
            "name": #(randomUsername2),
            "job": "zion resident"
        }
    """
    When method PUT
    And status 200
