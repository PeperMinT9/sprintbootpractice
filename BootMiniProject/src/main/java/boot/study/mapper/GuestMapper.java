package boot.study.mapper;

import boot.study.dto.GuestDto;
import boot.study.dto.GuestPhotoDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface GuestMapper {
    public void insertGuest(GuestDto dto);
    public void insertPhoto(GuestPhotoDto dto);
    public List<GuestDto> getAllGuest();
    public List<GuestPhotoDto> getPhotos(int guest_idx);
}
