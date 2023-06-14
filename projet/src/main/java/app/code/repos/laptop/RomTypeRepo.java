package app.code.repos.laptop;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.laptop.RomType;

public interface RomTypeRepo extends JpaRepository<RomType, Integer> {

}
