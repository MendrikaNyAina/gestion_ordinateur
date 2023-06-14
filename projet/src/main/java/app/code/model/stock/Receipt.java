package app.code.model.stock;

import app.util.general.model.HasFK;
import app.util.general.exception.CustomException;
import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.AccessLevel;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;

import java.lang.Integer;
import java.sql.Date;

import app.code.model.laptop.Laptop;
import app.code.model.user.Store;

@Getter
@Setter
@Entity
@Table(name = "receipt")
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
public class Receipt extends HasFK<app.code.model.user.Store> {

    private Integer quantity;
    private Integer storeId;
    private Date dateReceive;
    @ManyToOne()
    @JoinColumn(name = "laptop_id")
    private Laptop laptop;
    private Integer usersId;
    @OneToOne
    @JoinColumn(name = "transfert_id", nullable = false)
    private Transfert transfert;

    @Override
    public void setFK(app.code.model.user.Store fk) throws CustomException {
        if (fk == null || fk.getId() == null) {
            throw new CustomException("app.code.model.user.Store is null");
        }
        setStoreId(fk.getId().intValue());
    }
}
