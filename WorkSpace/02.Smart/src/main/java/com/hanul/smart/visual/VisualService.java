package com.hanul.smart.visual;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class VisualService {

	@Autowired
	@Qualifier("hr")
	private SqlSession sql;

	public List<HashMap<String, Object>> department() {

		return sql.selectList("visual.dept_list");
	}

	public List<HashMap<String, Object>> hirement_year(HashMap<String, Object> map) {

		return sql.selectList("visual.hire_y", map);
	}
	public List<HashMap<String, Object>> hirement_month() {

		return sql.selectList("visual.hire_m");
	}
	public List<HashMap<String, Object>> hirement_top3_year(HashMap<String, Object> map) {
		
		return sql.selectList("visual.hire_top3_y", map);
	}
	public List<HashMap<String, Object>> hirement_top3_month() {
		
		return sql.selectList("visual.hire_top3_m");
	}

}
