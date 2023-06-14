package app.code.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

import app.code.model.stock.Receipt;
import app.code.model.user.Users;
import app.code.service.stock.ReceiptService;
//import app.code.model.stock.filter.TransfertFilter;
import app.code.service.stock.TransfertService;

@Controller
public class ReceiptController {
     @Autowired
     private TransfertService transfertService;
     @Autowired
     private ReceiptService receiptService;

     @GetMapping("/admin/stock/receipt")
     public String transferer(Model model, @RequestParam(name = "date", defaultValue = "") String date,
               HttpSession session) {
          try {
               if (date.equals(""))
                    date = Date.valueOf(LocalDate.now()).toString();
               Users store = (Users) session.getAttribute("admin");
               model.addAttribute("date", date);
               model.addAttribute("transferts",
                         transfertService.findByDateTransfertAndType(Date.valueOf(date), 2));
               //

          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
          }
          return "stock/stock-reception";
     }

     @PostMapping("/admin/stock/receipt")
     public ResponseEntity<?> postTransferer(@RequestBody List<Receipt> liste, HttpSession session)
               throws Exception {
          try {
               receiptService.receptionner(liste, (Users) session.getAttribute("admin"));
               return returnSuccess(liste, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @PostMapping("/store/receipt")
     public ResponseEntity<?> postRestCreate(@RequestBody List<Receipt> receipt, HttpSession session) throws Exception {
          try {
               receiptService.receptionner(receipt, (Users) session.getAttribute("store"));
               return returnSuccess(receipt, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/store/receipt")
     public String getCreate(Model model,
               @RequestParam(name = "date", defaultValue = "") String date, HttpSession session) {
          try {
               if (date.equals(""))
                    date = Date.valueOf(LocalDate.now()).toString();
               Users store = (Users) session.getAttribute("store");
               model.addAttribute("date", date);
               model.addAttribute("transferts",
                         transfertService.findByDateAndStoreId(Date.valueOf(date), store.getStore().getId()));
               //

          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
          }
          return "shop/receipt-form";
     }
}
