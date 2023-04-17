package boot.study.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/guest")
public class GuestController {
    @GetMapping("/list")
    public String list()
    {
        return "/sub/guest/guest_list";
    }
}
