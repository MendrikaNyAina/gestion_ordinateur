package app.code.service.laptop;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.RomTypeRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.laptop.RomType;

@Service
public class RomTypeService extends CrudService<RomType, RomTypeRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<RomType,RomTypeFilter> searchService;

    public RomTypeService(RomTypeRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<RomType> getEntityClass() {
        return RomType.class;
    }

    // public SearchResult<RomType> search(RomTypeFilter filter, int page){
    // return searchService.search(manager,RomType.class, filter, page,
    // getPageSize());
    // }

}
