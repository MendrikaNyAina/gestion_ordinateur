package app.code.repos.sale;

import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.sale.VSale;

public interface VSaleRepo extends JpaRepository<VSale, Integer> {
}
