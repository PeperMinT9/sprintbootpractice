package boot.study.controller;

import boot.study.dto.GuestDto;
import boot.study.dto.GuestPhotoDto;
import boot.study.service.GuestService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/guest")
public class GuestController {
    @Autowired
    GuestService guestService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="bit701-bucket-29";

    List<MultipartFile> upload;

    List<String> photoNames = new ArrayList<>();

    @GetMapping("/list")
    public String list() {
        return "/sub/guest/guest_list";
    }

    @PostMapping("/upload")
    @ResponseBody public void upload(List<MultipartFile> upload) {
        System.out.println("size: " + upload.size());
        System.out.println("filename: " + upload.get(0).getOriginalFilename());

        photoNames.clear();
        for(MultipartFile file:upload) {
            // 스토리지 업로드
            String photoname = storageService.uploadFile(bucketName, "guest", file);
            System.out.println("name: " + photoname);
            // 업로드한 파일명을 db에 저장
            photoNames.add(photoname);
        }
    }

    @PostMapping("/insert")
    @ResponseBody public void insetGuest(GuestDto dto) {
        // 방명록 데이터부터 db에 저장
        guestService.insertGuest(dto);
        System.out.println("guest_idx: " + dto.getGuest_idx());

        for(String photoname: photoNames) {
            // 업로드한 파일명을 db에 저장
            GuestPhotoDto pdto = new GuestPhotoDto();
            pdto.setGuest_idx(dto.getGuest_idx());
            pdto.setPhotoname(photoname);
            guestService.insertPhoto(pdto);
        }
    }
}
