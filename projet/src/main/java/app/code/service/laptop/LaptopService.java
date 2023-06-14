package app.code.service.laptop;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.LaptopRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.laptop.RomType;
import app.code.model.laptop.ScreenType;
import app.code.model.stock.StockFilter;
import app.code.model.laptop.Brand;
import app.code.model.laptop.Processor;
import java.lang.Double;
import app.code.model.laptop.Laptop;

@Service
public class LaptopService extends CrudService<Laptop, LaptopRepo> {
    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private SearchService<Laptop, Laptop> searchService;

    @Autowired
    private SearchService<Laptop, StockFilter> searchAllService;

    public LaptopService(LaptopRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Laptop> getEntityClass() {
        return Laptop.class;
    }

    public SearchResult<Laptop> search(Laptop filter) {
        return searchService.search(manager, Laptop.class, filter, 0,
                0);
    }

    public SearchResult<Laptop> search(StockFilter filter, int page) {
        return searchAllService.search(manager, Laptop.class, filter, page - 1,
                getPageSize());
    }

    @Override
    public List<Laptop> findAll() {
        return repo.findByActif(true);
    }

    @Override
    public void delete(Integer id) throws Exception {
        Laptop entity = findById(id);
        entity.setActif(false);
        repo.save(entity);
    }

}
