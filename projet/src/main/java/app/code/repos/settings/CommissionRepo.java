package app.code.repos.settings;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import app.code.model.settings.Commission;

public interface CommissionRepo extends JpaRepository<Commission, Integer> {
     @Query(value = "SELECT id, total_min, total_max, commission from commission order by total_min asc", nativeQuery = true)
     public List<Commission> findAll();

     @Query(value = "DELETE FROM commission", nativeQuery = true)
     public void removeAll();
}
