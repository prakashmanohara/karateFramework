package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class dataGenerator {

    //Generates random email using combination of name,integer(min,max) and string
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(5, 100) + "@test.com";
        return email;
    }

    //Generates random username by using inbuild username function
    public static String getRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    //instance method for example. Not recommended just used for practice. Use static method always
    public String getRandomUsername2(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    //Read the json file and replace the particular tags
    public static JSONObject getRandomAttributesValue(){
        Faker faker = new Faker();
        String environment = faker.gameOfThrones().character();
        Integer numberwithMinMax = faker.random().nextInt(2, 20);
        JSONObject json = new JSONObject();
        json.put("environment", environment);
        json.put("numberwithMinMax", numberwithMinMax);
        return json;
    }
}