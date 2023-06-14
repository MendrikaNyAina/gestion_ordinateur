package app.code.model.laptop;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.Table;

import app.util.general.model.HasId;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor
@Getter

@MappedSuperclass
public class GLaptop extends HasId {
     public GLaptop(Integer id) {
          super(id);
     }

     protected String reference;
     protected Integer ramSize;
     protected String image;
     @ManyToOne()
     @JoinColumn(name = "rom_type_id")
     protected RomType romType;
     @ManyToOne()
     @JoinColumn(name = "screen_type_id")
     protected ScreenType screenType;
     protected String description;
     protected Integer romSize;
     @ManyToOne()
     @JoinColumn(name = "brand_id")
     protected Brand brand;
     @ManyToOne()
     @JoinColumn(name = "processor_id")
     protected Processor processor;
     protected Double sizeScreen;
     protected Double price;
     protected Double purchasePrice;

     public void setReference(String reference) throws Exception {
          this.reference = reference;
     }

     public void setRamSize(Integer ramSize) throws Exception {
          this.ramSize = ramSize;
     }

     public void setImage(String image) throws Exception {
          this.image = image;
     }

     public void setRomType(RomType romType) throws Exception {
          this.romType = romType;
     }

     public void setScreenType(ScreenType screenType) throws Exception {
          this.screenType = screenType;
     }

     public void setDescription(String description) throws Exception {
          this.description = description;
     }

     public void setRomSize(Integer romSize) throws Exception {
          this.romSize = romSize;
     }

     public void setBrand(Brand brand) throws Exception {
          this.brand = brand;
     }

     public void setProcessor(Processor processor) throws Exception {
          this.processor = processor;
     }

     public void setSizeScreen(Double sizeScreen) throws Exception {
          this.sizeScreen = sizeScreen;
     }

     public void setPrice(Double price) throws Exception {
          this.price = price;
     }
}
