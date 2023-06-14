package app.code.service.sale;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.sale.SaleDetailsRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.Integer;
import java.lang.Double;
import app.code.model.laptop.Laptop;
import app.code.model.sale.SaleDetails;

@Service
public class SaleDetailsService extends CrudService<SaleDetails, SaleDetailsRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<SaleDetails,SaleDetailsFilter> searchService;

    public SaleDetailsService(SaleDetailsRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<SaleDetails> getEntityClass() {
        return SaleDetails.class;
    }
    // public SearchResult<SaleDetails> search(SaleDetailsFilter filter, int page){
    // return searchService.search(manager,SaleDetails.class, filter, page,
    // getPageSize());
    // }

}
