package kr.co.middle;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import kr.co.middle.customer.CustomerService;
import kr.co.middle.customer.CustomerVO;

@RestController // Controller + ResponseBody의 형태
@RequestMapping(value = "/customer", produces = "text/plain; charset=utf-8")
public class CustomerController {

	@Autowired
	private CustomerService service;

	@RequestMapping("/list")
	public String list(String query) {
		List<CustomerVO> list = service.customer_list(query);
		return new Gson().toJson(list);
	}

	@RequestMapping("/delete")
	public void delete(int customer_id) {
		service.customer_delete(customer_id);
	}

	@RequestMapping("/update")
	public void update(String vo) {

		service.customer_update(new Gson().fromJson(vo, CustomerVO.class));
	}

	@RequestMapping("/insert")
	public void insert(String vo) {

		service.customer_insert(new Gson().fromJson(vo, CustomerVO.class));
	}
}
