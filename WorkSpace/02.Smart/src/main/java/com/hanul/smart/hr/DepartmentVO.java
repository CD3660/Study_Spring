package com.hanul.smart.hr;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DepartmentVO {
	private String department_name;
	private int department_id, manager_id, location_id;
}
