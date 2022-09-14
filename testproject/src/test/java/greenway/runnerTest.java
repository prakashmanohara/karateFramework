package greenway;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class runnerTest {


    //For paralle execution only karate report
    // @Test
    // void testParallel() {
    //     Results results = Runner.path("classpath:greenway").tags("@second")
    //             //.outputCucumberJson(true)
    //             .parallel(5);
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    // }



    /* For paralle execution (Karate & cucumber report)
    Runner.path = defineds the parent path of feature folder
    tags = based on the given tag it will execute. ~@tag used to ignore the scenarios with respective tag
    .outputCucumberJson(true) = generates cucumber report. If its not needed commend out below test and generateReport method 
    enable the above test.
    */
    // @Test
    // void testParallel() {
    //     Results results = Runner.path("classpath:greenway").tags("~@ignore","~@tokenscripts","~@embed","~@embeding","~@datadriven",
    //     "~@testfileReader","~@beforeAfterhooks","@retryandsleep")
    //             .outputCucumberJson(true)
    //             .parallel(5);
    //     generateReport(results.getReportDir());
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    // }     
    /* Change the "Greenway application" name to any project name
       Below method used to generate the cucumber report with .outputCucumberJson(true) and generateReport(results.getReportDir()); is used on @Test
    */
    // public static void generateReport(String karateOutputPath) {
    //     Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
    //     List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
    //     jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
    //     Configuration config = new Configuration(new File("target"), "Greenway application");
    //     ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    //     reportBuilder.generateReports();
    // }



    //to run only the scenario/feagture files based on tags
    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("~@ignore","~@tokenscripts","~@embed","~@embeding","@datadriven",
        "~@testfileReader","~@beforeAfterhooks","@retryandsleep").relativeTo(getClass());
    }


    /*
    @Karate.Test
        Karate testAll() {
            return Karate.run().relativeTo(getClass());
        }
    */
}

