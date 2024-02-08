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
}
