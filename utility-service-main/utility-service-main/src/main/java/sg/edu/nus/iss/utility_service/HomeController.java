package sg.edu.nus.iss.utility_service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public  class HomeController {
    @GetMapping("/")
    public String home() {
        return "Welcome to Shopsmart Utility Management";
    }
}

