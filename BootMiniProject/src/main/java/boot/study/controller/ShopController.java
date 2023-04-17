package boot.study.controller;

import boot.study.mapper.ShopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    ShopMapper shopMapper;
    @GetMapping("/list")
    public String list(Model model) {
        // 총 상품갯수 출력
        int totalCount = shopMapper.getTotalCount();
        // model에 저장
        model.addAttribute("totalCount", totalCount);

        return "/main/shop/shop_list";
    }
}
