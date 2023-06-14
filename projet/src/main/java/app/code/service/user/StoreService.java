package app.code.service.user;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.user.StoreRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.user.Store;

@Service
public class StoreService extends CrudService<Store, StoreRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private SearchService<Store, Store> searchService;

    public StoreService(StoreRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Store> getEntityClass() {
        return Store.class;
    }

    public SearchResult<Store> getStoreShop() {
        Store shop = new Store();
        shop.setRoleAdmin(1);
        return searchService.search(manager, getEntityClass(), shop, 0, 0);
    }

    @Override
    public void delete(Integer id) throws Exception {
        Store entity = findById(id);
        entity.setActif(false);
        repo.save(entity);
    }

    public SearchResult<Store> search(Store filter) {
        return searchService.search(manager, Store.class, filter, 0, 0);
    }

    @Override
    public List<Store> findAll() {
        return repo.findByIdNotAndActif(1, true);
    }
}
