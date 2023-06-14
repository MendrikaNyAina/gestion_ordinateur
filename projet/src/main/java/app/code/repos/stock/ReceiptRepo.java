package app.code.repos.stock;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.code.model.stock.Receipt;

public interface ReceiptRepo extends JpaRepository<Receipt, Integer> {
     @Query(value = "SELECT * from v_transfert_restant where store_receiver_id = ?1", nativeQuery = true)
     public List<Receipt> resteTransfert(Integer store_id);

     public Receipt findByTransfertId(Integer transfertId);

}
