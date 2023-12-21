package com.hanul.smart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hanul.smart.customer.CustomerService;
import com.hanul.smart.customer.CustomerServiceImpl;
import com.hanul.smart.customer.CustomerVO;

@Controller
public class CustomerController {

	@Autowired private CustomerServiceImpl service;
	
	@RequestMapping("/list.cu")
	public String list(Model model) {
		List<CustomerVO> list = service.customer_list();
		model.addAttribute("list", list);
		return "customer/list";
	}
}
