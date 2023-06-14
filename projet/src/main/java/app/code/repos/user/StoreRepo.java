package app.code.repos.user;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.user.Store;

public interface StoreRepo extends JpaRepository<Store, Integer> {
     public List<Store> findByIdNotAndActif(Integer id, Boolean actif);
}
