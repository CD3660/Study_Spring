package com.hanul.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
	
	
	@RequestMapping("/first")
	public String first(Model model) {
		
		model.addAttribute("today", new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date()));
		model.addAttribute("type", "Model");
		return "index";
	}
	
	@RequestMapping("/second")
	public ModelAndView second() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("now", new SimpleDateFormat("hh시 mm분 ss초").format(new Date()));  
		mv.addObject("type", "ModelAndView");  
		
		return mv;
	}
	
}
