function fn(s) {
    var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'");
    try {
      sdf.parse(s).time;
      return true;
    } catch(e) {
      karate.log('*** invalid date string:', s);
      return false;
    }
  } 
  /* 
  URL for time function github:  https://github.com/karatelabs/karate/blob/master/karate-junit4/src/test/java/com/intuit/karate/junit4/demos/time-validator.js
  adjust the date format as needed 
  this function used in embedmultilineAssertion.feature
  */