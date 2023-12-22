package com.hanul.smart.hr;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class HrService {

	@Autowired @Qualifier("hr") private SqlSession sql;
	
	public List<HrVO> list() {
		return sql.selectList("hr.list");
	}
	public HrVO info(int employee_id) {
		return sql.selectOne("hr.info", employee_id);
	}

	public int update(HrVO vo) {

		return 0;
	}

	public int delete(String employee_id) {

		return 0;
	}

	public int insert(HrVO vo) {

		return 0;
	}

}
