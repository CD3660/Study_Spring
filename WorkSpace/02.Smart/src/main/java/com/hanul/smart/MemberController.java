package com.hanul.smart;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanul.smart.member.MemberService;
import com.hanul.smart.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	private MemberService service;

	@RequestMapping("/loginPage")
	public String loginPage(HttpSession session) {
		session.setAttribute("category", "login");
		
		return "default/member/login";
	}

	@ResponseBody
	@RequestMapping(value = "/login", produces = "text/html; charset=utf-8")
	public String login(HttpSession session, HttpServletRequest req, MemberVO vo) {
		
		return service.login(vo, req, session);
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
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
	@RequestMapping("/changePw")
	public String changePw(HttpSession session) {
		session.setAttribute("category", "change");
		
		return "member/changePw";
	}
	
	@ResponseBody
	@RequestMapping("/confirmPw")
	public int confirmPw(HttpSession session, String user_pw) {
		MemberVO vo = (MemberVO) session.getAttribute("loginInfo");
		if(vo==null) {
			return -1;
		} else {
			return pwEncoder.matches(user_pw, vo.getUser_pw())? 1 : 0;
		}
	}
	@ResponseBody
	@RequestMapping("/updatePw")
	public boolean updatePw(HttpSession session, String user_pw) {
		MemberVO vo = (MemberVO) session.getAttribute("loginInfo");
		vo.setUser_pw(pwEncoder.encode(user_pw));
		
		return service.member_update(vo);
		
	}
}
