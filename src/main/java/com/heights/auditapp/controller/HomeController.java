package com.heights.auditapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashboard")

public class HomeController {

    @GetMapping({"", "index", "/"})
    public String home(){
        return "index";
    }
}
