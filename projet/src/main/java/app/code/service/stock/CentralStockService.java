package app.code.service.stock;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.stock.CentralStockRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.lang.Integer;
import java.lang.Double;
import app.code.model.laptop.Laptop;
import app.code.model.stock.CentralStock;
import app.code.model.stock.Stock;
import app.code.model.stock.StockFilter;

@Service
public class CentralStockService extends CrudService<CentralStock, CentralStockRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private StockService stockService;

    // @Autowired
    // private SearchService<CentralStock,CentralStockFilter> searchService;

    public CentralStockService(CentralStockRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<CentralStock> getEntityClass() {
        return CentralStock.class;
    }
    // public SearchResult<CentralStock> search(CentralStockFilter filter, int
    // page){
    // return searchService.search(manager,CentralStock.class, filter, page,
    // getPageSize());
    // }

}
