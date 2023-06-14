package app.code.model.stock;

import app.util.general.model.HasId;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.AccessLevel;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import java.lang.Integer;
import java.sql.Date;

import app.code.model.laptop.Laptop;
import app.code.model.stock.CentralStock;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "transfert")
public class Transfert extends HasId {
	public Transfert(Integer id) {
		super(id);
	}

	private Integer storeId;
	private Date dateTransfert;
	private Integer usersId;
	@ManyToOne()
	@JoinColumn(name = "laptop_id")
	private Laptop laptop;
	private Integer quantity;
	private Integer type = 1;
	@OneToOne(mappedBy = "transfert", cascade = CascadeType.ALL, fetch = FetchType.LAZY, optional = true)
	private Receipt receipt;

	public Transfert(Integer storeid, Date send, Integer userId, CentralStock stock) {
		this.storeId = storeid;
		// this.userId = userId;
	}

	public void setStoreId(Integer storeId) throws Exception {
		if (storeId == null) {
			throw new Exception("storeId not valid");
		}
		this.storeId = storeId;
	}

	public void setDateTransfert(Date dateTransfert) throws Exception {
		if (dateTransfert == null) {
			throw new Exception("dateTransfert not valid");
		}
		this.dateTransfert = dateTransfert;
	}

	public void setUsersId(Integer usersId) throws Exception {
		if (usersId == null) {
			throw new Exception("usersId not valid");
		}
		this.usersId = usersId;
	}

	public void setLaptop(Laptop laptop) throws Exception {
		if (laptop == null) {
			throw new Exception("laptop not valid");
		}
		this.laptop = laptop;
	}

	public void setQuantity(Integer quantity) throws Exception {
		if (quantity == null || quantity <= 0) {
			throw new Exception("quantity not valid");
		}
		this.quantity = quantity;
	}

}
