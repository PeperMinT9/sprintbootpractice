package boot.study.dto;


import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("ShopDto")
public class ShopDto {
    private int num;
    private String sangpum;
    private String color;
    private int price;
    private int cnt;
    private String photo;
    private Timestamp ipgoday;


}
