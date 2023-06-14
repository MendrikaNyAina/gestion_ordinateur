package app.code.repos.stock;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.code.model.stock.ModelStock;

public interface ModelStockRepo extends JpaRepository<ModelStock, Integer> {
     @Query(value = "SELECT row_number() over() as id, f.laptop_id, l.reference,1 as store_id, f.quantity " +
               " FROM f_central_stock(?1) f, laptop l WHERE f.laptop_id=l.id", nativeQuery = true)
     public List<ModelStock> stockCentralByDate(Date date);

     @Query(value = "SELECT f.id, f.laptop_id, l.reference, ?2 as store_id, f.quantity " +
               " FROM f_transfert_restant_ligne(?1, ?2) f, laptop l WHERE f.laptop_id=l.id", nativeQuery = true)
     public List<ModelStock> transfertRestant(Date date, Integer store_id);// pas perte

     @Query(value = "SELECT row_number() over() as id, f.laptop_id, l.reference, ?2 as store_id, f.quantity " +
               " FROM f_stock_magasin(?1, ?2) f, laptop l WHERE f.laptop_id=l.id", nativeQuery = true)
     public List<ModelStock> stockMagasinByDate(Date date, Integer store_id);
}
