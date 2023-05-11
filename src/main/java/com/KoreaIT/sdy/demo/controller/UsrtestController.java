package com.KoreaIT.sdy.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrtestController {
	@RequestMapping("/usr/test/test")
	public String showMain() {
		return "usr/test/test";
	}
}
