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

	public List<HashMap<String, Object>> hirement_year() {

		return sql.selectList("visual.hire_y");
	}
	public List<HashMap<String, Object>> hirement_month() {

		return sql.selectList("visual.hire_m");
	}
	public Object hirement_top3_year() {
		List<HashMap<String, Object>> list = sql.selectList("visual.hire_top3_y");
		Object[] keys = list.get(0).keySet().toArray();
		Arrays.sort(keys);
		keys = Arrays.copyOfRange(keys, 0, keys.length-1);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("unit", keys);
		return map;
	}
	public Object hirement_top3_month() {
		List<HashMap<String, Object>> list = sql.selectList("visual.hire_top3_m");
		Object[] keys = list.get(0).keySet().toArray();
		Arrays.sort(keys);
		keys = Arrays.copyOfRange(keys, 0, keys.length-1);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("unit", keys);
		return map;
	}

}
