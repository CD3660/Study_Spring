package com.hanul.smart;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
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

	private HashMap<String, Object> yearRange(HashMap<String, Object> map) {
		int begin = Integer.parseInt(map.get("begin").toString());
		int end = Integer.parseInt(map.get("end").toString());
		String range = "";
		for (int year = begin; year <= end; year++) {
			range += (range.isEmpty() ? "" : ",") + year + " \"" + year + "년\"";
		}
		map.put("range", range);
		return map;
	}

	@RequestMapping("/hirement/year")
	public List<HashMap<String, Object>> hirement_year(@RequestBody HashMap<String, Object> map) {

		return service.hirement_year(map);
	}

	@RequestMapping("/hirement/month")
	public List<HashMap<String, Object>> hirement_month() {

		return service.hirement_month();
	}

	@RequestMapping("/hirement/top3/year")
	public Object hirement_top3_year(@RequestBody HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = service.hirement_top3_year(yearRange(map));
		if (list.size() != 0) {
			Object[] keys = list.get(0).keySet().toArray();
			Arrays.sort(keys);
			keys = Arrays.copyOfRange(keys, 0, keys.length - 1);

			map.put("unit", keys);
		}
		map.put("list", list);
		return map;
	}

	@RequestMapping("/hirement/top3/month")
	public Object hirement_top3_month() {
		List<HashMap<String, Object>> list = service.hirement_top3_month();
		Object[] keys = list.get(0).keySet().toArray();
		Arrays.sort(keys);
		keys = Arrays.copyOfRange(keys, 0, keys.length - 1);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("unit", keys);
		return map;
	}
}
