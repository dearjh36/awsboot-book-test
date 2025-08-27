package org.awsboot.web;

import lombok.RequiredArgsConstructor;
import org.awsboot.config.auth.LoginUser;
import org.awsboot.config.auth.dto.GoogleUser;
import org.awsboot.config.auth.dto.SessionUser;
import org.awsboot.service.PostsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Controller
public class IndexController {

    private final PostsService postsService;

    @GetMapping("/")
    public String index(Model model, @LoginUser SessionUser user){

        model.addAttribute("posts", postsService.findAllDesc());
        if (user != null){
            model.addAttribute("userName", user.getName());
        }

        return "index";
    }
}
