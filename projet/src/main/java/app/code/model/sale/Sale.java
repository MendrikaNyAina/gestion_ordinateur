package app.code.model.sale;

import app.util.general.model.HasId;
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
import javax.persistence.OneToMany;

import java.sql.Date;
import java.util.List;
import java.lang.String;
import java.lang.Integer;
import java.lang.Double;
import app.code.model.user.Store;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "sale")
public class Sale extends HasId {
	public Sale(Integer id) {
		super(id);
	}

	private Date dateSale;
	private String client;
	private Integer usersId;
	private Double remise = 0.00;
	@ManyToOne()
	@JoinColumn(name = "store_id")
	private Store store;
	@OneToMany(mappedBy = "saleId", fetch = FetchType.LAZY)
	private List<SaleDetails> saleDetails;

}
