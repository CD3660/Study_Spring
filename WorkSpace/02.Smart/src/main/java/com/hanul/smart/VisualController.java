package com.hanul.smart;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hanul.smart.visual.VisualService;

@RestController
@RequestMapping("/visual")
public class VisualController {

	@Autowired
	VisualService service;

	@RequestMapping("/department")
	public List<HashMap<String, Object>> department() {

		return service.department();
	}
	@RequestMapping("/hirement/year")
	public List<HashMap<String, Object>> hirement_year() {

		return service.hirement_year();
	}
	@RequestMapping("/hirement/month")
	public List<HashMap<String, Object>> hirement_month() {

		return service.hirement_month();
	}
	@RequestMapping("/hirement/top3/year")
	public Object hirement_top3_year() {

		return service.hirement_top3_year();
	}
	@RequestMapping("/hirement/top3/month")
	public Object hirement_top3_month() {

		return service.hirement_top3_month();
	}
}
