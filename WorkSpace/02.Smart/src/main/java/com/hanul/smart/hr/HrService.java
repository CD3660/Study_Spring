package com.hanul.smart.hr;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class HrService {

	@Autowired @Qualifier("hr") private SqlSession sql;
	
	public List<HrVO> list(String find) {
		return sql.selectList("hr.list", find);
	}
	public List<HrVO> manager() {
		return sql.selectList("hr.manager");
	}
	public HrVO info(int employee_id) {
		return sql.selectOne("hr.info", employee_id);
	}

	public int update(HrVO vo) {
		return sql.update("hr.update", vo);
	}

	public int delete(String employee_id) {
		return sql.delete("hr.delete", employee_id);
	}

	public int insert(HrVO vo) {

		return sql.insert("hr.insert", vo);
	}
	public List<DepartmentVO> hr_department_list() {
		return sql.selectList("hr.departmentList");
	}
	public List<JobVO> hr_job_list() {
		return sql.selectList("hr.jobList");
	}

}
