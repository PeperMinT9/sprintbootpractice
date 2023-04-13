package com.example.ex1replica;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

@SpringBootApplication
@ComponentScan({"study.*"})
public class Ex1ReplicaApplication {

    public static void main(String[] args) {

        SpringApplication.run(Ex1ReplicaApplication.class, args);
    }

}
