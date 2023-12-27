package com.hanul.smart;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanul.smart.member.MemberService;
import com.hanul.smart.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

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
}
