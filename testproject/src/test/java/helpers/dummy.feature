Feature: Dummy

    Scenario: Dummy
        * def dataGenerator = Java.type('helpers.dataGenerator')
        * def username = dataGenerator.getRandomUsername()
        * print username