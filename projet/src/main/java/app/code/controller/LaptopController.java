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

// import app.code.model.laptop.filter.LaptopFilter;
import app.code.service.laptop.LaptopService;
import app.code.model.laptop.Laptop;
import app.code.model.stock.StockFilter;
import app.code.service.laptop.RomTypeService;
import app.code.service.laptop.ScreenTypeService;
import app.util.general.search.SearchResult;
import app.code.service.laptop.BrandService;
import app.code.service.laptop.ProcessorService;

@Controller
public class LaptopController {
     @Autowired
     private LaptopService laptopService;

     @Autowired
     private RomTypeService romTypeService;

     @Autowired
     private ScreenTypeService screenTypeService;

     @Autowired
     private BrandService brandService;

     @Autowired
     private ProcessorService processorService;

     @PostMapping("/admin/laptop")
     public ResponseEntity<?> postRestCreate(@RequestBody Laptop laptop) throws Exception {
          try {
               laptopService.create(laptop);
               return returnSuccess(laptop, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/laptop")
     public String getCreate(Model model) {
          try {
               model.addAttribute("romTypes", romTypeService.findAll());
               model.addAttribute("screenTypes", screenTypeService.findAll());
               model.addAttribute("brands", brandService.findAll());
               model.addAttribute("processors", processorService.findAll());

          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "laptop/laptop-create";
     }

     @GetMapping("/admin/search_laptop")
     public ResponseEntity<?> searchL(@RequestParam String keyword) throws Exception {
          try {
               Laptop p = new Laptop();
               // p.setActif(null);
               p.setKeyword(keyword);
               return returnSuccess(laptopService.search(p).getElements(), HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/laptops")
     public String getReadAll(Model model, @RequestParam(defaultValue = "1", required = false) int page,
               @RequestParam(required = false) String keyword, @RequestParam(required = false) Integer[] brand_id,
               @RequestParam(required = false) Integer[] processor_id,
               @RequestParam(required = false) Integer[] screenType,
               @RequestParam(required = false) Integer ramMin, @RequestParam(required = false) Integer ramMax,
               @RequestParam(required = false) Integer romMin, @RequestParam(required = false) Integer romMax,
               @RequestParam(required = false) Double screenSizeMin,
               @RequestParam(required = false) Double screenSizeMax,
               @RequestParam(required = false) Integer romType)

     {
          try {
               model.addAttribute("brand", brandService.findAll());
               model.addAttribute("processor", processorService.findAll());
               model.addAttribute("screenType", screenTypeService.findAll());
               model.addAttribute("romType", romTypeService.findAll());
               model.addAttribute("page", page);

               StockFilter filter = new StockFilter();
               filter.setKeyword(keyword);
               filter.setBrand(brand_id);
               filter.setProcessor(processor_id);
               filter.setScreenType(screenType);
               filter.setRamMin(ramMin);
               filter.setRamMax(ramMax);
               filter.setRomMin(romMin);
               filter.setRomMax(romMax);
               filter.setScreenSizeMax(screenSizeMax);
               filter.setScreenSizeMin(screenSizeMin);
               filter.setRomType(romType);
               model.addAttribute("v_stock", filter);
               SearchResult<Laptop> result = laptopService.search(filter, page);
               model.addAttribute("laptops", result.getElements());
               model.addAttribute("totalPage", result.getCountPage());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "laptop/laptop-readall";
     }

     @GetMapping("/admin/laptop/update/{id}")
     public String getUpdate(Model model, @PathVariable int id) {
          try {
               model.addAttribute("romTypes", romTypeService.findAll());
               model.addAttribute("screenTypes", screenTypeService.findAll());
               model.addAttribute("brands", brandService.findAll());
               model.addAttribute("processors", processorService.findAll());
               model.addAttribute("laptop", laptopService.findById(id));

          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "/laptop/laptop-update";
     }

     @PutMapping("/admin/laptop/update/{id}")
     public ResponseEntity<?> postRestUpdate(@RequestBody Laptop laptop) throws Exception {
          try {
               laptopService.update(laptop);
               return returnSuccess(laptop, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/laptop/delete/{id}")
     public String delete(@PathVariable Integer id) throws Exception {
          try {
               laptopService.delete(id);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
          return "redirect:/admin/laptop/update/" + id;
     }

}
