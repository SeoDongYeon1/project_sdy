package com.KoreaIT.sdy.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.sdy.demo.service.ClubService;
import com.KoreaIT.sdy.demo.vo.Club;

@Controller
public class UsrHomeController {
	@Autowired
	ClubService clubService;
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		List<Club> clubs = clubService.getClubs();
		
		model.addAttribute("clubs", clubs);
		
		return "usr/home/main";
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
}
