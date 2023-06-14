package app.code.repos.stock;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.stock.Stock;

public interface StockRepo extends JpaRepository<Stock, Integer> {

}
