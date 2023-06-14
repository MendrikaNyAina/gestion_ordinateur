package app.code.service.stock;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.stock.ModelStockRepo;
import app.code.repos.stock.TransfertRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.Integer;
import java.sql.Date;
import app.code.model.stock.CentralStock;
import app.code.model.stock.ModelStock;
import app.code.model.stock.Stock;
import app.code.model.stock.StockFilter;
import app.code.model.stock.Transfert;
import app.code.model.stock.VStockMagasin;
import app.code.model.user.Users;

@Service
public class TransfertService extends CrudService<Transfert, TransfertRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private StockService stockService;

    @Autowired
    private ModelStockRepo modelStockRepo;
    // @Autowired
    // private SearchService<Transfert,TransfertFilter> searchService;

    public TransfertService(TransfertRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Transfert> getEntityClass() {
        return Transfert.class;
    }

    public List<Transfert> findByDateAndStoreId(Date date, Integer storeId) {
        return repo.findByDateTransfertAndStoreId(date, storeId);
    }

    public List<Transfert> findByDateTransfertAndType(Date date, Integer type) {
        return repo.findByDateTransfertAndType(date, type);
    }

    @Transactional(rollbackOn = Exception.class)
    public List<Transfert> transferer(List<Transfert> transferts, Users user, Integer type) throws Exception {
        if (transferts == null || transferts.size() == 0) {
            throw new Exception("Aucun transfert");
        }
        // checker si la quantite est suffisante, prendre le stock restant dans le
        // central a cette date;
        List<ModelStock> liste = null;
        if (type == 2) {
            liste = modelStockRepo.stockMagasinByDate(transferts.get(0).getDateTransfert(),
                    user.getStore().getId());
        } else {
            liste = modelStockRepo.stockCentralByDate(transferts.get(0).getDateTransfert());
        }
        boolean isExist = false;
        for (Transfert t : transferts) {
            for (ModelStock s : liste) {
                if (t.getLaptop().getId() == s.getLaptopId()) {
                    if (t.getQuantity() > s.getQuantity()) {
                        throw new Exception("Quantite insuffisante pour le laptop " + s.getReference()
                                + " dans le stock " + s.getQuantity());
                    }
                    t.setUsersId(user.getId());
                    t.setType(type);
                    if (type == 2) {
                        t.setStoreId(user.getStore().getId());
                    }
                    // repo.save(t);
                    isExist = true;
                    break;
                }
            }
            if (!isExist) {
                throw new Exception("Le laptop n'est pas dans le stock");
            }
        }
        return saveAll(transferts);
    }

    // @Transactional(rollbackOn = Exception.class)
    // public List<Transfert> renvoyer(List<Transfert> transferts, Users user)
    // throws Exception {
    // // checker si je peux renvoyer chacun des trucs
    // Integer[] laptopid = new Integer[transferts.size()];
    // for (int i = 0; i < transferts.size(); i++) {
    // laptopid[i] = transferts.get(i).getLaptop().getId();
    // }
    // StockFilter filter = new StockFilter();
    // filter.setIds(laptopid);
    // filter.setStoreId(user.getStore().getId());
    // List<VStockMagasin> temp =
    // stockService.searchStockMagasinAll(filter).getElements();
    // boolean flag = false;
    // for (Transfert t2 : transferts) {
    // for (VStockMagasin t : temp) {
    // if (t.getId() == t2.getLaptop().getId()) {
    // if (t.getQuantity() < t2.getQuantity()) {
    // throw new Exception("Ce n'est pas logique, il y a " + t.getQuantity() + " " +
    // t.getReference()
    // + " en stock et vous voulez renvoyer " + t2.getQuantity());
    // }
    // t2.setStoreId(user.getStore().getId());
    // t2.setType(2);
    // t2.setUsersId(user.getId());
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
    // return repo.saveAll(transferts);
    // }
    // public SearchResult<Transfert> search(TransfertFilter filter, int page){
    // return searchService.search(manager,Transfert.class, filter, page,
    // getPageSize());
    // }
    // @Transactional(rollbackOn = Exception.class)
    // public List<Transfert> transferer(List<Transfert> transferts, Users user)
    // throws Exception {
    // // checker si la quantite est suffisante;
    // Integer[] laptopid = new Integer[transferts.size()];
    // for (int i = 0; i < transferts.size(); i++) {
    // laptopid[i] = transferts.get(i).getLaptop().getId();
    // }
    // StockFilter filter = new StockFilter();
    // filter.setIds(laptopid);
    // List<Stock> liste = stockService.searchAll(filter).getElements();
    // for (Transfert t : transferts) {
    // for (Stock s : liste) {
    // if (t.getLaptop().getId() == s.getId()) {
    // if (t.getQuantity() > s.getQuantity()) {
    // throw new Exception("Quantite insuffisante pour le laptop " +
    // s.getReference()
    // + " dans le stock " + s.getQuantity());
    // }
    // t.setUsersId(user.getId());
    // t.setType(1);
    // repo.save(t);
    // break;
    // }
    // }
    // }
    // return transferts;
    // }

}
