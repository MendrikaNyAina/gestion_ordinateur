package app.code.model.stock;

import app.util.general.model.HasId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.AccessLevel;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import java.sql.Date;
import java.time.LocalDate;
import java.lang.Integer;
import java.lang.Double;
import app.code.model.laptop.Laptop;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "central_stock")
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class CentralStock extends HasId implements Cloneable {
	public CentralStock(Integer id) {
		super(id);
	}

	private Date dateAdd;
	@ManyToOne()
	@JoinColumn(name = "laptop_id")
	private Laptop laptop;
	private Integer quantity;

	public void setDateAdd(Date dateAdd) throws Exception {
		if (dateAdd == null) {
			throw new Exception("dateAdd not valid");
		}
		this.dateAdd = dateAdd;
	}

	public void setLaptop(Laptop l) throws Exception {
		if (l == null || l.getId() == null) {
			throw new Exception("laptop not valid");
		}
		this.laptop = l;
	}

	public void setQuantity(Integer q) throws Exception {
		if (q == null || q < 0) {
			throw new Exception("quantity not valid");
		}
		this.quantity = q;
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

}
