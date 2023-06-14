package app.code.model.sale;

import app.code.model.laptop.Laptop;
import app.util.general.model.HasId;
import app.util.general.search.Search;
import app.util.general.search.SearchTable;

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

import java.lang.String;
import java.lang.Integer;
import java.sql.Date;
import java.lang.Double;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "v_sale")
@SearchTable(order = { "dateSale desc", "client asc" })
public class VSale extends HasId {
	public VSale(Integer id) {
		super(id);
	}

	@Search(column = { "reference", "client" }, operator = "like", condition = "or")
	private String reference;
	private Integer saleId;
	@Search(column = { "storeId" }, operator = "=")
	private Integer storeId;
	private Date dateSale;
	private Integer quantity;
	private Double totalPrice;
	private String client;
	private Integer usersId;
	private Integer id;
	private Double unitPrice;
	@ManyToOne()
	@JoinColumn(name = "laptop_id")
	private Laptop laptop;

	@Transient
	@Search(column = { "totalPrice" }, operator = ">=")
	private Double priceMin;
	@Transient
	@Search(column = { "totalPrice" }, operator = "<=")
	private Double priceMax;

}
