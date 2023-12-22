package com.hanul.smart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanul.smart.customer.CustomerServiceImpl;
import com.hanul.smart.customer.CustomerVO;

@Controller
public class CustomerController {

	@Autowired
	private CustomerServiceImpl service;

	@RequestMapping("/list.cu")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "") String name) {
		session.setAttribute("category", "cu");
		List<CustomerVO> list = service.customer_list(name);
		model.addAttribute("list", list);
		model.addAttribute("name", name);

		return "customer/list";
	}

	@RequestMapping("/info.cu")
	public String info(Model model, int customer_id) {

		model.addAttribute("vo", service.customer_info(customer_id));

		return "customer/info";
	}

	@RequestMapping("/updatePage.cu")
	public String updatePage(Model model, int customer_id) {

		model.addAttribute("vo", service.customer_info(customer_id));

		return "customer/update";
	}

	@RequestMapping("/update.cu")
	public String update(Model model, CustomerVO vo) {

		model.addAttribute("vo", service.customer_update(vo));

		return "redirect:info.cu?customer_id=" + vo.getCustomer_id();
	}

	@RequestMapping("/delete.cu")
	public String delete(Model model, int customer_id) {

		model.addAttribute("vo", service.customer_delete(customer_id));

		return "redirect:list.cu";
	}

	@RequestMapping("/insertPage.cu")
	public String insertPage(Model model) {

		return "customer/insert";
	}

	@RequestMapping("/insert.cu")
	public String insert(Model model, CustomerVO vo) {
		
		service.customer_register(vo);
		
		return "redirect:list.cu";
	}
}
