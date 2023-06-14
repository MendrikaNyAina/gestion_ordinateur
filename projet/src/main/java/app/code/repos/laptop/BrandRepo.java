package app.code.repos.laptop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.laptop.Brand;

public interface BrandRepo extends JpaRepository<Brand, Integer> {
     public List<Brand> findByActif(Boolean actif);

     public List<Brand> findByNameIgnoreCaseLikeAndActif(String name, Boolean actif);
}
