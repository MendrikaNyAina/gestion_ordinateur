package app.code.service.stock;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.stock.ModelStockRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.Long;
import java.lang.Integer;
import app.code.model.stock.ModelStock;

@Service
public class ModelStockService extends CrudService<ModelStock, ModelStockRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<ModelStock,ModelStockFilter> searchService;

    public ModelStockService(ModelStockRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<ModelStock> getEntityClass() {
        return ModelStock.class;
    }
    // public SearchResult<ModelStock> search(ModelStockFilter filter, int page){
    // return searchService.search(manager,ModelStock.class, filter, page,
    // getPageSize());
    // }

}
