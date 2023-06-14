package app.code.model.stock;

import app.util.general.search.Search;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockFilter {
     @Search(column = { "reference", "description" }, operator = "like", condition = "or")
     private String keyword;

     @Search(column = "brand", operator = "in", condition = "or", isEntity = true)
     private Integer[] brand;

     @Search(column = "processor", operator = "in", condition = "or", isEntity = true)
     private Integer[] processor;

     @Search(column = "screen_type", operator = "=", condition = "or", isEntity = true)
     private Integer[] screenType;

     @Search(column = "ramSize", operator = ">=", condition = "and")
     private Integer ramMin;

     @Search(column = "ramSize", operator = "<=", condition = "and")
     private Integer ramMax;

     @Search(column = "romSize", operator = ">=", condition = "and")
     private Integer romMin;

     @Search(column = "romSize", operator = "<=", condition = "and")
     private Integer romMax;

     @Search(column = "price", operator = ">=", condition = "and")
     private Double priceMin;

     @Search(column = "price", operator = "<=", condition = "and")
     private Double priceMax;

     @Search(column = "sizeScreen", operator = ">=", condition = "and")
     private Double screenSizeMin;

     @Search(column = "sizeScreen", operator = "<=", condition = "and")
     private Double screenSizeMax;

     @Search(column = { "id" }, operator = "in")
     private Integer[] ids;

     @Search(column = "storeId", operator = "=", condition = "and")
     private Integer storeId;

     @Search(column = "romType", operator = "=", condition = "and")
     private Integer romType;
}
