package app.code.service.sale;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.LaptopRepo;
import app.code.repos.sale.SaleDetailsRepo;
import app.code.repos.sale.SaleRepo;
import app.code.repos.stock.ModelStockRepo;
import app.code.service.laptop.LaptopService;
import app.code.service.stock.StockService;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.sql.Date;
import java.lang.String;
import java.lang.Integer;
import java.lang.Double;
import app.code.model.user.Store;
import app.code.model.user.Users;
import app.code.model.laptop.Laptop;
import app.code.model.sale.Sale;
import app.code.model.sale.SaleDetails;
import app.code.model.stock.ModelStock;
import app.code.model.stock.StockFilter;
import app.code.model.stock.VStockMagasin;

@Service
public class SaleService extends CrudService<Sale, SaleRepo> {
    @PersistenceContext
    private EntityManager manager;
    @Autowired
    private StockService stockService;
    @Autowired
    private SaleDetailsRepo saleDetailsRepo;
    @Autowired
    private LaptopService laptopRepo;
    // @Autowired
    // private SearchService<Sale,SaleFilter> searchService;
    @Autowired
    private ModelStockRepo modelStockRepo;

    public SaleService(SaleRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Sale> getEntityClass() {
        return Sale.class;
    }

    // public SearchResult<Sale> search(SaleFilter filter, int page){
    // return searchService.search(manager,Sale.class, filter, page, getPageSize());
    // }
    @Transactional(rollbackOn = Exception.class)
    public Sale sales(Sale sale, Users user) throws Exception {
        if (sale.getSaleDetails() == null || sale.getSaleDetails().size() == 0) {
            throw new Exception("Vous ne pouvez pas faire une vente sans articles");
        }
        // checker si le stock est suffisant
        List<ModelStock> liste = modelStockRepo.stockMagasinByDate(sale.getDateSale(), user.getStore().getId());
        System.out.println(user.getStore().getId());
        boolean flag = false;
        Laptop l = null;
        for (SaleDetails t2 : sale.getSaleDetails()) {
            l = laptopRepo.findById(t2.getLaptop().getId());
            for (ModelStock t : liste) {
                if (t.getLaptopId() == t2.getLaptop().getId()) {
                    if (t.getQuantity() < t2.getQuantity()) {
                        throw new Exception("Ce n'est pas logique, il y a " + t.getQuantity() + " " + t.getReference()
                                + " en stock et vous voulez vendre " + t2.getQuantity());
                    }
                    t2.setUnitPrice(l.getPrice());
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                throw new Exception(
                        "Ce n'est pas logique, il y a le laptop " + l.getReference() + " qui a 0 unite dans le stock");
            }
        }
        sale.setStore(user.getStore());
        sale.setUsersId(user.getId());
        repo.save(sale);
        for (SaleDetails t : sale.getSaleDetails()) {
            t.setSaleId(sale.getId());
        }
        saleDetailsRepo.saveAll(sale.getSaleDetails());
        return sale;
    }

    // @Transactional(rollbackOn = Exception.class)
    // public Sale sales(Sale sale, Users user) throws Exception {
    // // checker si je peux renvoyer chacun des trucs
    // Integer[] laptopid = new Integer[sale.getSaleDetails().size()];
    // for (int i = 0; i < sale.getSaleDetails().size(); i++) {
    // laptopid[i] = sale.getSaleDetails().get(i).getLaptop().getId();
    // }
    // StockFilter filter = new StockFilter();
    // filter.setIds(laptopid);
    // filter.setStoreId(user.getStore().getId());
    // List<VStockMagasin> temp =
    // stockService.searchStockMagasinAll(filter).getElements();
    // boolean flag = false;
    // for (SaleDetails t2 : sale.getSaleDetails()) {
    // for (VStockMagasin t : temp) {
    // if (t.getId() == t2.getLaptop().getId()) {
    // if (t.getQuantity() < t2.getQuantity()) {
    // throw new Exception("Ce n'est pas logique, il y a " + t.getQuantity() + " " +
    // t.getReference()
    // + " en stock et vous voulez renvoyer " + t2.getQuantity());
    // }
    // t2.setUnitPrice(t.getPrice());
    // flag = true;
    // break;
    // }
    // }
    // if (!flag) {
    // throw new Exception("Ce n'est pas logique, il y a " + 0 + " " +
    // t2.getLaptop().getReference()
    // + " en stock et vous voulez renvoyer " + t2.getQuantity());
    // }
    // flag = false;
    // }

    // sale.setStore(user.getStore());
    // sale.setUsersId(user.getId());
    // repo.save(sale);
    // for (SaleDetails t : sale.getSaleDetails()) {
    // t.setSaleId(sale.getId());
    // }
    // saleDetailsRepo.saveAll(sale.getSaleDetails());
    // return sale;
    // }
}
