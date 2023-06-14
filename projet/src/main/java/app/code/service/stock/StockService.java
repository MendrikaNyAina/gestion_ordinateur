package app.code.service.stock;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.stock.CentralStockRepo;
import app.code.repos.stock.StockRepo;
import app.code.repos.stock.VStockMagasinRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.lang.Long;
import java.lang.Double;
import java.lang.Integer;

import app.code.model.stock.CentralStock;
import app.code.model.stock.Stock;
import app.code.model.stock.StockFilter;
import app.code.model.stock.Transfert;
import app.code.model.stock.VStockMagasin;

@Service
public class StockService extends CrudService<Stock, StockRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private SearchService<Stock, StockFilter> searchService;

    @Autowired
    private CentralStockRepo centralStockRepo;

    @Autowired
    private VStockMagasinRepo vStockMagasinRepo;
    @Autowired
    private SearchService<VStockMagasin, StockFilter> searchStockMagasinService;

    public StockService(StockRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Stock> getEntityClass() {
        return Stock.class;
    }

    public SearchResult<Stock> search(StockFilter filter, int page) {
        return searchService.search(manager, Stock.class, filter, page - 1,
                getPageSize());
    }

    public SearchResult<Stock> searchAll(StockFilter filter) {
        return searchService.search(manager, Stock.class, filter, 0,
                0);
    }

    @Transactional(rollbackOn = Exception.class)
    public List<Stock> transferer(Integer senderId, Integer receiverId, List<Stock> liste,
            Date datetransfert) throws Exception {
        Integer[] id = new Integer[liste.size()];
        for (int i = 0; i < id.length; i++) {
            id[i] = liste.get(i).getId();
        }
        StockFilter filter = new StockFilter();
        filter.setIds(id);
        // checker si dans le stock, il y a bien
        List<Stock> stocks = searchAll(filter).getElements();
        List<CentralStock> temp = null;
        List<Transfert> transfert = new ArrayList<Transfert>();
        for (Stock s : stocks) {
            for (Stock e : liste) {
                if (s.getId() == e.getId()) {
                    if (s.getQuantity() < e.getQuantity()) {
                        throw new Exception(
                                "quantite insuffisante pour " + s.getReference() + ", il reste " + s.getQuantity());
                    }
                    s.setQuantityTransfert(e.getQuantity());
                    temp = centralStockRepo.inStock(s.getId(), s.getQuantityTransfert());
                    for (CentralStock c : temp) {
                        transfert.add(new Transfert());
                    }
                    break;
                }
            }
        }
        return stocks;
    }

    public SearchResult<VStockMagasin> searchStockMagasinAll(StockFilter filter) {
        return searchStockMagasinService.search(manager, VStockMagasin.class, filter, 0,
                0);
    }

    public SearchResult<VStockMagasin> searchStockMagasin(StockFilter filter, int page) {
        return searchStockMagasinService.search(manager, VStockMagasin.class, filter, page - 1,
                getPageSize());
    }

}
