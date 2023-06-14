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

import java.lang.Integer;
import java.util.List;
import java.lang.Double;
import app.code.model.laptop.Laptop;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "sale_details")
public class SaleDetails extends HasId {
	public SaleDetails(Integer id) {
		super(id);
	}

	private Integer saleId;
	private Integer quantity;
	private Double unitPrice;
	@ManyToOne()
	@JoinColumn(name = "laptop_id")
	private Laptop laptop;

}
