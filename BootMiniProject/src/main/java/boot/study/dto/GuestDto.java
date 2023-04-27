package boot.study.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;
import java.util.List;

@Data
@Alias("GuestDto")
public class GuestDto {
    private int guest_idx;
    private String nickname;
    private String content;
    private List<GuestPhotoDto> photoList;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
    private Timestamp writeday;
}
