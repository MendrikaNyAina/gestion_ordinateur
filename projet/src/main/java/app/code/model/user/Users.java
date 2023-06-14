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
import app.code.model.user.Store;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "users")
public class Users extends HasId {
	private Boolean actif = true;

	public Users(Integer id) {
		super(id);
	}

	private String password;
	@ManyToOne
	@JoinColumn(name = "store_id")
	private Store store;
	private String username;
	@Transient
	@Search(column = { "id" }, operator = "!=")
	private Integer storeAdmin;

	public void setPassword(String password) throws Exception {
		// System.out.println("password: " + password);
		if (password == null || password.equals("")) {
			throw new Exception("Password not valid, must be at least 5 characters");
		}
		this.password = password;
	}

	public void setUsername(String us) throws Exception {
		// System.out.println("username: " + us);
		if (us == null || us.equals("")) {
			throw new Exception("Username not valid, must be at least 5 characters");
		}
		this.username = us;
	}

	public void setStore(Store store) {
		this.store = store;
	}
}
