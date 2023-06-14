package app.code.service.stock;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.util.general.service.CrudServiceWithFK;
import app.util.general.search.SearchService;
import org.springframework.stereotype.Service;

import java.util.List;

import java.lang.Integer;
import java.sql.Date;
import app.code.model.user.Store;
import app.code.model.user.Users;
import app.code.repos.user.StoreRepo;
import app.code.model.stock.Receipt;
import app.code.model.stock.Stock;
import app.code.model.stock.StockFilter;
import app.code.model.stock.Transfert;
import app.code.model.stock.VStockMagasin;
import app.code.repos.stock.ModelStockRepo;
import app.code.repos.stock.ReceiptRepo;

@Service
public class ReceiptService extends CrudServiceWithFK<Receipt, Store, StoreRepo, ReceiptRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private StockService stockService;
    @Autowired
    private ModelStockRepo modelStockRepo;
    @Autowired
    private TransfertService transfertService;
    // @Autowired
    // private SearchService<Receipt,ReceiptFilter> searchService;

    public ReceiptService(ReceiptRepo repo, EntityManager manager, StoreRepo refRepo) {
        super(repo, manager, refRepo);
    }

    @Override
    public Object getFKValue(Store ref) {
        return ref.getId();
    }

    @Override
    public Class<Receipt> getEntityClass() {
        return Receipt.class;
    }

    @Override
    public String getFkName() {
        return "type";
    }

    @Override
    public byte[] createPDF(Long arg0) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'createPDF'");
    }

    @Transactional(rollbackOn = Exception.class)
    public List<Receipt> receptionner(List<Receipt> receipts, Users user) throws Exception {
        // verifier les transferts restants pour le magasin
        Transfert t = null;
        int n = 0;
        Receipt temp = null;
        Receipt change;
        for (Receipt r : receipts) {
            temp = repo.findByTransfertId(r.getTransfert().getId());
            if (temp != null) {
                change = r;
                r = temp;
                temp = change;
                r.setDateReceive(temp.getDateReceive());
                r.setQuantity(temp.getQuantity());
            }
            t = transfertService.findById(r.getTransfert().getId());
            if (t.getQuantity() < r.getQuantity()) {
                throw new Exception(
                        "Ce n'est pas logique, il y a " + t.getQuantity() + " " + t.getLaptop().getReference()
                                + " en cours de transfert et vous voulez recevoir " + r.getQuantity());
            }
            n = t.getDateTransfert().compareTo(r.getDateReceive());
            if (n > 0) {
                throw new Exception("La date de reception doit etre superieur a la date de transfert");
            }
            if (temp != null) {
                repo.save(r);
                continue;
            }
            temp = null;
            r.setStoreId(user.getStore().getId());
            r.setUsersId(user.getId());
            repo.save(r);
        }
        return receipts;
    }

    // @Transactional(rollbackOn = Exception.class)
    // public List<Receipt> createAll(List<Receipt> receipts, Users user) throws
    // Exception {
    // List<VTransfertRestant> temp =
    // vrefRepo.findByStoreId(user.getStore().getId());
    // boolean isExist = false;
    // for (VTransfertRestant te : temp) {
    // for (Receipt r2 : receipts) {
    // if (te.getLaptop().getId() == r2.getLaptop().getId()) {
    // isExist = true;
    // if (r2.getQuantity() > te.getQuantity()) {
    // throw new Exception(
    // "Ce n'est pas logique, il y a " + te.getQuantity() + " " +
    // te.getLaptop().getReference()
    // + " en cours de transfert et vous voulez recevoir " + r2.getQuantity());
    // }
    // r2.setStoreId(user.getStore().getId());
    // r2.setUsersId(user.getId());
    // break;
    // }
    // }
    // if (!isExist) {
    // throw new Exception("Ce n'est pas logique, " + te.getLaptop().getReference()
    // + " n'est pas en cours de transfert pour ce magasin");
    // }
    // isExist = false;
    // }
    // return repo.saveAll(receipts);
    // }

}
// public List<Receipt> search(Receipt filter, int page){
// return searchService.search(manager,Receipt.class, filter, page,
// getPageSize());
// }
