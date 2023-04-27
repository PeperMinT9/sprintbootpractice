package boot.study.controller;

import boot.study.dto.ShopDto;
import boot.study.mapper.ShopMapper;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    ShopMapper shopMapper;

    // 버킷이름 설정
     private String bucketName="bit701-bucket-29";
    // private String bucketName="bit701-bucket-56";

    @Autowired
    private NcpObjectStorageService storageService;

    @GetMapping("/list")
    public String list(Model model) {
        // 총 상품갯수 출력
        int totalCount = shopMapper.getTotalCount();
        // 전체데이터 가져오기
        List<ShopDto> list = shopMapper.getAllSangpums();

        // model에 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);
        model.addAttribute("selector", '1');

        return "/main/shop/shop_list";
    }

    @GetMapping("/list2")
    public String list2(Model model) {
        // 총 상품갯수 출력
        int totalCount = shopMapper.getTotalCount();
        // 전체데이터 가져오기
        List<ShopDto> list = shopMapper.getAllSangpums();

        // model에 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);
        model.addAttribute("selector", '2');

        return "/main/shop/shop_list2";
    }

    @GetMapping("/detail")
    public String detail(Model model, int num, char selector) {
        // 전체데이터 가져오기
        ShopDto dto = shopMapper.getOneSangpums(num);

        // model에 저장
        model.addAttribute("dto", dto);
        model.addAttribute("selector", selector);

        return "/main/shop/shop_detail";
    }

    @GetMapping("/shopform")
    public String form() {
        return "/main/shop/shopform";
    }

    @PostMapping("/insert")
    public String insert(ShopDto dto, MultipartFile upload) {
        // 네이버 클라우드의 버켓에 사진 업로드하기
        String photo = storageService.uploadFile(bucketName, "shop", upload);
        // 반환된 암호화된 파일명을 dto에 넣기
        dto.setPhoto(photo);

        // db insert
        shopMapper.insertShop(dto);

        return "redirect:list";
    }

    @PostMapping("/photochange")
    @ResponseBody public String changePhoto(MultipartFile upload, int num) {
        // s3 스토리지에 업로드된 기존 파일 지우기
        String fileName = shopMapper.getOneSangpums(num).getPhoto();
        storageService.deleteFile(bucketName, "shop", fileName);

        // 네이버 클라우드의 버켓에 사진 업로드하기
        String photo = storageService.uploadFile(bucketName, "shop", upload);
        Map<String, Object> map = new HashMap<>();
        map.put("photo", photo);
        map.put("num", num);

        shopMapper.updatePhoto(map);
        //System.out.println(photo);
        return photo; // 업로드된 파일명 반환
    }

    @GetMapping("/update")
    @ResponseBody public void changeShop(ShopDto dto) {
        System.out.println("dto.num=" + dto.toString());
        shopMapper.updateShop(dto);
    }

    @GetMapping("/delete")
    public String deleteShop(int num) {
        // s3 스토리지에 업로드된 기존 파일 지우기
        String fileName = shopMapper.getOneSangpums(num).getPhoto();
        storageService.deleteFile(bucketName, "shop", fileName);

        // db삭제
        shopMapper.deleteShop(num);

        return "redirect:list";
    }
}
