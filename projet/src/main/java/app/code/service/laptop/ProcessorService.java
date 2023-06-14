package app.code.service.laptop;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;

import app.code.repos.laptop.ProcessorRepo;
import app.util.general.service.CrudService;
import app.util.general.search.SearchService;
import app.util.general.search.SearchResult;
import org.springframework.stereotype.Service;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import app.code.model.laptop.Processor;

@Service
public class ProcessorService extends CrudService<Processor, ProcessorRepo> {
    @PersistenceContext
    private EntityManager manager;

    // @Autowired
    // private SearchService<Processor,ProcessorFilter> searchService;

    public ProcessorService(ProcessorRepo repo, EntityManager manager) {
        super(repo, manager);
    }

    @Override
    public Class<Processor> getEntityClass() {
        return Processor.class;
    }

    // public SearchResult<Processor> search(ProcessorFilter filter, int page){
    // return searchService.search(manager,Processor.class, filter, page,
    // getPageSize());
    // }
    @Override
    public List<Processor> findAll() {
        return repo.findByActif(true);
    }

    @Override
    public void delete(Integer id) throws Exception {
        Processor entity = findById(id);
        entity.setActif(false);
        repo.save(entity);
    }

    public List<Processor> findByNameLike(String name) {
        return repo.findByNameIgnoreCaseLikeAndActif("%" + name + "%", true);
    }
}
