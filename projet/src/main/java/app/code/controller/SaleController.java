package app.code.controller;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import com.google.gson.Gson;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

import app.code.service.laptop.LaptopService;
//import app.code.model.sale.filter.SaleFilter;
import app.code.service.sale.SaleService;
import app.code.service.sale.VSaleService;
import app.code.model.laptop.Laptop;
import app.code.model.sale.Sale;
import app.code.model.sale.VSale;
import app.util.general.search.SearchResult;
import app.code.model.user.Users;

@Controller
public class SaleController {
     @Autowired
     private SaleService saleService;
     @Autowired
     private LaptopService laptopService;
     @Autowired
     private Gson gson;
     @Autowired
     private VSaleService vsaleService;

     @GetMapping("/store/sale")
     public String transferer(Model model, HttpSession session) {
          try {
               List<Laptop> laptops = laptopService.findAll();
               model.addAttribute("laptopsJson", gson.toJson(laptops));
               model.addAttribute("laptops", laptops);
               // stockFilter.setStoreId(((Users)
               // session.getAttribute("store")).getStore().getId());
               // stockService.searchStockMagasinAll(stockFilter)
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
          }
          return "sale/sale-create";
     }

     @PostMapping("/store/sale")
     public ResponseEntity<?> postTransferer(@RequestBody Sale liste, HttpSession session)
               throws Exception {
          try {
               return returnSuccess(saleService.sales(liste, (Users) session.getAttribute("store")),
                         HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/store/sales")
     public String getReadAll(Model model, @RequestParam(defaultValue = "1", required = false) int page,
               @RequestParam(required = false) String reference, @RequestParam(required = false) Double prix_min,
               @RequestParam(required = false) Double prix_max, HttpSession session) {
          try {
               VSale filter = new VSale();
               filter.setStoreId(((Users) session.getAttribute("store")).getStore().getId());
               filter.setReference(reference);
               filter.setPriceMax(prix_max);
               filter.setPriceMin(prix_min);
               SearchResult<VSale> searchResult = vsaleService.search(filter, page);
               // System.out.println(searchResult.getElements().size());
               model.addAttribute("filter", filter);
               model.addAttribute("sales", searchResult.getElements());
               model.addAttribute("totalPage", searchResult.getCountPage());
               model.addAttribute("page", page);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "sale/sale-readall";
     }
}
