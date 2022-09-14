@testfileReader
Feature: Read and send data

    Background: Generate token one time and Define URL for other scenarios
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def authToken = tokenResponse.accessToken
        And print authToken
        * url testDataUrl
        #read the testdata from sampledata json file
        * def requestBody = read('classpath:greenway/testdata/sampleData.json')
        #set the variable with all the functions in dataGenrator java file
        * def dataGenerator = Java.type('helpers.dataGenerator') 
        #below command appends the data into existing request body and send it as new request
        * set requestBody.environment = dataGenerator.getRandomAttributesValue().environment
        * set requestBody.cdcOutboundEnvelope.cdcOutboundRows[0].tableName = dataGenerator.getRandomAttributesValue().environment
        * set requestBody.cdcOutboundEnvelope.cdcOutboundRows[0].cdcDataObject[0].value = dataGenerator.getRandomAttributesValue().numberwithMinMax


        Scenario: Read data from testdata folder json file and send it in body without any changes.
                  Find the newly appended values in print statement
            Then header Authorization = 'Bearer '+ authToken
            And path 'cdcenvelope'
            And request requestBody
            When method POST
            Then status 400
            And print response
            Then match response == 
            """
                {"message":"CDC Envelope is processed"}
            """