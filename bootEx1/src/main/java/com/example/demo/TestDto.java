package com.example.demo;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*@Setter
@Getter
@ToString*/
@Data // 위의 3개를 합침
@NoArgsConstructor

public class TestDto {
	private String name;
	private String addr;
	private String hp;
}
