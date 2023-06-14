package app.code.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

import app.code.service.user.StoreService;
import app.code.model.user.Role;
import app.code.model.user.Store;

@Controller
public class StoreController {
     @Autowired
     private StoreService storeService;

     @PostMapping("/admin/store")
     public ResponseEntity<?> postRestCreate(@RequestBody Store store) throws Exception {
          try {
               store.setRole(new Role(2));
               storeService.create(store);
               return returnSuccess(store, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/store")
     public String getCreate(Model model) {
          try {

          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "store/store-create";
     }

     @PutMapping("/admin/store/update/{id}")
     public ResponseEntity<?> postRestUpdate(@RequestBody Store store) throws Exception {
          try {
               store.setRole(new Role(2));
               storeService.update(store);
               return returnSuccess(store, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/stores")
     public String getReadAll(Model model,
               @RequestParam(required = false, defaultValue = "") String keyword) {
          try {
               Store store = new Store();
               store.setKeyword(keyword);
               store.setRoleAdmin(1);
               model.addAttribute("keyword", keyword);
               model.addAttribute("stores", storeService.search(store).getElements());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "store/store-readall";
     }

     @GetMapping("/admin/store/delete/{id}")
     public String getDelete(Model model,
               @PathVariable(name = "id") Integer id) {
          try {
               storeService.delete(id);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "redirect:/admin/stores";

     }

}
