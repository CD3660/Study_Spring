package com.hanul.smart.data;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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

	private String animalURL = "http://apis.data.go.kr/1543061/abandonmentPublicSrvc/";

	@RequestMapping("/animal/sido")
	public Object animal_sido(Model model) {
		StringBuilder url = new StringBuilder(animalURL);
		url.append("sido");
		url.append("?_type=json");
		url.append("&numOfRows=50");
		url.append("&ServiceKey=").append(key);

		model.addAttribute("list", responseAPI(url));
		return "data/animal/animal_sido";
	}

	@RequestMapping("/animal/sigungu")
	public Object animal_sigungu(Model model, String sido) {
		StringBuilder url = new StringBuilder(animalURL);
		url.append("sigungu");
		url.append("?_type=json");
		url.append("&numOfRows=50");
		url.append("&upr_cd=").append(sido);
		url.append("&ServiceKey=").append(key);

		model.addAttribute("list", responseAPI(url));
		return "data/animal/animal_sigungu";
	}

	@RequestMapping("/animal/shelter")
	public Object shelter(Model model, String sido, String sigungu) {
		StringBuilder url = new StringBuilder(animalURL);
		url.append("shelter");
		url.append("?_type=json");
		url.append("&numOfRows=50");
		url.append("&upr_cd=").append(sido);
		url.append("&org_cd=").append(sigungu);
		url.append("&ServiceKey=").append(key);

		model.addAttribute("list", responseAPI(url));
		return "data/animal/animal_shelter";
	}
	@RequestMapping("/animal/kind")
	public Object kind(Model model, String upkind) {
		StringBuilder url = new StringBuilder(animalURL);
		url.append("kind");
		url.append("?_type=json");
		url.append("&numOfRows=50");
		url.append("&up_kind_cd=").append(upkind);
		url.append("&ServiceKey=").append(key);

		model.addAttribute("list", responseAPI(url));
		return "data/animal/animal_kind";
	}

	@RequestMapping("/animal/list")
	public Object animal_list(@RequestBody HashMap<String, Object> map, Model model) {
		StringBuilder url = new StringBuilder(animalURL);
		url.append("abandonmentPublic");
		url.append("?_type=json");
		url.append("&ServiceKey=").append(key);
		url.append("&pageNo=").append(map.get("pageNo"));
		url.append("&numOfRows=").append(map.get("numOfRows"));
		url.append("&upr_cd=").append(map.get("sido"));
		url.append("&org_cd=").append(map.get("sigungu"));
		url.append("&care_reg_no=").append(map.get("shelter"));
		url.append("&upkind=").append(map.get("upkind"));
		url.append("&kind=").append(map.get("kind"));

		model.addAttribute("list", responseAPI(url));
		return "data/animal/animal_list";
	}

	private HashMap<String, Object> responseAPI(StringBuilder url) {
		return new Gson().fromJson(comm.requestAPI(url.toString()), new TypeToken<HashMap<String, Object>>() {
		}.getType());
	}

}
