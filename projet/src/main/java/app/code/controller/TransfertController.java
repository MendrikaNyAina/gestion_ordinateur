package app.code.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.google.gson.Gson;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

import app.code.model.laptop.Laptop;
import app.code.model.stock.Transfert;
import app.code.model.user.Users;
import app.code.service.laptop.LaptopService;
import app.code.service.stock.TransfertService;
import app.code.service.user.StoreService;

@Controller
public class TransfertController {
     @Autowired
     private TransfertService transfertService;
     @Autowired
     private StoreService storeService;
     @Autowired
     private LaptopService laptopService;
     @Autowired
     private Gson gson;

     @GetMapping("/admin/stock/transferer")
     public String transferer(Model model) {
          try {
               List<Laptop> laptops = laptopService.findAll();
               model.addAttribute("laptopsJson", gson.toJson(laptops));
               model.addAttribute("laptops", laptops);
               // System.out.println(stockService.findAll().get(0).getId());
               model.addAttribute("stores", storeService.getStoreShop().getElements());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
          }
          return "stock/stock-transferer";
     }

     @PostMapping("/admin/stock/transferer")
     public ResponseEntity<?> postTransferer(@RequestBody List<Transfert> liste, HttpSession session)
               throws Exception {
          try {
               return returnSuccess(transfertService.transferer(liste, (Users) session.getAttribute("admin"), 1),
                         HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @PostMapping("/store/send-back")
     public ResponseEntity<?> postRestSendBack(@RequestBody List<Transfert> receipt, HttpSession session)
               throws Exception {
          try {

               transfertService.transferer(receipt, (Users) session.getAttribute("store"), 2);
               return returnSuccess(receipt, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/store/send-back")
     public String getSendBack(Model model) {
          try {
               List<Laptop> laptops = laptopService.findAll();
               model.addAttribute("laptopsJson", gson.toJson(laptops));
               model.addAttribute("laptops", laptops);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
          }
          return "shop/sendback-create";
     }
}
