Feature: Check the db conection

    Background: connect to db with dbHandler.java in helpers folder
        * def dbHandlerVariable = Java.type('helpers.dbHandler') 


    Scenario: Insert the data into table in db
        * eval dbHandlerVariable.executeInsert("PassingNeededValueToExecuteMethod")

    Scenario: Get the data from db
        * def receivingdata = dbHandlerVariable.getValuesFromDB("PassingNeededValueToExecuteMethod")
        * print receivingdata.minLevel
        * print receivingdata.maxLevel
        And match receivingdata.minLevel = '100 give the value in db, comparing actual & expected result'