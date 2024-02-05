package com.hanul.smart.data;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hanul.smart.common.CommonUtility;

@Controller
@RequestMapping("/data")
@PropertySource("classpath:dbconn/conninfo.properties")
public class DataController {

	@Autowired
	CommonUtility comm;

	@Value("${data.key}")
	private String key;

	@RequestMapping("/list")
	public String list(HttpSession session) {
		session.setAttribute("category", "da");
		return "data/list";
	}

	@ResponseBody
	@RequestMapping("/pharmacy")
	public Object pharmacy_list(int pageNo, int numOfRows) {
		StringBuilder url = new StringBuilder();
		url.append("http://apis.data.go.kr/B551182/pharmacyInfoService/getParmacyBasisList");
		url.append("?_type=json");
		url.append("&ServiceKey=").append(key);
		url.append("&pageNo=").append(pageNo);
		url.append("&numOfRows=").append(numOfRows);
		
		return responseAPI(url);
	}
	
	private HashMap<String, Object> responseAPI(StringBuilder url) {
		
		return new Gson().fromJson(comm.requestAPI(url.toString()), new TypeToken<HashMap<String, Object>>(){}.getType());
	}

}
