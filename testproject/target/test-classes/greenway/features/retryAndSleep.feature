@retryandsleep
Feature: Retry and Sleep

    Background: Definition of url
        Given url 'https://reqres.in/api/'

    Scenario: Retry scenario (Retries 5 times in interval of 5 seconds)
        * configure retry = { count: 5, interval:5000 }

        Given params {page:2,delay:false}
        Given path 'users'
        And retry until  response.per_page == 6
        When method Get
        Then status 200

    Scenario: Sleep scenario (waits for 5 seconds before validating response code)
        * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

        Given params {page:2,delay:false}
        Given path 'users'
        When method Get
        * eval sleep(5000)
        Then status 200

    Scenario: Converting the number to string
        * def foo = 10                      //define integer
        * def json = {"bar": #(foo+'') }    //convert the interert to string and save in json
        And match json == {'bar': '10'}     //compare json with sample string

    Scenario: Converting the string to number
        * def foo = '10'                      //define integer
        * def json = {"bar": #(foo*1) }    //convert the interert to string and save in json
        And match json == {'bar': 10}     //compare json with sample string
        * def json2 = {"bar": #(parseInt(foo*1)) } //using java script
        And match json2 == {'bar': 10} //using java script