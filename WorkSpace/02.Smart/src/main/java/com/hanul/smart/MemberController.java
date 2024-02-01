package com.hanul.smart;

import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import com.hanul.smart.common.CommonUtility;
import com.hanul.smart.common.PageVO;
import com.hanul.smart.member.MemberService;
import com.hanul.smart.member.MemberVO;

@Controller
@RequestMapping("/member")
@PropertySource("classpath:dbconn/conninfo.properties")
public class MemberController {

	@Autowired
	BCryptPasswordEncoder pwEncoder;

	@Autowired
	private MemberService service;

	@Autowired
	private CommonUtility comm;

	@RequestMapping("/loginPage")
	public String loginPage(HttpSession session, String url, PageVO page, String id) {
		session.setAttribute("category", "login");
		if (url != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("url", url);
			map.put("page", page);
			map.put("id", id);
			session.setAttribute("redirect", map);
		}
		return "default/member/login";
	}

	private String redirectURL(HttpSession session, Model model) {
		if(session.getAttribute("redirect") == null) {
			return "redirect:/";
		} else {
			HashMap<String, Object> map = (HashMap<String, Object>)session.getAttribute("redirect");
			model.addAttribute("url", map.get("url"));
			model.addAttribute("page", map.get("page"));
			model.addAttribute("id", map.get("id"));
			
			session.removeAttribute("redirect");
			return "include/redirect";
		}
	}
	
	
	@RequestMapping(value = "/login", produces = "text/html; charset=utf-8")
	public String login(HttpSession session, HttpServletRequest req, MemberVO vo, RedirectAttributes redirect, Model model) {

		MemberVO result = service.member_info(vo.getUser_id());
		boolean check = false;
		if (result != null) {
			check = pwEncoder.matches(vo.getUser_pw(), result.getUser_pw());
		}

		if (check) {
			session.setAttribute("loginInfo", result);
			return redirectURL(session, model);
		} else {
			redirect.addFlashAttribute("fail", true);
			return "redirect:loginPage";
		}

	}

	@Value("${naver.clientId}")
	private String clientId;

	@Value("${naver.clientPw}")
	private String clientPw;

	@RequestMapping("/naverLogin")
	public String naverLogin(HttpSession session, HttpServletRequest req) {
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&
//		client_id=CLIENT_ID&state=STATE_STRING&redirect_uri=CALLBACK_URL
		StringBuilder url = new StringBuilder();
		url.append("https://nid.naver.com/oauth2.0/authorize?response_type=code");
		url.append("&client_id=").append(clientId);
		String state = UUID.randomUUID().toString();
		session.setAttribute("state", state);
		url.append("&state=").append(state);
		url.append("&redirect_uri=").append(comm.appURL(req)).append("/member/naverCallback");

		return "redirect:" + url.toString();
	}

	@RequestMapping("/naverCallback")
	public String naverCallback(String state, String code, HttpSession session, Model model) {
		if (code == null)
			return "redirect:/";
		// https://nid.naver.com/oauth2.0/token?grant_type=authorization_code
//		&client_id=jyvqXeaVOVmV
//		&client_secret=527300A0_COq1_XV33cf
//		&code=EIc5bFrl4RibFls1
//		&state=9kgsGTfH4j7IyAkg
		StringBuilder url = new StringBuilder();
		url.append("https://nid.naver.com/oauth2.0/token?grant_type=authorization_code");
		url.append("&client_id=").append(clientId);
		url.append("&client_secret=").append(clientPw);
		url.append("&code=").append(code);
		url.append("&state=").append(state);
		String resp = comm.requestAPI(url.toString());

		HashMap<String, String> map = new Gson().fromJson(resp, new TypeToken<HashMap<String, String>>() {
		}.getType());

		String token = map.get("access_token");
		String type = map.get("token_type");

		resp = comm.requestAPI("https://openapi.naver.com/v1/nid/me", type + " " + token);

		JsonElement jsonElement = JsonParser.parseString(resp);
		JsonObject jsonObject = jsonElement.getAsJsonObject();

		String resultCode = jsonObject.get("resultcode").getAsString();
		if (resultCode.equals("00")) {
			JsonObject response = jsonObject.getAsJsonObject("response");
			String email = response.get("email").getAsString();
			String gender = response.get("gender").getAsString();
			String name = response.get("name").getAsString();
			String id = response.get("id").getAsString();
			String profile = response.get("profile_image").getAsString();
			String phone = response.get("mobile").getAsString();

			MemberVO vo = new MemberVO();
			vo.setUser_id(id);
			vo.setEmail(email);
			vo.setGender(gender.equals("M") ? "남" : "여");
			vo.setName(name);
			vo.setProfile(profile);
			vo.setPhone(phone);
			vo.setSocial("N");

			if (service.member_info(id) == null) {
				service.member_join(vo);
			} else {
				service.member_update(vo);
			}
			vo = service.member_info(id);
			session.setAttribute("loginInfo", vo);

		}

		return redirectURL(session, model);
	}

	@Value("${kakao.clientId}")
	private String kakaoClientId;

