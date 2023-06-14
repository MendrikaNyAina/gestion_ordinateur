package app.code.service.sale;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.sale.VSaleRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import java.sql.Date;
import java.lang.Double;
import app.code.model.sale.VSale;

@Service
public class VSaleService extends CrudService<VSale, VSaleRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private SearchService<VSale, VSale> searchService;

    public VSaleService(VSaleRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<VSale> getEntityClass() {
        return VSale.class;
    }

    public SearchResult<VSale> search(VSale filter, int page) {
        return searchService.search(manager, VSale.class, filter, page - 1, getPageSize());
    }

}
