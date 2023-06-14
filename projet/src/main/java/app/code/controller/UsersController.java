package app.code.controller;

import java.sql.Date;
import javax.servlet.http.HttpSession;

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

//import app.code.model.user.filter.UsersFilter;
import app.code.service.user.UsersService;
import app.util.general.search.SearchResult;
import app.code.model.user.Store;
import app.code.model.user.Users;
import app.code.service.user.StoreService;

@Controller
public class UsersController {
     @Autowired
     private UsersService usersService;

     @Autowired
     private StoreService storeService;

     @GetMapping("/")
     public String index() {
          return "redirect:admin/login";
     }

     @GetMapping("/admin/login")
     public String loginAdmin(HttpSession session) {
          session.removeAttribute("admin");
          session.removeAttribute("store");
          return "login/login_admin";
     }

     @GetMapping("/admin/logout")
     public String logoutAdmin(HttpSession session) {
          session.removeAttribute("admin");
          return "redirect:/admin/login";
     }

     @GetMapping("/store/login")
     public String loginStore(HttpSession session) {
          session.removeAttribute("admin");
          session.removeAttribute("store");
          return "login/login_store";
     }

     @GetMapping("/store/logout")
     public String logoutStore(HttpSession session) {
          session.removeAttribute("store");
          return "redirect:/store/login";
     }

     @PostMapping("/admin/login")
     public ResponseEntity<?> postLoginAdmin(@RequestBody Users user, HttpSession session) throws Exception {
          try {
               user = usersService.loginAdmin(user.getUsername(), user.getPassword());
               session.setAttribute("admin", user);
               return ResponseEntity.ok(user);
          } catch (Exception e) {
               e.printStackTrace();
               return ResponseEntity.badRequest().body(e.getMessage());
          }
     }

     @PostMapping("/store/login")
     public ResponseEntity<?> postLoginStore(@RequestBody Users user, HttpSession session) throws Exception {
          try {
               user = usersService.loginStore(user.getUsername(), user.getPassword());
               session.setAttribute("store", user);
               return ResponseEntity.ok(user);
          } catch (Exception e) {
               e.printStackTrace();
               return ResponseEntity.badRequest().body(e.getMessage());
          }
     }

     @PostMapping("/admin/store/user")
     public ResponseEntity<?> postRestCreate(@RequestBody Users user) throws Exception {
          try {
               usersService.create(user);
               return returnSuccess(user, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               return ResponseEntity.badRequest().body(e.getMessage());
          }
     }

     @PutMapping("/admin/store/user/{id}/affecter/store/{store_id}")
     public ResponseEntity<?> putRestUpdate(@PathVariable Integer id, @PathVariable(name = "store_id") Integer storeId)
               throws Exception {
          try {
               Users user = usersService.findById(id);
               user.setStore(new Store(storeId));
               usersService.update(user);
               return returnSuccess(user, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               return ResponseEntity.badRequest().body(e.getMessage());
          }
     }

     @PutMapping("/admin/store/user/{id}/desaffecter")
     public ResponseEntity<?> putRestUpdatedesaffecter(@PathVariable Integer id)
               throws Exception {
          try {
               Users user = usersService.findById(id);
               user.setStore(null);
               usersService.update(user);
               return returnSuccess(user, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               return ResponseEntity.badRequest().body(e.getMessage());
          }
     }

     @GetMapping("/admin/store/user")
     public String getCreate(Model model, HttpSession session,
               @RequestParam(required = false, defaultValue = "1") int page) {
          try {
               // System.out.println(session.getAttribute("admin"));
               SearchResult<Users> result = usersService.findAllStoreUser(page);
               model.addAttribute("stores", storeService.findAll());
               model.addAttribute("users", result.getElements());
               model.addAttribute("page", page);
               model.addAttribute("totalPage", result.getCountPage());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "user/user-create";
     }

}
