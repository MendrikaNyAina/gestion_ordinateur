package app.code.model.stock;

import app.code.model.laptop.GLaptop;
import app.util.general.model.HasId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.AccessLevel;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import java.sql.Date;
import java.lang.Long;
import java.lang.Double;
import java.lang.Integer;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "v_stock_magasin")
public class VStockMagasin extends GLaptop {
     private Integer quantity;
     private Integer storeId;
}
