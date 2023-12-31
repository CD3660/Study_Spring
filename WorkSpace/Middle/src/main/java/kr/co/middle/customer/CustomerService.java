package kr.co.middle.customer;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerService {
	
	@Autowired
	SqlSession sql;

	public List<CustomerVO> customer_list(String query) {
		return sql.selectList("cu.list", query);
	}

	public CustomerVO customer_info(int customer_id) {
		return sql.selectOne("cu.info", customer_id);
	}
	public int customer_insert(CustomerVO vo) {
		return sql.insert("cu.insert", vo);
	}
	
	public int customer_update(CustomerVO vo) {
		
		return sql.update("cu.update", vo);
	}
	
	public int customer_delete(int customer_id) {
		return sql.delete("cu.delete", customer_id);
	}
}
