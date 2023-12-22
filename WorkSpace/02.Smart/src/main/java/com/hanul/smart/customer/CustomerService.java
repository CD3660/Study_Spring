package com.hanul.smart.customer;

import java.util.List;

public interface CustomerService {
	//crud

	int customer_register(CustomerVO vo);
	List<CustomerVO> customer_list(String name);
	CustomerVO customer_info(int id);
	int customer_update(CustomerVO vo);
	int customer_delete(int id);
	
}
