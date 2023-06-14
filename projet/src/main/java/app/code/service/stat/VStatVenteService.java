package app.code.service.stat;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.stat.VStatVenteRepo;
import app.code.service.settings.CommissionService;
import app.util.general.service.CrudService;
import app.util.general.stat.Stat;
import app.util.general.stat.StatService;
import app.util.general.search.SearchService;
import app.util.general.pdfutils.PDFGenerator;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.lang.Integer;
import java.lang.Double;
import java.math.BigDecimal;

import app.code.model.settings.Commission;
import app.code.model.stat.VStatVente;

@Service
public class VStatVenteService extends CrudService<VStatVente, VStatVenteRepo> {
    @PersistenceContext
    private EntityManager manager;
    @Autowired
    private CommissionService commissionService;

    public VStatVenteService(VStatVenteRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<VStatVente> getEntityClass() {
        return VStatVente.class;
    }

    public List<VStatVente> getStatVenteMois(Date debut, Date fin) {
        return repo.getStatVenteMois(debut, fin);
    }

    public StatService<VStatVente> getStatVenteMois(Integer year) {
        Date debut = Date.valueOf(year + "-01-01");
        Date fin = Date.valueOf(year + "-12-31");
        List<VStatVente> liste = repo.getStatVenteMois(debut, fin);
        StatService<VStatVente> stat = new StatService<>(liste, "string");
        return stat;
    }

    public byte[] getStatVenteMoisPdf(Integer year) throws Exception {
        Date debut = Date.valueOf(year + "-01-01");
        Date fin = Date.valueOf(year + "-12-31");
        HashMap<String, Object> datas = new HashMap();
        datas.put("year", year);
        datas.put("stat", repo.getStatVenteMois(debut, fin));
        byte[] bytes = new PDFGenerator(datas, "template-pdf/table-vente.html").generatePDF("vente-mois.pdf");
        return bytes;
    }

    public StatService<VStatVente> getStatVenteMoisMagasin(Date year) {
        // Date debut = Date.valueOf(year + "-01-01");
        // Date fin = Date.valueOf(year + "-12-31");
        List<VStatVente> liste = repo.getStatVenteMoisMagasin(year, year);
        for (VStatVente vStatVente : liste) {
            vStatVente.setParmonth(false);
            // System.out.println(vStatVente.getTotal());
        }
        StatService<VStatVente> stat = new StatService<>(liste, "string", "Vente");
        return stat;
    }

    public byte[] getStatVenteMoisPdfMagasin(Date year) throws Exception {
        // Date debut = Date.valueOf(year + "-01-01");
        // Date fin = Date.valueOf(year + "-12-31");
        HashMap<String, Object> datas = new HashMap();
        datas.put("year", year);
        StatService<VStatVente> stat = getStatVenteMoisMagasin(year);
        datas.put("stat", stat.getListe());
        byte[] bytes = new PDFGenerator(datas, "template-pdf/table-vente-magasin.html")
                .generatePDF("vente-mois-magasin.pdf");
        return bytes;
    }

    public StatService<VStatVente> getStatBeneficeMois(Integer year) throws Exception {
        Date debut = Date.valueOf(year + "-01-01");
        Date fin = Date.valueOf(year + "-12-31");
        List<VStatVente> liste = repo.getStatBeneficeMois(debut, fin);
        List<Commission> commissions = commissionService.findAll();
        List<VStatVente> listevente = repo.getStatVenteMois(debut, fin);
        // List
        Collections.sort(commissions, new Comparator<Commission>() {
            @Override
            public int compare(Commission o1, Commission o2) {
                return o1.getTotalMin().compareTo(o2.getTotalMin());
            }
        });
        //
        int i = 0;
        for (VStatVente vStatVente : liste) {
            List<VStatVente> templiste = getStatVenteMoisMagasin(
                    Date.valueOf(year + "-" + vStatVente.getMonthInt() + "-01")).getListe();
            Double com = 0.00;
            for (VStatVente v : templiste) {
                com += commissionService.commission(commissions, v.getTotal());
            }
            // vStatVente
            // .setTotal(vStatVente.getTotal()
            // - commissionService.commission(commissions, listevente.get(i).getTotal()));
            vStatVente
                    .setTotal(vStatVente.getTotal()
                            - com);
            i++;
        }
        StatService<VStatVente> stat = new StatService<>(liste, "string");
        return stat;
    }

    public byte[] getStatBeneficeMoisPdf(Integer year) throws Exception {
        Date debut = Date.valueOf(year + "-01-01");
        Date fin = Date.valueOf(year + "-12-31");
        HashMap<String, Object> datas = new HashMap();
        datas.put("year", year);
        datas.put("stat", getStatBeneficeMois(year).getListe());
        byte[] bytes = new PDFGenerator(datas, "template-pdf/table-benefice.html")
                .generatePDF("benefice-mois.pdf");
        return bytes;
    }

    public StatService<VStatVente> getStatCommissionMagasinMois(Date date) throws Exception {
        List<VStatVente> liste = repo.getStatVenteMoisMagasin(date, date);
        List<Commission> commissions = commissionService.findAll();
        // List
        Collections.sort(commissions, new Comparator<Commission>() {
            @Override
            public int compare(Commission o1, Commission o2) {
                return o1.getTotalMin().compareTo(o2.getTotalMin());
            }
        });
        for (VStatVente vStatVente : liste) {
            vStatVente.setVente(vStatVente.getTotal());
            vStatVente
                    .setTotal(commissionService.commission(commissions, vStatVente.getTotal()));
            vStatVente.setParmonth(false);
            // System.out.println(vStatVente.getTotal());
        }
        StatService<VStatVente> stat = new StatService<>(liste, "string", "commission");
        return stat;
    }

    public byte[] getStatCommissionMagasinMoisPdf(Date date) throws Exception {
        StatService<VStatVente> stat = getStatCommissionMagasinMois(date);
        HashMap<String, Object> datas = new HashMap();
        datas.put("year", date);
        datas.put("stat", stat.getListe());
        byte[] bytes = new PDFGenerator(datas, "template-pdf/table-commission.html")
                .generatePDF("commission-mois" + date.toString() + ".pdf");
        return bytes;
    }
}
