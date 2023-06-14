package app.code.model.settings;

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

import java.lang.Double;
import java.lang.Integer;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table
public class Commission extends HasId {
     public Commission(Integer id) {
          super(id);
     }

     private Double totalMax;
     private Double commission;
     private Double totalMin;

     public void setTotalMin(Double totalMin) throws Exception {
          if (totalMin == null || totalMin < 0) {
               throw new Exception("totalMin not valid, cant be null");
          }
          if (totalMin != null && totalMax != null && totalMin > totalMax) {
               throw new Exception("totalMin not valid, cant be greater than totalMax");
          }
          this.totalMin = totalMin;
     }

     public void setTotalMax(Double totalMax) throws Exception {
          if (totalMax != null && totalMax < 0) {
               throw new Exception("totalMax not valid");
          }
          if (totalMin != null && totalMax != null && totalMin > totalMax) {
               throw new Exception("totalMin not valid");
          }
          this.totalMax = totalMax;
     }

     public void setCommission(Double commission) throws Exception {
          if (commission == null || commission < 0) {
               throw new Exception("commission not valid");
          }
          this.commission = commission;
     }
}
