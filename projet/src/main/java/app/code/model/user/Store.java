package app.code.model.user;

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

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "store")
public class Store extends HasId {
	public Store(Integer id) {
		super(id);
	}

	private String address;
	@ManyToOne
	@JoinColumn(name = "role_id")
	private Role role;
	private String contact;
	private String name;
	private String description;
	private String email;
	@Transient
	@Search(column = { "role" }, operator = "!=", isEntity = true)
	private Integer roleAdmin;
	@Search(column = { "actif" }, operator = "=")
	private Boolean actif = true;

	@Transient
	@Search(column = { "email", "contact", "description", "name", "address" }, operator = "like", condition = "or")
	private String keyword;

	public void setContact(String contact) throws Exception {
		if (contact == null || contact.length() < 3) {
			throw new Exception("Contact must be 10 or 11 digits");
		}
		this.contact = contact;
	}

	public void setName(String name) throws Exception {
		if (name == null || name.length() < 3) {
			throw new Exception("Name must be at least 3 characters");
		}
		this.name = name;
	}

	public void setEmail(String email) throws Exception {
		if (email == null || email.length() < 3) {
			throw new Exception("Email must be at least 3 characters");
		}
		this.email = email;
	}

	public void setAddress(String address) throws Exception {
		if (address == null || address.length() < 3) {
			throw new Exception("Address must be at least 3 characters");
		}
		this.address = address;
	}
}
