package app.code.repos.sale;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.sale.SaleDetails;

public interface SaleDetailsRepo extends JpaRepository<SaleDetails, Integer> {
}
