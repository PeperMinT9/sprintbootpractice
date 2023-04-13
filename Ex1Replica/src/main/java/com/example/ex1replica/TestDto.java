package com.example.ex1replica;

import lombok.Data;
import lombok.NoArgsConstructor;

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
