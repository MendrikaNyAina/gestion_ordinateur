package app.code.service.user;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.user.UsersRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.user.Store;
import app.code.model.user.Users;

@Service
public class UsersService extends CrudService<Users, UsersRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private SearchService<Users, Users> searchService;

    public UsersService(UsersRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Users> getEntityClass() {
        return Users.class;
    }

    public Users loginAdmin(String username, String password) throws Exception {
        Users user = repo.findByUsernameAndPassword(username, password);
        if (user == null) {
            throw new Exception("Invalid username or password");
        }
        if (user.getStore().getRole().getId() != 1) {
            throw new Exception("Invalid username or password");
        }
        // user.setPassword(null);

        return user;
    }

    public Users loginStore(String username, String password) throws Exception {
        Users user = repo.findByUsernameAndPassword(username, password);
        if (user == null) {
            throw new Exception("Invalid username or password");
        }
        if (user.getStore().getRole().getId() != 2) {
            throw new Exception("Invalid username or password");
        }
        // user.setPassword(null);
        return user;
    }

    public SearchResult<Users> findAllStoreUser(int page) {
        Users filter = new Users();
        filter.setStoreAdmin(1);
        return searchService.search(manager, Users.class, filter, page - 1, getPageSize());
    }
}
