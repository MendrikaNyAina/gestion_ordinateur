package app.code.repos.sale;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.sale.Sale;

public interface SaleRepo extends JpaRepository<Sale, Integer> {
}
