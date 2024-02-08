package com.hanul.smart;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hanul.smart.member.MemberService;
import com.hanul.smart.member.MemberVO;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired private MemberService member;
	@Autowired private BCryptPasswordEncoder pwEncoder;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
//		String user_id = "cksdud4188", user_pw = "2d01a81042fb";
//		MemberVO vo = member.member_info(user_id);
//		if(pwEncoder.matches(user_pw, vo.getUser_pw())) {
//			session.setAttribute("loginInfo", vo);
//		}
		
		
		session.removeAttribute("category");
		
		return "home";
	}
	
	@RequestMapping("/visual/list")
	public String list(HttpSession session) {
		session.setAttribute("category", "vi");
		
		return "visual/list";
	}
}
