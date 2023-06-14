package app.code.repos.user;

import java.util.List;

import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import app.code.model.user.Users;

public interface UsersRepo extends JpaRepository<Users, Integer> {
     public Users findByUsernameAndPassword(String username, String password);

     public List<Users> findByStoreIdNot(Integer storeId, PageRequest pageable);

}
