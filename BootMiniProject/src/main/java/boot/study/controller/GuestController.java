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

//    @PostMapping("/insert")
//    @ResponseBody public void insetGuest(GuestDto dto) {
//        // 방명록 데이터부터 db에 저장
//        guestService.insertGuest(dto);
//        System.out.println("guest_idx: " + dto.getGuest_idx());
//
//        for(String photoname: photoNames) {
//            // 업로드한 파일명을 db에 저장
//            GuestPhotoDto pdto = new GuestPhotoDto();
//            pdto.setGuest_idx(dto.getGuest_idx());
//            pdto.setPhotoname(photoname);
//            guestService.insertPhoto(pdto);
//        }
//    }

    // insert 할때 파일도 업로드하기
    @PostMapping("/insert")
    @ResponseBody public void insetGuest(GuestDto dto, List<MultipartFile> upload) {
        // 방명록 데이터부터 db에 저장

        // ajax 로 호출할 겨웅 사진을 업로드 안하면 upload값이 null값이 넘어온다
        System.out.println("content:" + dto.getContent());

        // 방명록 데이터 db에 저장
        guestService.insertGuest(dto);
        System.out.println("guest_idx: " + dto.getGuest_idx());

        if(upload != null) {
            System.out.println("size: " + upload.size());

            for(MultipartFile file: upload) {
                // 스토리지에 업로드하기
                String photoname = storageService.uploadFile(bucketName, "guest", file);
                // 업로드한 파일명을 db에 저장
                GuestPhotoDto pdto = new GuestPhotoDto();
                pdto.setGuest_idx(dto.getGuest_idx());
                pdto.setPhotoname(photoname);
                guestService.insertPhoto(pdto);
            }
        }
    }

    @GetMapping("/alist")
    @ResponseBody public List<GuestDto> alist() {
        List<GuestDto> list = guestService.getAllGuest();
        // 각 방명록글에 등록한 사진들을 가져온다
        for(GuestDto dto: list) {
            int gidx = dto.getGuest_idx();
            List<GuestPhotoDto> plist = guestService.getPhotos(gidx);
            dto.setPhotoList(plist);
        }
        return list;
    }
}
