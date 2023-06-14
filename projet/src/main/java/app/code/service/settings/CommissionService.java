package app.code.service.settings;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.settings.CommissionRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.lang.Double;
import java.lang.Integer;
import app.code.model.settings.Commission;

@Service
public class CommissionService extends CrudService<Commission, CommissionRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<Commission, CommissionFilter> searchService;

    public CommissionService(CommissionRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Commission> getEntityClass() {
        return Commission.class;
    }

    @Transactional(rollbackOn = Exception.class)
    public List<Commission> updateSettings(List<Commission> liste) throws Exception {
        Collections.sort(liste, new Comparator<Commission>() {
            @Override
            public int compare(Commission o1, Commission o2) {
                return o1.getTotalMin().compareTo(o2.getTotalMin());
            }
        });
        for (int i = 1; i < liste.size(); i++) {
            if (liste.get(i - 1).getTotalMax() != null
                    && liste.get(i).getTotalMin() <= liste.get(i - 1).getTotalMax()) {
                throw new Exception("interval not valide");
            } else if (liste.get(i - 1).getTotalMax() == null && i != liste.size() - 1) {
                throw new Exception("interval not valide");
            }
        }
        List<Commission> list = repo.findAll();
        for (Commission commission : list) {
            repo.delete(commission);
        }
        return repo.saveAll(liste);
    }

    public Double commission(List<Commission> list, Double total) {
        Double com = 0.0;
        // List
        Collections.sort(list, new Comparator<Commission>() {
            @Override
            public int compare(Commission o1, Commission o2) {
                return o1.getTotalMin().compareTo(o2.getTotalMin());
            }
        });
        for (Commission commission : list) {
            if (total >= commission.getTotalMin()) {
                if (commission.getTotalMax() != null) {
                    if (total <= commission.getTotalMax()) {
                        com += commission.getCommission() * (total - commission.getTotalMin());
                    } else {
                        com += commission.getCommission() * (commission.getTotalMax() - commission.getTotalMin());
                    }
                } else {
                    com += commission.getCommission() * (total - commission.getTotalMin());
                }

            }
        }
        return com;
    }

    // public SearchResult<Commission> search(CommissionFilter filter, int page) {
    // return searchService.search(manager, Commission.class, filter, page,
    // getPageSize());
    // }

}
