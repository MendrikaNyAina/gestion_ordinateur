package app.code.controller;

import java.util.ArrayList;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.apache.tomcat.jni.Local;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import static app.util.general.util.ControllerUtil.returnSuccess;

import app.code.service.stat.VStatVenteService;
import app.util.general.stat.StatService;
import app.code.model.stat.VStatVente;

@Controller
public class VStatVenteController {
     @Autowired
     private VStatVenteService vStatVenteService;

     @GetMapping("/admin/stat-vente-mois")
     public String getStatVenteMois(Model model, @RequestParam(required = false) Integer year) {
          if (year == null) {
               year = LocalDate.now().getYear();
          }
          StatService<VStatVente> stat = vStatVenteService.getStatVenteMois(year);
          model.addAttribute("data", stat.getLineChartData());
          model.addAttribute("label", stat.getLabelJson(true));
          model.addAttribute("year", year);
          model.addAttribute("table", stat.getListe());
          return "stat/vstat_vente";
     }

     @GetMapping("/admin/stat-vente-mois/{year}/pdf")
     public ResponseEntity<?> pdftest(@PathVariable int year) throws Exception {
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_PDF);
          String filename = "vente" + year + ".pdf";
          headers.setContentDispositionFormData(filename, filename);
          headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
          return new ResponseEntity<>(vStatVenteService.getStatVenteMoisPdf(year), headers, HttpStatus.OK);
     }

     @GetMapping("/admin/stat-vente-mois-magasin")
     public String getStatVenteMoisMagasin(Model model, @RequestParam(required = false) String year) {
          if (year == null || year.equals("")) {
               year = LocalDate.now().getYear() + "-" + LocalDate.now().getMonthValue();
          }
          Date date = Date.valueOf(year + "-01");

          StatService<VStatVente> stat = vStatVenteService.getStatVenteMoisMagasin(date);
          model.addAttribute("data", stat.getPieChartData());
          model.addAttribute("label", stat.getLabelJson(true));
          model.addAttribute("year", year);
          model.addAttribute("table", stat.getListe());

          return "stat/vstat_vente_magasin";
     }

     @GetMapping("/admin/stat-vente-mois-magasin/{year}/pdf")
     public ResponseEntity<?> pdftestMagasin(@PathVariable String year) throws Exception {
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_PDF);
          String filename = "vente-magasin" + year + ".pdf";
          headers.setContentDispositionFormData(filename, filename);
          headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
          if (year == null || year.equals("")) {
               year = LocalDate.now().getYear() + "-" + LocalDate.now().getMonthValue();
          }
          Date date = Date.valueOf(year + "-01");

          return new ResponseEntity<>(vStatVenteService.getStatVenteMoisPdfMagasin(date), headers, HttpStatus.OK);
     }

     @GetMapping("/admin/stat-benefice")
     public String getStatBeneficeMois(Model model, @RequestParam(required = false) Integer year) {
          try {
               if (year == null) {
                    year = LocalDate.now().getYear();
               }
               StatService<VStatVente> stat = vStatVenteService.getStatBeneficeMois(year);
               model.addAttribute("data", stat.getLineChartData());
               model.addAttribute("label", stat.getLabelJson(true));
               model.addAttribute("year", year);
               model.addAttribute("table", stat.getListe());
          } catch (Exception e) {
               e.printStackTrace();
               model.addAttribute("erreur", e.getMessage());
          }
          return "stat/vstat_benefice";
     }

     @GetMapping("/admin/stat-benefice/{year}/pdf")
     public ResponseEntity<?> pdfBeneficeMois(@PathVariable int year) throws Exception {
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_PDF);
          String filename = "benefice" + year + ".pdf";
          headers.setContentDispositionFormData(filename, filename);
          headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
          return new ResponseEntity<>(vStatVenteService.getStatBeneficeMoisPdf(year), headers, HttpStatus.OK);
     }

     @GetMapping("/admin/stat-commission")
     public String getStatBeneficeMois(Model model, @RequestParam(required = false) String year) {
          try {
               if (year == null || year.equals("")) {
                    year = LocalDate.now().getYear() + "-" + LocalDate.now().getMonthValue();
               }
               Date date = Date.valueOf(year + "-01");
               StatService<VStatVente> stat = vStatVenteService.getStatCommissionMagasinMois(date);
               model.addAttribute("data", stat.getPieChartData());
               model.addAttribute("label", stat.getLabelJson(true));
               model.addAttribute("year", year);
               model.addAttribute("table", stat.getListe());
          } catch (Exception e) {
               e.printStackTrace();
               model.addAttribute("erreur", e.getMessage());
          }
          return "stat/vstat_commission";
     }

     @GetMapping("/admin/stat-commission/{year}/pdf")
     public ResponseEntity<?> pdfStatBeneficeMois(@PathVariable String year) throws Exception {
          if (year == null || year.equals("")) {
               year = LocalDate.now().getYear() + "-" + LocalDate.now().getMonthValue();
          }
          Date date = Date.valueOf(year + "-01");
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_PDF);
          String filename = "commission" + year + ".pdf";
          headers.setContentDispositionFormData(filename, filename);
          headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
          return new ResponseEntity<>(vStatVenteService.getStatCommissionMagasinMoisPdf(date), headers, HttpStatus.OK);
     }
}
