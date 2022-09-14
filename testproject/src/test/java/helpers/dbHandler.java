package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.oracle.truffle.regex.tregex.util.json.JsonObject;

import net.minidev.json.JSONObject;

public class dbHandler {

    //in the below request add dburl,dbname,username and password
    private static String connectionURL = "jdbc:sqlserver://APPENDTHEURLHERE;database=GIVEDBNAME;user=GIVEUSERNAME;password=GIVEPASSWORD";

    //Inserting value to db: Method to execute will execute the query with return null
    public static void executeInsert(String neededValue){
    
        try(Connection connect = DriverManager.getConnection(connectionURL)){
            connect.createStatement().
            execute("give sql query here ex: INSERT INTO [dbname].[dbo].[jobs] (job_desc, min_val,max_val) VALUES ('"+neededValue+"',50,100)");
        }
        catch(SQLException exception){
            exception.printStackTrace();
        }
    
    }

    /* Get the values from db: executeQuery returns the value from DB, Resultset stored the ruturned variabled, 
       rs.next to move the cursor from tablename to data, getstring gets value based on tablename and stored on variable min and max level */
    public static JSONObject getValuesFromDB(String neededValue){
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionURL)){
            ResultSet rs = connect.createStatement().
            executeQuery("give sql query here SELECT * From [dbname].[dbo].[jobs] (job_desc, min_val,max_val) VALUES ('"+neededValue+"',50,100)");
            rs.next();
            json.put("minLevel", rs.getString("giveTableName1"));
            json.put("maxLevel", rs.getString("giveTableName2"));
        }
        catch(SQLException exception){
            exception.printStackTrace();
        }

        return json;

    }

}