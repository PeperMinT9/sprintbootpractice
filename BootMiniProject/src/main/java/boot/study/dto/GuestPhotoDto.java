package boot.study.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("PhotoDto")
public class GuestPhotoDto {
    private int photo_idx;
    private int guest_idx;
    private String photoname;
}
