package boot.study.controller;

import boot.study.dto.BoardDto;
import boot.study.service.BoardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board/")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="bit701-bucket-29";
    // private String bucketName="bit701-bucket-56";

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        int totalCount = boardService.getTotalCount();
        int totalPage = -1;
        int perPage = 10;
        int perBlock = 5;
        int startNum = -1;
        int startPage = -1;
        int endPage = -1;
        int no = -1;

        totalPage = totalCount / perPage + (totalCount % perPage == 0? 0 : 1);
        startPage = (currentPage - 1)/perBlock * perBlock + 1;
        endPage = startPage + perBlock - 1;
        if(endPage > totalPage)
            endPage = totalPage;

        startNum = (currentPage - 1) * perPage;
        no = totalCount - startNum;

        List<BoardDto> list = boardService.getPagingList(startNum, perPage);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("list", list);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("no", no);

        return "/main/board/board_list";
    }

    // 폼이 원글폼일수도 있고 답글폼일수도 있다
    @GetMapping("/writeform")
    public String form(
            @RequestParam(defaultValue = "1") int currentPage,
            @RequestParam(defaultValue = "0") int num,
            @RequestParam(defaultValue = "0") int ref,
            @RequestParam(defaultValue = "0") int step,
            @RequestParam(defaultValue = "0") int depth,
            Model model) {
        // 답글일 경우 제목은 나오게 하기 위해서 제목을 구한다
        String subject = "";
        if(num > 0) {
            subject = boardService.getData(num).getSubject();
        }

        model.addAttribute("currentPage", currentPage);
        model.addAttribute("num", num);
        model.addAttribute("ref", ref);
        model.addAttribute("step", step);
        model.addAttribute("depth", depth);
        model.addAttribute("subject", subject);

        return "/main/board/board_form";
    }

    @PostMapping("/insert")
    public String insert(BoardDto dto, MultipartFile upload) {
        String filename = "";
        // 업로드를 한경우에만 버킷에 이미지를 저장한다
        if(!upload.getOriginalFilename().equals("")) {
            filename = storageService.uploadFile(bucketName, "board", upload);
        }

        // dto에 파일명 저장
        dto.setFilename(filename);

        boardService.insertBoard(dto);

        return "redirect:list";
    }

    @GetMapping("/content")
    public String content(int num, int currentPage, Model model) {
        // 조회수 증가
        boardService.updateReadcount(num);

        // dto 얻기
        BoardDto dto = boardService.getData(num);

        // model 저장
        model.addAttribute("dto", dto);
        model.addAttribute("currentPage", currentPage);

        return "/main/board/content";
    }

    @PostMapping("/delete")
    @ResponseBody public Map<String, String> delete(int num, String pass) {
        Map<String, String> map = new HashMap<>();
        // 비번이 맞을경우 map에 result->success 를 넣고 버켓의 사진 지우고 db의 글 지우고
        // 틀릴경우 map 에 result->fail
        boolean b = boardService.isEqualPass(num, pass);
        if(b) {
            map.put("result", "success");
            //db 삭제전에 저장된 이미지를 버켓에서 지운다
            String filename = boardService.getData(num).getFilename();
            storageService.deleteFile(bucketName, "board", filename);
            //db 삭제
            boardService.deleteBoard(num);
        }else {
            map.put("result", "fail");
        }
        return map;
    }

    @GetMapping("/updatepass")
    @ResponseBody public Map<String, String> updatepass(int num, String pass) {
        Map<String, String> map = new HashMap<>();
        boolean b = boardService.isEqualPass(num, pass);
        if(b) {
            map.put("result", "success");
        }else {
            map.put("result", "fail");
        }
        return map;
    }

    @GetMapping("/updateform")
    public String updateform(int num,int currentPage,Model model) {
        BoardDto dto = boardService.getData(num);

        model.addAttribute("dto", dto);
        model.addAttribute("currentPage", currentPage);

        return "/main/board/updateform";
    }

    @PostMapping("/update")
    public String update(BoardDto dto,MultipartFile upload,int currentPage) {
        String filename = "";
        //사진선택을 한경우에는 기존 사진을 버켓에서 지우고 다시 업로드를 한다
        if(!upload.getOriginalFilename().equals("")) {
            //기존 파일명 알아내기
            filename = boardService.getData(dto.getNum()).getFilename();
            //버켓에서 삭제
            storageService.deleteFile(bucketName, "board", filename);

            //다시 업로드후 업로드한 파일명 얻기
            filename = storageService.uploadFile(bucketName, "board", upload);
        }
        dto.setFilename(filename);

        //수정
        boardService.updateBoard(dto);

        //수정후 내용보기로 이동한다
        return "redirect:./content?num=" + dto.getNum() + "&currentPage=" + currentPage;
    }
}
