package app.code.service.laptop;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.ScreenTypeRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.laptop.ScreenType;

@Service
public class ScreenTypeService extends CrudService<ScreenType, ScreenTypeRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<ScreenType,ScreenTypeFilter> searchService;

    public ScreenTypeService(ScreenTypeRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<ScreenType> getEntityClass() {
        return ScreenType.class;
    }

    @Override
    public List<ScreenType> findAll() {
        return repo.findByActif(true);
    }

    @Override
    public void delete(Integer id) throws Exception {
        ScreenType entity = findById(id);
        entity.setActif(false);
        repo.save(entity);
    }

    public List<ScreenType> findByNameLike(String name) {
        return repo.findByNameIgnoreCaseLikeAndActif("%" + name + "%", true);
    }
    // public SearchResult<ScreenType> search(ScreenTypeFilter filter, int page){
    // return searchService.search(manager,ScreenType.class, filter, page,
    // getPageSize());
    // }

}
