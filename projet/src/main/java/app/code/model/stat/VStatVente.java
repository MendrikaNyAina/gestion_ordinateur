package app.code.model.stat;

import app.util.general.model.HasId;
import app.util.general.stat.Stat;

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

import java.lang.Integer;
import java.lang.Double;
import java.math.BigDecimal;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "v_stat_vente_mois_magasin")
public class VStatVente extends HasId implements Stat {
	public VStatVente(Integer id) {
		super(id);
	}

	@Transient
	private boolean parmonth = true;
	private String store;
	private Double total;
	private Integer month;
	private Integer year;
	@Transient
	private Double commission;
	@Transient
	private Double vente;

	@Override
	public Double getData() {
		return total;
	}

	@Override
	public String getLabel() {
		if (parmonth) {
			return year + "/" + month;
		} else {
			return store;
		}
	}

	@Override
	public String getName() {
		if (parmonth) {
			return store;
		} else {
			return year + "/" + month;
		}
	}

	public String getMonthInt() {
		if (month < 10) {
			return "0" + month;
		}
		return month + "";
	}
}
