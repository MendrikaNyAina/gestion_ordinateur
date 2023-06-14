package app.code.repos.laptop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.laptop.Laptop;

public interface LaptopRepo extends JpaRepository<Laptop, Integer> {
     public List<Laptop> findByActif(Boolean actif);

}
