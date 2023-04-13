package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"study.*"})
public class BootEx1Application {

	public static void main(String[] args) {
		SpringApplication.run(BootEx1Application.class, args);
	}

}
