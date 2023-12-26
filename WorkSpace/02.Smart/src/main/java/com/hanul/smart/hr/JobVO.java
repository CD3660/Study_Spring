package com.hanul.smart.hr;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class JobVO {
	private String job_id, job_title;
	private int min_salary, max_salary;
}
