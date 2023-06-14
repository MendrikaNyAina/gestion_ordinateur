package app.code.service.laptop;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.BrandRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.laptop.Brand;

@Service
public class BrandService extends CrudService<Brand, BrandRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<Brand,BrandFilter> searchService;

    public BrandService(BrandRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Brand> getEntityClass() {
        return Brand.class;
    }

    @Override
    public List<Brand> findAll() {
        return repo.findByActif(true);
    }

    public List<Brand> findByNameLike(String name) {
        return repo.findByNameIgnoreCaseLikeAndActif("%" + name + "%", true);
    }

    @Override
    public void delete(Integer id) throws Exception {
        Brand entity = findById(id);
        entity.setActif(false);
        repo.save(entity);
    }
    // public SearchResult<Brand> search(BrandFilter filter, int page){
    // return searchService.search(manager,Brand.class, filter, page,
    // getPageSize());
    // }

}
