package com.hanul.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanul.web.member.MemberVO;

@Controller
public class MemberController {
	
	@RequestMapping("/member")
	public String member() {
		
		
		return "member/join";
	}
	
	@RequestMapping("/joinRequest")
	public String join(HttpServletRequest req, Model model) {
		model.addAttribute("name", req.getParameter("name"));
		model.addAttribute("gender", req.getParameter("gender"));
		model.addAttribute("email", req.getParameter("email"));
		model.addAttribute("age", Integer.valueOf(req.getParameter("age")));
		model.addAttribute("method", "HttpServletRequest방식");
		return "member/info";
	}
	
	
	@RequestMapping("/joinParam")
	public String join(Model model, @RequestParam String name, String gender, @RequestParam("email") String mail, int age) {
		model.addAttribute("method", "@RequestParam 방식");
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("email", mail);
		model.addAttribute("age", age);
		
		return "member/info";
	}
	
	@RequestMapping("/joinData")
	public String join(Model model, MemberVO vo) {
		model.addAttribute("method", "DataObject 방식");
		model.addAttribute("vo", vo);
		
		return "member/info";
	}
}
