package app.code.model.laptop;

import app.util.general.model.HasId;
import javax.persistence.Entity;
import javax.persistence.Table;
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
@Table(name = "processor")
public class Processor extends HasId {
     private Boolean actif = true;

     public Processor(Integer id) {
          super(id);
     }

     private String name;

}
