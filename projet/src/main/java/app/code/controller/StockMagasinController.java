package app.code.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.code.service.laptop.BrandService;
import app.code.service.laptop.ProcessorService;
import app.code.service.laptop.RomTypeService;
import app.code.service.laptop.ScreenTypeService;
import app.code.service.stock.StockService;
import app.util.general.search.SearchResult;
import app.code.model.stock.StockFilter;
import app.code.model.stock.VStockMagasin;
import app.code.model.user.Users;

@Controller
public class StockMagasinController {

     @Autowired
     private BrandService brandService;
     @Autowired
     private StockService stockService;
     @Autowired
     private ProcessorService processorService;
     @Autowired
     private ScreenTypeService screenTypeService;
     @Autowired
     private RomTypeService romTypeService;

     @GetMapping("/store/stocks")
     public String getReadAll(Model model, @RequestParam(defaultValue = "1", required = false) int page,
               @RequestParam(required = false) String keyword, @RequestParam(required = false) Integer[] brand_id,
               @RequestParam(required = false) Integer[] processor_id,
               @RequestParam(required = false) Integer[] screenType,
               @RequestParam(required = false) Integer ramMin, @RequestParam(required = false) Integer ramMax,
               @RequestParam(required = false) Integer romMin, @RequestParam(required = false) Integer romMax,
               @RequestParam(required = false) Double priceMin, @RequestParam(required = false) Double priceMax,
               @RequestParam(required = false) Double screenSizeMin,
               @RequestParam(required = false) Double screenSizeMax, @RequestParam(required = false) Integer romType,
               HttpSession session) {
          try {
               model.addAttribute("brand", brandService.findAll());
               model.addAttribute("processor", processorService.findAll());

               model.addAttribute("romType", romTypeService.findAll());
               model.addAttribute("screenType", screenTypeService.findAll());
               StockFilter filter = new StockFilter();
               filter.setKeyword(keyword);
               filter.setBrand(brand_id);
               filter.setProcessor(processor_id);
               filter.setScreenType(screenType);
               filter.setRamMin(ramMin);
               filter.setRamMax(ramMax);
               filter.setRomMin(romMin);
               filter.setRomMax(romMax);
               filter.setPriceMin(priceMin);
               filter.setPriceMax(priceMax);
               filter.setScreenSizeMax(screenSizeMax);
               filter.setScreenSizeMin(screenSizeMin);
               filter.setRomType(romType);
               filter.setStoreId(((Users) session.getAttribute("store")).getStore().getId());
               SearchResult<VStockMagasin> liste = stockService.searchStockMagasin(filter, page);
               model.addAttribute("stocks",
                         liste.getElements());
               model.addAttribute("v_stock", filter);
               model.addAttribute("page", page);
               model.addAttribute("totalPage", liste.getCountPage());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "shop/stock-readall";
     }
}
