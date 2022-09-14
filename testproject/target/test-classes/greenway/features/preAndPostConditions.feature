@beforeAfterhooks
Feature: Before and After Hooks concepts

    Background: Hooks
        // Before method
        // call keyword calls the dummy feature before execution of each scenario (so username will keep on changing)
        # * def result = call read('classpath:/helpers/dummy.feature')
        //call once option will call the dummy feature only one time and the same value used before each scenario(so username will remain same)
        # * def result = callonce read('classpath:/helpers/dummy.feature')
        # * def username = result.username

        // After method - Will execute after every scenario
        # * configure afterScenario = 
        # """
        # function(){
        # karate.log('after scenario:', karate.scenario.name);
        # karate.call('classpath:helpers/dummy.feature')
        # }
        # """
        
        // After feature - One time execution after scenario its used only when the parallel execution is implemented in runnerTest.java
        # * configure afterFeature = function(){ karate.call('classpath:helpers/dummy.feature'); }

    Scenario: First scenario
        * print 'username'
        * print 'This is first scenario'

    Scenario: Second scenario
        * print 'username'
        * print 'This is second scenario'