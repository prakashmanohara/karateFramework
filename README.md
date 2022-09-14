# karateFramework
API testing using Karate framework with Helpers, Assertions, TestData Generator, Cucumber &amp; Karate reports, JSON/JAVA file readers, SQL query runner, and Docker

Helpers, Assertions, TestData Generator, Cucumber & Karate reports, JSON/JAVA file readers, SQL query runner, and Docker


JSON summary:

JSON consists of objects{} and arrays[]

Possible structures are: 

simple objects and simple arrays 

nested object and nested array 

array of objects

Data types: String, Number, Boolean, null 

Native JSON support to manipulate data

Java Assertion samples:



Examples:

To get lastname(calling a 0bject)  -> def lastname = myobject.Lastname

One of the car(object with array) -> def second car = myobject.Cars[1]

Income q2(object with object) -> def q2income = myobject.Income.Q2

Pets type dog(object with array with object) -> def dogtype = myobject.Pets[0].Type

To update age -> set myobject.age = 30

Update cat name to dog name -> set myobject.Pets[1].Name = myobject.Pets[0].Name

Adding new object in income-> set myobjects.Income.Q3 = “$30000”

Adding new car -> set myobjects.Cars[] =“Porsche”

Update new car -> set myobjects.Cars[0] = “Tesla”

Remove a q2 object in karate -> remove mybojects.Income.Q2

In javascript use-> delete mybojects.Income.Q2

Remove bmw -> remove myobjects.car[1]



Assertions:

Assertion commands given in: https://github.com/karatelabs/karate 



Example to validate a integer:
And match response.per_page == 6
Or
* assert response.per_page == 6


Example to validate a string:
And match response.per_page contains ‘6’
Or
* assert response.per_page contains ‘6’

Not equal or not contains:
And match response.per_page != 6
Or
* assert response.per_page !contains 6

To print give it directly or store it in variable and call it
Then print response.data
Or 
And responseToPrint = response.event.txn_count
Then print reposneToPrint
Or 
(Adding string with response to print)
Then print ‘the response is: ‘, response.data

To get the size: array of objects
And match response.data == '#[6]'
(Here response data contains 6 objects)

To validate the text in support.text
And match response.support.text contains 'To keep ReqRes free, contributions towards server costs are appreciated!'


Detailed assertions are explained in point 17:



How to create basic auth (sample code given in karate Github under the Assert section name as Advanced)

Store the below code in a separate.js file

function fn(creds) {

    var temp = creds.username + ':' + creds.password;
    var Base64 = Java.type('java.util.Base64');
    var encoded = Base64.getEncoder().encodeToString(temp.toString().getBytes());
    return 'Basic ' + encoded;

  }

Call it where you needed in the feature file

Ex:
And header Authorization = call read('basicAuth.js') {username:"2.16.840.1.113883.3.441.83026",password:"Pss74000740007400074000740007400074"}




Framework definition and understanding of the parts of codes

1 How to run separate scenario file - works only in vs code

Step1:

1 Open Extensions -> search for installed karate runner -> click on settings icon and select Extension settings

2 Scroll down in the right side window and check on the Override karate runner



3 Close it and go to the feature file

4 Click on the Karate Run tag before the Scenario. It will run only a particular scenario

5 Click on enter key after the run is completed



Step2:

1 Go to karate GitHub- in the Run section click on Junit 5

2 Copy the second method

3 Paste it on the karate runner

import com.intuit.karate.junit5.Karate;

@Karate.Test

    Karate testTags() {

        return Karate.run().tags("@second").relativeTo(getClass());

    }

4 Place the tag @second before the scenario you want to run (Ex: login.feature)

5 Open terminal give command: mvn test -Dtest=runnerTest#testTags

Here the runnerTest represent the runner file name

6 Below screenshots are the reference and it will run only one scenario because the tag @second is given above the scenario





7 If the tag @second is given above the feature file then it will run the entire feature file



runnerTest.json file

class runnerTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:greenway")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@second").relativeTo(getClass());
    }
}


8 When the above method is run using the command “mvn test” it will run both @Test and @karate.Test methods. So duplicates will be executed. In order to avoid this use the @Karate.Test which will run only the scenarios related to tags.

 Example the script can be run in two different methods using tags:



9 if you want to run one feature file and only one tag (scenario) with another file. Then add two @Karate.Test annotations with methods and call them like below



10 If any scenario/feature doesn’t want to execute add their tag name with ~

Example: 

@Karate.Test
    Karate testTags() {
        return Karate.run().tags("~@second").relativeTo(getClass());
    }

11 Two tags can be added at the same time. One tag for ignore the scenario and another one for regression

@Karate.Test

    Karate testTags() {

        return Karate.run().tags("~@ignore","@regression").relativeTo(getClass());

    }



12 For the same scenario/feature file two tags can be added



13 helpers folder can be created under the java path of the project and reusable files can be kept there

To call the reusable file use  

* def tokenResponse = call read('classpath:helpers/createToken.feature')

Background will be executed every time before the scenario to generate the token only once and to reuse the same token multiple times use the keyword “callonce”

* def tokenResponse = callonce read('classpath:helpers/createToken.feature')



14 Note:

When the calling file is present in the same folder/directory then classpath is not required

Example: 

