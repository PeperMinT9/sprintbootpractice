package boot.study.controller;

import boot.study.dto.BoardDto;
import boot.study.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/board/")
public class BoardController {

    @Autowired
    private BoardService boardService;

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

        return "/main/board/boardform";
    }
}
