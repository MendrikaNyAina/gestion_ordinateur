----transfert
CREATE OR REPLACE VIEW v_transfert AS
select laptop_id, sum(quantity)quantity FROM transfert WHERE type=1 GROUP BY laptop_id;

--renvoie
CREATE OR REPLACE VIEW v_envoie AS
select laptop_id, sum(quantity)quantity FROM transfert WHERE type=2 GROUP BY laptop_id;

--renvoie
CREATE OR REPLACE VIEW v_renvoie_magasin AS
select laptop_id,store_id, sum(quantity)quantity FROM transfert WHERE type=2 GROUP BY laptop_id, store_id;

--transfert et renvoie par magasin
CREATE OR REPLACE VIEW v_transfert_magasin AS
select  laptop_id, store_id,sum( quantity) as quantity
FROM transfert WHERE type=1 GROUP BY laptop_id, store_id ;

--recu par magasin
CREATE OR REPLACE VIEW v_receipt_magasin AS
select  laptop_id, store_id,sum( quantity) as quantity
FROM receipt GROUP BY laptop_id, store_id ;

--vente par magasin
CREATE OR REPLACE VIEW v_sale_magasin AS
select  d.laptop_id, s.store_id,sum( d.quantity) as quantity FROM sale_details d, sale s WHERE d.sale_id=s.id

GROUP BY laptop_id, store_id ;

--ce qu'il y a dans le stock central actuellement
CREATE OR REPLACE VIEW v_central_stock as
SELECT  a.laptop_id, a.quantity-(coalesce(b.quantity, 0))+(coalesce(c.quantity,0)) as quantity FROM
(SELECT laptop_id,sum(quantity) as quantity,sum(unit_price)/count(laptop_id) as unit_price,  current_date as date_add 
from central_stock group by laptop_id)a 
 LEFT JOIN v_transfert b on a.laptop_id=b.laptop_id
LEFT JOIN v_envoie c on a.laptop_id=c.laptop_id;

--le stock qu'il y a dans le central
CREATE OR REPLACE VIEW v_stock as
SELECT l.*, t.quantity from laptop l, v_central_stock t where l.id=t.laptop_id;

--le stock en cours de transfert: transfert-recu
CREATE OR REPLACE VIEW v_transfert_restant as
SELECT row_number()over() as id, t.laptop_id, sum(t.quantity-r.quantity) as quantity, t.store_id
FROM v_transfert_magasin t LEFT JOIN v_receipt_magasin r 
ON t.laptop_id=r.laptop_id and t.store_id=r.store_id GROUP BY t.laptop_id,t.store_id;

--le stock dans chaque magasin, =recu-renvoie-vente
CREATE OR REPLACE VIEW v_stock_magasin as
SELECT l.*, re.store_id, coalesce(re.quantity,0)-coalesce(rv.quantity) as quantity  
from laptop l LEFT JOIN v_receipt_magasin re on
l.id=re.laptop_id  LEFT JOIN v_renvoie_magasin rv on re.laptop_id=rv.laptop_id and re.store_id=rv.store_id
 LEFT JOIN v_sale_magasin s on l.id=s.laptop_id and re.store_id=s.store_id;



--avant les pertes, ou pas arrive=perte
--fonction pour avoir te transfert en cours/ou perte restant a une date, pour chaque magasin
CREATE OR REPLACE FUNCTION f_transfert_restant(date_var date,store_var integer) 
RETURNS TABLE ( laptop_id integer, quantity integer) 
LANGUAGE sql
AS $$
     SELECT a.laptop_id,a.quantity-(COALESCE(b.quantity,0)) as quantity FROM
     (select  laptop_id,sum( quantity) as quantity
     FROM transfert WHERE type=1 and date_transfert<=date_var and store_id=store_var GROUP BY laptop_id) a LEFT JOIN
     (select  laptop_id, sum( quantity) as quantity
     FROM receipt  WHERE date_receive<=date_var and store_id=store_var GROUP BY laptop_id) b ON a.laptop_id=b.laptop_id
$$;

--fonction pour avoir le stock dans le magasin central a une date:
CREATE OR REPLACE FUNCTION f_central_stock(date_var date)
RETURNS TABLE (laptop_id integer, quantity integer)
LANGUAGE sql
AS $$
     select a.laptop_id, a.quantity-(coalesce(b.quantity, 0))+(coalesce(c.quantity,0)) as quantity FROM
     (select laptop_id,sum(quantity) as quantity from central_stock where date_add<=date_var group by laptop_id)a
     LEFT JOIN
     (select laptop_id,sum( quantity) as quantity 
     FROM transfert WHERE type=1 and date_transfert<=date_var GROUP BY laptop_id) b 
     ON a.laptop_id=b.laptop_id LEFT JOIN
     (select laptop_id,sum( quantity) as quantity
     FROM receipt WHERE store_id=1 and date_transfert<=date_var GROUP BY laptop_id) c 
     on a.laptop_id=c.laptop_id;
$$;

--fonction pour avoir le stock dans un point de vente a une date
CREATE OR REPLACE FUNCTION f_stock_magasin(date_var date, store_var INTEGER)
RETURNS TABLE (laptop_id integer,quantity integer)
LANGUAGE sql
AS $$
     SELECT a.laptop_id, a.quantity-(coalesce(b.quantity, 0))-(coalesce(c.quantity,0)) as quantity FROM
     (select  laptop_id, sum( quantity) as quantity
     FROM receipt  WHERE date_receive<=date_var and store_id=store_var GROUP BY laptop_id) a 
     LEFT JOIN
     (select laptop_id,sum( quantity) as quantity
     FROM transfert WHERE type=2 and date_transfert<=date_var and store_id=store_var GROUP BY laptop_id) b 
     ON a.laptop_id=b.laptop_id LEFT JOIN
     (select d.laptop_id, sum(d.quantity) as quantity from sale s, sale_details d
     WHERE s.id=d.sale_id and s.store_id=store_var and s.date_sale<=date_var GROUP BY laptop_id) c
     ON a.laptop_id=c.laptop_id;
$$;

-----------------------------------------------------------------------------------------------------------------


--benefice par mois si c'est juste par rapport au vente
--benefice de vente
CREATE OR REPLACE VIEW v_benefice_vente as 
SELECT  EXTRACT(month from v.date_sale)as month,EXTRACT(year from v.date_sale) as year,
 sum(v.total_price)-sum(v.quantity*l.purchase_price)as total from  v_sale v, laptop l WHERE v.laptop_id=l.id 
GROUP BY EXTRACT(month from v.date_sale),EXTRACT(year from v.date_sale);

--benefice par mois si cest juste par rapport au vente et perte
SELECT row_number() over() as id, a.year, a.month, 'store' as store, 
(COALESCE(s.total, 0)-COALESCE(p.total_perte, 0)) as total from 
(SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month
FROM generate_series(cast('2022-01-01' as date), cast('2023-12-31' as date), '1 month') AS month )a
LEFT JOIN v_benefice_vente s ON a.year=s.year and a.month=s.month
LEFT JOIN v_perte_mois p ON a.year=p.year and a.month=p.month ;
