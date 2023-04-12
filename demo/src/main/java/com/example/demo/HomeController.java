package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @GetMapping("/hello")
    public @ResponseBody TestDto hello() {
        TestDto dto = new TestDto();
        dto.setName("아무개");
        dto.setAddr("강남구");
        dto.setHp("010-3333-4444");

        return dto;
    }
}
