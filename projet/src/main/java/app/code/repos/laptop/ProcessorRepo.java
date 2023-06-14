package app.code.repos.laptop;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.laptop.Processor;

public interface ProcessorRepo extends JpaRepository<Processor, Integer> {

     public List<Processor> findByActif(Boolean actif);

     public List<Processor> findByNameIgnoreCaseLikeAndActif(String name, Boolean actif);

}
