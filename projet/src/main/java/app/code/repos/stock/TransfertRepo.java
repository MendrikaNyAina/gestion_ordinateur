package app.code.repos.stock;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.stock.Transfert;

public interface TransfertRepo extends JpaRepository<Transfert, Integer> {
     public List<Transfert> findByDateTransfertAndStoreId(Date date, Integer storeId);

     public List<Transfert> findByDateTransfertAndType(Date date, Integer type);
}
