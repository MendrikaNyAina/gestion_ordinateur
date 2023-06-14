package app.code.controller;

import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import app.code.model.settings.Commission;
import app.code.service.settings.CommissionService;

import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

@Controller
public class CommissionController {
     @Autowired
     private CommissionService commissionService;

     @GetMapping("/admin/commission/update")
     public String getUpdate(Model model) {
          try {
               model.addAttribute("commission", commissionService.findAll());
          } catch (Exception e) {
               model.addAttribute("erreur", e.getMessage());
               e.printStackTrace();
          }
          return "settings/commission-update";
     }

     @PutMapping("/admin/commission/update")
     public ResponseEntity<?> postRestUpdate(@RequestBody List<Commission> commission) throws Exception {
          try {
               commissionService.updateSettings(commission);
               return returnSuccess(commission, HttpStatus.OK);
          } catch (Exception e) {
               e.printStackTrace();
               throw e;
          }
     }

}
