package app.code.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.code.model.laptop.Brand;
import app.code.service.laptop.BrandService;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

@Controller
public class BrandController {
     @Autowired
     private BrandService brandService;

     @PostMapping("/admin/brand")
     public String postCreate(Model model, @RequestParam(name = "name") String name) {
          try {
               Brand brand = new Brand();
               brand.setName(name);
               brandService.create(brand);
               model.addAttribute("name", name);
               return "redirect:/admin/brands";
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return getReadAll(model, "");
     }

     @PutMapping("/admin/brand/update/{id}")
     public ResponseEntity<?> postRestUpdate(@RequestBody Brand brand) throws Exception {
          try {
               Brand temp = brandService.findById(brand.getId());
               temp.setName(brand.getName());
               brandService.update(temp);
               return returnSuccess(brand, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/brands")
     public String getReadAll(Model model,
               @RequestParam(required = false, defaultValue = "") String keyword) {
          try {
               model.addAttribute("keyword", keyword);
               model.addAttribute("brands", brandService.findByNameLike(keyword));
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "laptop/brand-readall";
     }

     @GetMapping("/admin/brand/delete/{id}")
     public String getDelete(Model model,
               @PathVariable(name = "id") Integer id) {
          try {
               brandService.delete(id);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "redirect:/admin/brands";

     }
}
