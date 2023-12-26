package com.hanul.smart.hr;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class HrVO {
	private String first_name, last_name, name, email, phone_number, job_title, department_name, job_id, manager_name;
	private int employee_id, salary, manager_id, department_id;
	private double commission_pct;
	private Date hire_date;
}
