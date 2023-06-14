package app.code.model.stock;

import app.util.general.model.HasId;
import javax.persistence.Entity;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.AccessLevel;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import java.lang.Long;
import java.lang.Integer;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "v_stock_magasin")
public class ModelStock extends HasId {
     public ModelStock(Integer id) {
          super(id);
     }

     private Long quantity;
     private Integer laptopId;
     private String reference;
     private Integer storeId;

}
