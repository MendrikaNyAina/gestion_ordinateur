package app.code.controller;

import java.io.PrintWriter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TestController {
     @GetMapping("/test")
     public String test(Model model) {
          model.addAttribute("message", "test");
          return "test";
     }

     @GetMapping("/titre")
     public void titre(PrintWriter out, @RequestParam String objson) {
          // out.print("document.querySelector("#test").innerHTML='<tt:H1Test titre=\"the
          // macarena\" objson="{\"titre\":\"rosemary\"}" />';")
     }

}