And header Authorization = call read('basicAuth.js') {username:"#(username)",password:"#(password)"}

When the calling file is present in another folder/directory then class path is required

Example:

And header Authorization = call read('classpath:helpers/basicAuth.js') {username:"#(username)",password:"#(password)"}



15 Karate.config file

In this file, the environment variables can be configured

Default config file:

function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}

Explanation:

If (!env) when the environment is not given/null then the default environment dev will be taken

Var config consists of variables that needs to be stored

If env==dev or e2e or qa respective environment will be loaded



Modified config file:

function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30'
  }
  if (env == 'dev') {
    config.userName = '2.16.840.1.113883.3.441.73025'
    config.userPassword = 'Pss74000740007400074000740007400074'
  } if (env == 'qa') {
    config.userName = '2.16.840.1.113883.3.441.83026'
    config.password = 'Pss74000740007400074000740007400074'
  }
  karate.configure('headers', {'x-mac-address': 'cf:32:d4:43:b5,ae:43:ad:12:f4'})
  return config;
}

Explanation:

When the env is dev or qa it will take the respective credentials

The apiUrl stored in var config can be used anywhere in the feature file just with keyword apiUrl

Karate.log will print in console based on the environment given

Karate.configure contains the common headers needed for all the scenarios



Once the environments are configured run the command: 

mvn test -Dkarate.ev="dev"

Or for qa environment:

mvn test -Dkarate.ev=“qa”



16 Data can be embedded and used for a particular scenario alone

a) Here the email and password are stored on request and can be called multiple times for the same request

B) the request is multiline and it's aligned using three double quotes “””





17 Assertions

To check the response type => response.token == "#string"
To check the string value => response.token contains "QpwL5tke4Pnpja7X4"
To check not contains string value => response.token !contains "test"
To check integer => And match response.per_page == 6
To get the 1st of name=> And print "matching value is :", response.data[0].name
To check any of the name is matching => response.data[0].name contains any 'abcd', 'cerulean'
To check any of the object inside the data use * instead of number in array => response.data[*].name contains 'blue turquoise'
To check multiple tags inside same object => response.support == {"url":"#string","text":"#string"} 

To have alternate for * is .. which will check inside entire response
response.data[*].name contains 'blue turquoise'
Is
response..name contains 'blue turquoise'

To check a value is same in all the objects use this command
Ex: And match each response..name == '#string'
Ex: And match each response..id == ‘#number.  //use number to validate integer
EX: And match each response..tablestatus == ‘Pending’

To check fuzzy matching its available in GitHub itself
Ex: And match each response..id == ‘#number  //use number to validate integer
To validate if its null or string use double ##
Ex: And match each response..id == ‘##string //it will check null or string
To check the number of objects inside the array data (In the below response 6 objects are there)
match response.data == '#[6]'

Response:

Response:
{"page":1,"per_page":6,"total":12,"total_pages":2,
"data":[{"id":1,"name":"cerulean","year":2000,"color":"#98B2D1",
"pantone_value":"15-4020"},{"id":2,"name":"fuchsia rose",
"year":2001,"color":"#C74375","pantone_value":"17-2031"},
{"id":3,"name":"true red","year":2002,"color":"#BF1932","pantone_value":"19-1664"},
{"id":4,"name":"aqua sky","year":2003,"color":"#7BC4C4","pantone_value":"14-4811"},
{"id":5,"name":"tigerlily","year":2004,"color":"#E2583E","pantone_value":"17-1456"},
{"id":6,"name":"blue turquoise","year":2005,"color":"#53B0AE","pantone_value":
"15-5217"}],"support":{"url":"https://reqres.in/#support-heading",
"text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}

Assertions Script:



18 Schema validation

To check the return types of all the attributes in response use a match like below

Here double ## is used to validate either the attribute in null or string



19 How to validate the current timestamp

Based on the timestamp needed adjust the time value in helpers -> timeValidator.js



Then call the file and apply it to the required place

Def used to call the function inside the js file and assigned on variable

Then it's called on response using variable name=>  ‘#? timeValidator(_)’ 



20 Faker - to generate random text data

Copy the maven dependency and paste it on POM

https://mvnrepository.com/artifact/com.github.javafaker/javafaker 



Create a .java file and methods with the object for Faker which will provide the methods for the test data generator.

EX: faker. Will provide inbuild functions





Call it on any Background or scenario file then assign it on needed place





21 Data-driven approach - the same API validated for different error messages on the same status code



22 How to read data from a file and pass it on to the request body

Create a JSON file and add the requested content in that file



Store it on a variable and call it on the request body



23 Hooks:

The configuration used on karate-config.js will be executed before all the scenarios of all feature files



Background

It will get executed before every scenario of the particular feature file



After scenario:

 This will execute after every scenario



After feature: 

Only on parallel execution, this will be executed



Parallel execution:

It will fun all the scenarios in parallel based on the count mentioned. If any scenario in the feature file mentioned with tag @prallel=false then the scenario won’t be executed in parallel



24 DOCKER:

Go to docker file and config your script location and pom file locations

Go to terminal give command with dot: docker build -t karatetest .

Then give command: docker run -it karatetest

So that below docker file will be executed



Docker with compose method:





Command to run: docker-compose up --build

To read more follow this GitHub link - https://github.com/karatelabs/karate
