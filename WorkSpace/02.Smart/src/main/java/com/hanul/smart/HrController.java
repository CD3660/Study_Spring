package com.hanul.smart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanul.smart.hr.HrService;
import com.hanul.smart.hr.HrVO;

@Controller
@RequestMapping("/hr")
public class HrController {

	@Autowired
	HrService service;

	@RequestMapping("/list")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "") String find) {
		session.setAttribute("category", "hr");

		model.addAttribute("list", service.list(find));
		model.addAttribute("find", find);
		return "hr/list";
	}

	@RequestMapping("/info")
	public String info(Model model, HttpSession session, int employee_id) {
		
		model.addAttribute("vo", service.info(employee_id));

		return "hr/info";
	}
	
	@RequestMapping("/delete")
	public String delete(Model model, HttpSession session, String employee_id) {
		service.delete(employee_id);
		

		return "redirect:/hr/list";
	}

	@RequestMapping("/updatePage")
	public String updatePage(Model model, HttpSession session, int employee_id) {

		model.addAttribute("vo", service.info(employee_id));
		model.addAttribute("department_list", service.hr_department_list());
		model.addAttribute("job_list", service.hr_job_list());
		
		return "hr/update";
	}
	@RequestMapping("/update")
	public String update(Model model, HttpSession session, HrVO vo) {
		service.update(vo);
		

		return "redirect:/hr/info?employee_id="+vo.getEmployee_id();
	}
	
	@RequestMapping("/insertPage")
	public String insertPage(Model model, HttpSession session) {
		model.addAttribute("department_list", service.hr_department_list());
		model.addAttribute("job_list", service.hr_job_list());
		model.addAttribute("manager", service.manager());
		
		
		return "hr/insert";
	}
	@RequestMapping("/insert")
	public String insert(Model model, HttpSession session, HrVO vo) {
		service.insert(vo);

		return "redirect:/hr/list";
	}
}
