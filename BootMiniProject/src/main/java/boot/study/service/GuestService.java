package boot.study.service;

import boot.study.dto.GuestDto;
import boot.study.dto.GuestPhotoDto;
import boot.study.mapper.GuestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GuestService implements GuestServiceInter {

    @Autowired
    GuestMapper guestMapper;

    @Override
    public void insertGuest(GuestDto dto) {
        guestMapper.insertGuest(dto);
    }

    @Override
    public void insertPhoto(GuestPhotoDto dto) {
        guestMapper.insertPhoto(dto);
    }

    @Override
    public List<GuestDto> getAllGuest() {
        return guestMapper.getAllGuest();
    }

    @Override
    public List<GuestPhotoDto> getPhotos(int guest_idx) {
        return guestMapper.getPhotos(guest_idx);
    }
}
