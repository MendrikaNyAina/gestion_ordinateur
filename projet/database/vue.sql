
--apres les pertes, pas arrive=id dans dans receipt
--fonction pour avoir les transferts restants pas encore recus a une date
CREATE OR REPLACE FUNCTION f_transfert_restant(date_var date,store_var integer) 
RETURNS TABLE ( laptop_id integer, quantity integer) 
LANGUAGE sql
AS $$
     SELECT a.laptop_id,a.quantity as quantity FROM
     (select  laptop_id,sum( quantity) as quantity
     FROM transfert WHERE type=1 and date_transfert<=date_var and store_id=store_var 
     and id not in(select transfert_id from receipt) GROUP BY laptop_id) a 
$$;

--fonction pour avoir les transferts restants pas encore recus a une date, en tant que ligne de données pour de vrai
CREATE OR REPLACE FUNCTION f_transfert_restant_ligne(date_var date,store_var integer) 
RETURNS TABLE (id integer, laptop_id integer, quantity integer) 
LANGUAGE sql
AS $$
     select id, laptop_id, quantity 
     from transfert where type=1 and date_transfert<=date_var and store_id=store_var and id not in(select transfert_id from receipt);
$$;

--fonction pour avoir les renvoie restants, pas encore recu a une date
CREATE OR REPLACE FUNCTION f_renvoie_restant(date_var date) 
RETURNS TABLE ( laptop_id integer, quantity integer) 
LANGUAGE sql
AS $$
     SELECT a.laptop_id,a.quantity as quantity FROM
     (select  laptop_id,sum( quantity) as quantity
     FROM transfert WHERE type=2 and date_transfert<=date_var 
     and id not in(select transfert_id from receipt) GROUP BY laptop_id) a 
$$;
--fonction pour avoir les renvoie restants, pas encore recu a une date
CREATE OR REPLACE FUNCTION f_renvoie_restant_ligne(date_var date) 
RETURNS TABLE ( laptop_id integer, quantity integer) 
LANGUAGE sql
AS $$
     SELECT a.laptop_id,a.quantity as quantity FROM
     (select  laptop_id,sum( quantity) as quantity
     FROM transfert WHERE type=2 and date_transfert<=date_var 
     and id not in(select transfert_id from receipt) GROUP BY laptop_id) a 
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
     FROM receipt WHERE store_id=1 and date_receive<=date_var GROUP BY laptop_id) c 
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

select * from f_stock_magasin('2021-05-14',2);
--vue pour voir le stock dans le magasin central actuel
CREATE OR REPLACE VIEW v_central_stock AS
SELECT l.*,f.quantity  FROM f_central_stock(current_date) f, laptop l WHERE f.laptop_id=l.id;

--vue perte
CREATE OR REPLACE VIEW v_perte AS
SELECT t.laptop_id, t.quantity-r.quantity as quantity from transfert t, receipt r where t.id=r.id;

--vue pour avoir le stock actuel dun magasin
CREATE OR REPLACE VIEW v_stock_magasin as
SELECT l.*, a.quantity,a.store_id FROM laptop l, 
     (SELECT a.laptop_id, a.quantity-(coalesce(b.quantity, 0))-(coalesce(c.quantity,0)) as quantity, a.store_id FROM
     (select  laptop_id, sum( quantity) as quantity, store_id
     FROM receipt  GROUP BY laptop_id, store_id) a 
     LEFT JOIN
     (select laptop_id,sum( quantity) as quantity, store_id
     FROM transfert WHERE type=2 GROUP BY laptop_id, store_id) b 
     ON a.laptop_id=b.laptop_id and a.store_id=b.store_id LEFT JOIN
     (select d.laptop_id, sum(d.quantity) as quantity, store_id from sale s, sale_details d
     WHERE s.id=d.sale_id GROUP BY laptop_id, store_id) c
     ON a.laptop_id=c.laptop_id and a.store_id=c.store_id) a WHERE a.laptop_id=l.id;

