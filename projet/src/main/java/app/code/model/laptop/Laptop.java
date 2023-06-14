package app.code.model.laptop;

import app.util.general.model.HasId;
import app.util.general.search.Search;

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
import app.code.model.laptop.RomType;
import app.code.model.laptop.ScreenType;
import app.code.model.laptop.Brand;
import app.code.model.laptop.Processor;
import java.lang.Double;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "laptop")
public class Laptop extends GLaptop {

	@Search(column = { "actif" }, operator = "=")
	private Boolean actif = true;

	public Laptop(Integer id) {
		super(id);
	}

	@Transient
	@Search(column = { "reference", "description" }, operator = "like", condition = "and")
	private String keyword;

	public void setReference(String reference) throws Exception {
		if (reference == null || reference.isEmpty()) {
			throw new Exception("reference not valid");
		}
		this.reference = reference;
	}

	public void setScreenType(ScreenType screenType) throws Exception {
		if (screenType == null || screenType.getId() == null) {
			throw new Exception("screenType not valid");
		}
		this.screenType = screenType;
	}

	public void setProcessor(Processor p) throws Exception {
		if (p == null || p.getId() == null) {
			throw new Exception("processor not valid");
		}
		this.processor = p;
	}

	public void setBrand(Brand b) throws Exception {
		if (b == null || b.getId() == null) {
			throw new Exception("brand not valid");
		}
		this.brand = b;
	}

	public void setSizeScreen(Double sizeScreen) throws Exception {
		if (sizeScreen == null || sizeScreen <= 0) {
			throw new Exception("sizeScreen not valid");
		}
		this.sizeScreen = sizeScreen;
	}

	public void setRamSize(Integer ramSize) throws Exception {
		if (ramSize == null || ramSize <= 0) {
			throw new Exception("ramSize not valid");
		}
		this.ramSize = ramSize;
	}

	public void setRomSize(Integer romSize) throws Exception {
		if (romSize == null || romSize <= 0) {
			throw new Exception("romSize not valid");
		}
		this.romSize = romSize;
	}

	public void setRomType(RomType romType) throws Exception {
		if (romType == null || romType.getId() == null) {
			throw new Exception("romType not valid");
		}
		this.romType = romType;
	}

	public void setPrice(Double price) throws Exception {
		if (price == null || price <= 0) {
			throw new Exception("price not valid");
		}
		if (this.purchasePrice != null && this.purchasePrice > price) {
			throw new Exception("price is lower then purchase price");
		}
		this.price = price;
	}

	public void setPurchasePrice(Double price) throws Exception {
		if (price == null || price <= 0) {
			throw new Exception("purchase price not valid");
		}
		if (this.price != null && this.price < price) {
			throw new Exception("purchase price is higher then price");
		}
		this.purchasePrice = price;
	}
}
