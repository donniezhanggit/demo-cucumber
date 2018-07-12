package run;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import fun.OperateFileUtils;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;


@RunWith(Cucumber.class)
@CucumberOptions(format = {"pretty", "json:report/report.json"},
		tags = {"@qa_mobile_scenario_sendCode_overdue"},
		features = { "src/test/resources/qa/detail" }
) 
public class QA_Mobile_Detail_sendCode {

	@BeforeClass
	public static void start(){
		OperateFileUtils.deleteFile("error.log");
	}

}
