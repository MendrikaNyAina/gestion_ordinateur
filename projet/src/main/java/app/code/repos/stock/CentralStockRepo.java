package app.code.repos.stock;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.code.model.stock.CentralStock;

public interface CentralStockRepo extends JpaRepository<CentralStock, Integer> {
     @Query(value = "select * FROM v_centralstock_current where laptop_id=?1 limit ?2", nativeQuery = true)
     public List<CentralStock> inStock(Integer lapotopId, Integer limit);
}
