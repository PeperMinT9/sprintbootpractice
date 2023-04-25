package boot.study.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("BoardDto")
public class BoardDto {
    private int num;
    private String writer;
    private String filename;
    private String subject;
    private String content;
    private String pass;
    private int readcount;
    private int ref;
    private int step;
    private int depth;
    private Timestamp datetime;

}
