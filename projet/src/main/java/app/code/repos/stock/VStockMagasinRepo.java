package app.code.repos.stock;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.stock.Stock;
import app.code.model.stock.VStockMagasin;

public interface VStockMagasinRepo extends JpaRepository<VStockMagasin, Integer> {

}
