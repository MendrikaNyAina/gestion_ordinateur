package app.code.repos.stat;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.code.model.stat.VStatVente;

public interface VStatVenteRepo extends JpaRepository<VStatVente, Integer> {
     @Query(value = "SELECT row_number() over() as id, m.year,m.month, COALESCE(s.total,0) as total, 'store' as store from "
               +
               "(SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month" +
               " FROM generate_series(CAST(?1 as DATE), CAST(?2 as DATE), '1 month') AS month )m " +
               " LEFT JOIN v_stat_vente_mois s ON m.year=s.year and m.month=s.month", nativeQuery = true)
     public List<VStatVente> getStatVenteMois(Date debut, Date fin);

     @Query(value = "SELECT row_number()over()as id, m.year,m.month, COALESCE(s.total,0) as total, m.name as store FROM  "
               +
               "(SELECT m.year, m.month, s.id, s.name from store s, (SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month"
               +
               " FROM generate_series(cast(?1 as date), cast(?2 as date), '1 month') AS month )m)m LEFT JOIN" +
               " v_stat_vente_mois_magasin s ON m.year=s.year and m.month=s.month and s.store_id=m.id where m.id!=1 ORDER BY m.id, m.year, m.month asc ", nativeQuery = true)
     public List<VStatVente> getStatVenteMoisMagasin(Date debut, Date fin);

     @Query(value = "SELECT row_number() over() as id, a.year, a.month, 'store' as store, " +
               " (COALESCE(s.total, 0)-COALESCE(p.total_perte, 0)) as total from " +
               " (SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month" +
               " FROM generate_series(cast(?1 as date), cast(?2 as date), '1 month') AS month )a" +
               " LEFT JOIN v_stat_vente_mois s ON a.year=s.year and a.month=s.month" +
               " LEFT JOIN v_perte_mois p ON a.year=p.year and a.month=p.month;", nativeQuery = true)
     public List<VStatVente> getStatBeneficeMois(Date debut, Date fin);
}
