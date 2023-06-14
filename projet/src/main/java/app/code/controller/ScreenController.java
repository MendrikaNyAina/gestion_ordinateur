package app.code.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.code.model.laptop.ScreenType;
import app.code.service.laptop.ScreenTypeService;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

@Controller
public class ScreenController {
     @Autowired
     private ScreenTypeService screenTypeService;

     @PostMapping("/admin/screen")
     public String postCreate(Model model, @RequestParam(name = "name") String name) {
          try {
               ScreenType screenType = new ScreenType();
               screenType.setName(name);
               screenTypeService.create(screenType);
               model.addAttribute("name", name);
               return "redirect:/admin/screens";
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return getReadAll(model, "");
     }

     @PutMapping("/admin/screen/update/{id}")
     public ResponseEntity<?> postRestUpdate(@RequestBody ScreenType screenType) throws Exception {
          try {
               ScreenType temp = screenTypeService.findById(screenType.getId());
               temp.setName(screenType.getName());
               screenTypeService.update(temp);
               return returnSuccess(screenType, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/screens")
     public String getReadAll(Model model,
               @RequestParam(required = false, defaultValue = "") String keyword) {
          try {
               model.addAttribute("keyword", keyword);
               model.addAttribute("screens", screenTypeService.findByNameLike(keyword));
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "laptop/screen-readall";
     }

     @GetMapping("/admin/screen/delete/{id}")
     public String getDelete(Model model,
               @PathVariable(name = "id") Integer id) {
          try {
               screenTypeService.delete(id);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "redirect:/admin/screens";

     }
}
