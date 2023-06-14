package app.code.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.code.model.laptop.Processor;
import app.code.service.laptop.ProcessorService;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

@Controller
public class ProcessorController {
     @Autowired
     private ProcessorService processorService;

     @PostMapping("/admin/processor")
     public String postCreate(Model model, @RequestParam(name = "name") String name) {
          try {
               Processor processor = new Processor();
               processor.setName(name);
               processorService.create(processor);
               model.addAttribute("name", name);
               return "redirect:/admin/processors";
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return getReadAll(model, "");
     }

     @PutMapping("/admin/processor/update/{id}")
     public ResponseEntity<?> postRestUpdate(@RequestBody Processor processor) throws Exception {
          try {
               Processor temp = processorService.findById(processor.getId());
               temp.setName(processor.getName());
               processorService.update(temp);
               return returnSuccess(processor, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

     @GetMapping("/admin/processors")
     public String getReadAll(Model model,
               @RequestParam(required = false, defaultValue = "") String keyword) {
          try {
               model.addAttribute("keyword", keyword);
               model.addAttribute("processors", processorService.findByNameLike(keyword));
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "laptop/processor-readall";
     }

     @GetMapping("/admin/processor/delete/{id}")
     public String getDelete(Model model,
               @PathVariable(name = "id") Integer id) {
          try {
               processorService.delete(id);
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "redirect:/admin/processors";

     }
}
