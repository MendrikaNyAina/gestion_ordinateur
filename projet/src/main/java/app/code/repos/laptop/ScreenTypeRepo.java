package app.code.repos.laptop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.laptop.ScreenType;

public interface ScreenTypeRepo extends JpaRepository<ScreenType, Integer> {
     public List<ScreenType> findByActif(Boolean actif);

     public List<ScreenType> findByNameIgnoreCaseLikeAndActif(String name, Boolean actif);

}
