function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://ingestion-api.edhqa.aws.greenwayhealth.com/tables?schemaVersion=18.31.00&dbTimezone=+05:30',
    testDataUrl: 'https://ingestion-api.edhqa.aws.greenwayhealth.com/',
    requressUrl: 'https://reqres.in/api/'
  }
  if (env == 'dev') {
    config.userName = '2.16.840.1.113883.3.441.73025'
    config.userPassword = 'Pss74000740007400074000740007400074'
  } 
  if (env == 'qa') {
    config.userName = '2.16.840.1.113883.3.441.83026'
    config.password = 'Pss74000740007400074000740007400074'
  }
  var accessTokenConfig = karate.callSingle('classpath:helpers/basicAuth.js', config).accessToken
  karate.configure('headers', {'x-mac-address': 'cf:32:d4:43:b5,ae:43:ad:12:f4'})
  return config;
}