--transfert et reception
CREATE OR REPLACE VIEW v_transfert_reception AS
SELECT t.id, t.laptop_id, t.quantity, t.date_transfert, t.store_id, t.type, r.date_receive, r.quantity as quantite_recu, 
t.quantity-r.quantity as perte
FROM transfert t, receipt r WHERE t.id=r.transfert_id;


--vue des ventes et details
CREATE OR REPLACE VIEW v_sale AS
SELECT l.reference, a.* from laptop l,
(SELECT d.*, s.client, s.date_sale, s.store_id, s.users_id, d.unit_price*d.quantity as total_price
FROM sale s, sale_details d WHERE s.id=d.sale_id)a
WHERE l.id=a.laptop_id;



--total des ventes par mois
CREATE OR REPLACE VIEW v_stat_vente_mois AS
SELECT 
EXTRACT(YEAR FROM date_sale) AS year,
EXTRACT(MONTH FROM date_sale) AS month,
sum(total_price) as total
FROM v_sale GROUP BY EXTRACT(YEAR FROM date_sale), EXTRACT(MONTH FROM date_sale);

--total des ventes par mois par magasin
CREATE OR REPLACE VIEW v_stat_vente_mois_magasin AS
SELECT 
EXTRACT(YEAR FROM date_sale) AS year,
EXTRACT(MONTH FROM date_sale) AS month,
sum(total_price) as total, store_id
FROM v_sale GROUP BY EXTRACT(YEAR FROM date_sale), EXTRACT(MONTH FROM date_sale), store_id;

--vrai total
SELECT m.year,m.month, COALESCE(s.total,0) from 
(SELECT
  EXTRACT(YEAR FROM month) AS year,
  EXTRACT(MONTH FROM month) AS month
FROM
  generate_series('2022-01-01'::date, '2023-12-31'::date, '1 month') AS month
)m LEFT JOIN v_stat_vente_mois_magasin s ON m.year=s.year and m.month=s.month;
  



--benefice par mois:
--total des vente-leur prix en achat-perte du mois
--perte du mois
CREATE OR REPLACE VIEW v_perte_mois AS
SELECT  sum(l.purchase_price*a.perte) as total_perte, a.month, a.year FROM laptop l,
(SELECT EXTRACT(month from t.date_receive)as month,EXTRACT(year from t.date_receive) as year, laptop_id, sum(perte) as perte
from v_transfert_reception t GROUP BY EXTRACT(month from t.date_receive),EXTRACT(year from t.date_receive), laptop_id) a
WHERE l.id=a.laptop_id GROUP BY a.month, a.year;

--achat du mois
CREATE OR REPLACE VIEW v_achat_mois AS
SELECT EXTRACT(month from c.date_add)as month,EXTRACT(year from c.date_add) as year, sum(l.purchase_price*c.quantity) as total_achat
 FROM central_stock c, laptop l WHERE c.laptop_id=l.id GROUP BY EXTRACT(month from c.date_add),EXTRACT(year from c.date_add);

--benefice par mois
SELECT row_number() over() as id, a.year, a.month, 'store' as store, 
(COALESCE(s.total, 0)-COALESCE(p.total_perte, 0)-COALESCE(c.total_achat,0)) as total from 
(SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month
FROM generate_series(cast('2022-01-01' as date), cast('2023-12-31' as date), '1 month') AS month )a
LEFT JOIN v_stat_vente_mois s ON a.year=s.year and a.month=s.month
LEFT JOIN v_perte_mois p ON a.year=p.year and a.month=p.month 
left join  v_achat_mois c ON a.year=c.year and a.month=c.month;

--benefice par mois? si c'est juste vente-perte
SELECT row_number() over() as id, a.year, a.month, 'store' as store, 
(COALESCE(s.total, 0)-COALESCE(p.total_perte, 0)) as total from 
(SELECT EXTRACT(YEAR FROM month) AS year, EXTRACT(MONTH FROM month) AS month
FROM generate_series(cast('2022-01-01' as date), cast('2023-12-31' as date), '1 month') AS month )a
LEFT JOIN v_stat_vente_mois s ON a.year=s.year and a.month=s.month
LEFT JOIN v_perte_mois p ON a.year=p.year and a.month=p.month;