	@RequestMapping("/kakaoLogin")
	public String kakaoLogin(HttpSession session, HttpServletRequest req) {
		StringBuilder url = new StringBuilder();
		url.append("https://kauth.kakao.com/oauth/authorize?response_type=code");
		url.append("&client_id=").append(kakaoClientId);
		url.append("&redirect_uri=").append(comm.appURL(req)).append("/member/kakaoCallback");

		return "redirect:" + url.toString();
	}

	@RequestMapping("/kakaoCallback")
	public String kakaoCallback(String state, String code, HttpSession session, Model model) {
		if (code == null)
			return "redirect:/";

		StringBuilder url = new StringBuilder();
		url.append("https://kauth.kakao.com/oauth/token?grant_type=authorization_code");
		url.append("&client_id=").append(kakaoClientId);
		url.append("&code=").append(code);
		String resp = comm.requestAPI(url.toString());

		HashMap<String, String> map = new Gson().fromJson(resp, new TypeToken<HashMap<String, String>>() {
		}.getType());

		String type = map.get("token_type");
		String token = map.get("access_token");
		resp = comm.requestAPI("https://kapi.kakao.com/v2/user/me", type + " " + token);

		JsonObject jsonId = new Gson().fromJson(resp, JsonObject.class);
		JsonObject jsonProfile = jsonId.getAsJsonObject("kakao_account").getAsJsonObject("profile");
		String name = jsonProfile.get("nickname").getAsString();
		String profile = jsonProfile.get("profile_image_url").getAsString();
		String id = jsonId.get("id").getAsString();

		MemberVO vo = new MemberVO();
		vo.setUser_id(id);
		vo.setName(name);
		vo.setProfile(profile);
		vo.setSocial("K");

		if (service.member_info(id) == null) {
			service.member_join(vo);
		} else {
			service.member_update(vo);
		}
		vo = service.member_info(id);
		session.setAttribute("loginInfo", vo);
		
		return redirectURL(session, model);
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest req) {
		MemberVO vo = (MemberVO) session.getAttribute("loginInfo");

		if ("K".equals(vo.getSocial())) {
			StringBuilder url = new StringBuilder();
			url.append("https://kauth.kakao.com/oauth/logout?");
			url.append("client_id=").append(kakaoClientId);
			url.append("&logout_redirect_uri=").append(comm.appURL(req));
			session.removeAttribute("loginInfo");
			return "redirect:" + url.toString();

		} else if ("N".equals(vo.getSocial())) {

		}

		session.removeAttribute("loginInfo");

		return "redirect:/";
	}

	@RequestMapping("/findPw")
	public String findPw(HttpSession session) {
		session.setAttribute("category", "find");

		return "default/member/findPw";
	}

	@ResponseBody
	@RequestMapping(value = "/resetPw", produces = "text/html; charset=utf-8")
	public String resetPw(MemberVO vo) {

		return service.resetPw(vo);
	}

	@ResponseBody
	@RequestMapping("/checkId")
	public boolean checkId(String user_id) {

		return service.member_info(user_id) == null ? true : false;
	}

	@RequestMapping("/changePw")
	public String changePw(HttpSession session) {
		session.setAttribute("category", "change");

		return "member/changePw";
	}

	@ResponseBody
	@RequestMapping("/confirmPw")
	public int confirmPw(HttpSession session, String user_pw) {
		MemberVO vo = (MemberVO) session.getAttribute("loginInfo");
		if (vo == null) {
			return -1;
		} else {
			return pwEncoder.matches(user_pw, vo.getUser_pw()) ? 1 : 0;
		}
	}

	@ResponseBody
	@RequestMapping("/updatePw")
	public int updatePw(HttpSession session, String user_pw) {
		MemberVO vo = (MemberVO) session.getAttribute("loginInfo");
		vo.setUser_pw(pwEncoder.encode(user_pw));

		return service.member_update(vo);

	}

	@RequestMapping("/joinPage")
	public String joinPage(HttpSession session, String user_pw) {
		session.setAttribute("category", "join");

		return "member/join";

	}

	@ResponseBody
	@RequestMapping(value = "/join", produces = "text/html; charset=utf-8")
	public String join(HttpSession session, MemberVO vo, HttpServletRequest req, MultipartFile imgFile) {
		vo.setUser_pw(pwEncoder.encode(vo.getUser_pw()));
		if (!imgFile.isEmpty()) {
			vo.setProfile(comm.fileUpload("profile", imgFile, req));
		}
		StringBuilder msg = new StringBuilder();
		msg.append("<script>");
		if (service.member_join(vo) == 1) {
//			session.setAttribute("loginInfo", vo);
			String welcomeFile = session.getServletContext().getRealPath("resources/files/과정평가형_풀이.pdf");
			comm.sendWelcome(vo, welcomeFile);

			msg.append("alert('회원가입 완료');");
			msg.append("location='").append(req.getContextPath() + "/member/loginPage").append("';");
		} else {
			msg.append("alert('회원가입 실패');");
			msg.append("history.go(-1);");

		}
		msg.append("</script>");
		return msg.toString();
	}
}
