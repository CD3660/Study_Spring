package com.hanul.smart;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hanul.smart.hr.HrService;

@Controller
@RequestMapping("/hr")
public class HrController {

	@Autowired
	HrService service;

	@RequestMapping("/list")
	public String list(Model model, HttpSession session) {
		session.setAttribute("category", "hr");

		model.addAttribute("list", service.list());

		return "hr/list";
	}

	@RequestMapping("/info")
	public String info(Model model, HttpSession session, int employee_id) {

		model.addAttribute("vo", service.info(employee_id));

		return "hr/info";
	}

	@RequestMapping("/updatePage")
	public String updatePage(Model model, HttpSession session, int employee_id) {

		model.addAttribute("vo", service.info(employee_id));
		
		return "hr/update";
	}
}
