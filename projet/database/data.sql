INSERT INTO settings (id, name, "value") VALUES (1, 'TVA', 20),(2, 'Frais de livraison', 10000),(3, 'benefits', 0.3);
ALTER SEQUENCE settings_id_seq RESTART WITH 4;

INSERT INTO role (id, name) VALUES (1, 'central'), (2, 'vendeur');
ALTER SEQUENCE role_id_seq RESTART WITH 3;

INSERT INTO brand(id, name) VALUES (1, 'Apple'), (2, 'Dell'), (3, 'HP'), (4, 'Lenovo'), (5, 'Asus');
ALTER SEQUENCE brand_id_seq RESTART WITH 6;

INSERT INTO commission(id, total_min, total_max, commission)VALUES
(1,0,2000000, 0.03),
(2,2000001, 5000000,0.08),
(3,5000001, 300000000, 0.15);
ALTER SEQUENCE commission_id_seq RESTART WITH 4;


INSERT INTO store (id, name, description, address, role_id, contact, email) VALUES 
(1, 'Magasin Central', 'Centre pivot des magasins mikolo', 'Lot inconnu', 1, '0340000000', 'emailcentral@mikolo.com'),
(2, 'Magasin A', 'Description du Magasin A', 'Adresse du Magasin A', 2, '0340000001', 'emailA@mikolo.com'),
(3, 'Magasin B', 'Description du Magasin B', 'Adresse du Magasin B', 2, '0340000002', 'emailB@mikolo.com'),
(4, 'Magasin C', 'Description du Magasin C', 'Adresse du Magasin C', 2, '0340000003', 'emailC@mikolo.com'),
(5, 'Magasin D', 'Description du Magasin D', 'Adresse du Magasin D', 2, '0340000004', 'emailD@mikolo.com'),
(6, 'Magasin E', 'Description du Magasin E', 'Adresse du Magasin E', 2, '0340000005', 'emailE@mikolo.com'),
(7, 'Magasin F', 'Description du Magasin F', 'Adresse du Magasin F', 2, '0340000006', 'emailF@mikolo.com'),
(8, 'Magasin G', 'Description du Magasin G', 'Adresse du Magasin G', 2, '0340000007', 'emailG@mikolo.com'),
(9, 'Magasin H', 'Description du Magasin H', 'Adresse du Magasin H', 2, '0340000008',  'emailH@mikolo.com'),
(10, 'Magasin I', 'Description du Magasin I', 'Adresse du Magasin I', 2, '0340000009', 'emailI@mikolo.com'),
(11, 'Magasin J', 'Description du Magasin J', 'Adresse du Magasin J', 2, '0340000010', 'emailJ@mikolo.com');
ALTER SEQUENCE store_id_seq RESTART WITH 12;

INSERT INTO users(id, username, password, store_id) VALUES 
(1, 'admin', 'admin', 1),
(2, 'vendeur2', 'vendeur2', 2),
(3, 'vendeur3', 'vendeur3', 3),
(4, 'vendeur4', 'vendeur4',4),
(5, 'vendeur5', 'vendeur5',5),
(6, 'vendeur6', 'vendeur6',6),
(7, 'vendeur7', 'vendeur7',7),
(8, 'vendeur8', 'vendeur8',8),
(9, 'vendeur9', 'vendeur9',9),
(10, 'vendeur10', 'vendeur10',10),
(11, 'vendeur11', 'vendeur11',11);
ALTER SEQUENCE users_id_seq RESTART WITH 12;

INSERT INTO processor(id, name) VALUES
(1, 'Intel Core i9-9900K'),
 (2, 'AMD Ryzen 7 3700X'),
 (3, 'Intel Core i7-10700K'),
 (4, 'AMD Ryzen 9 5900X'),
 (5, 'Intel Core i5-11600K'),
 (6, 'AMD Ryzen 5 5600X'),
 (7, 'Intel Core i3-10100'),
 (8, 'AMD Ryzen 3 3300X'),
 (9, 'Intel Core i9-11900K'),
 (10, 'AMD Ryzen 9 5950X');
ALTER SEQUENCE processor_id_seq RESTART WITH 11;

 INSERT INTO screen_type(id, name) VALUES
 (1, 'LED'),
 (2, 'OLED'),
 (3, 'tactile');
ALTER SEQUENCE screen_type_id_seq RESTART WITH 4;

 INSERT INTO rom_type(id, name) VALUES
 (1, 'HDD'),
 (2, 'SSD');
ALTER SEQUENCE rom_type_id_seq RESTART WITH 12;



INSERT INTO laptop(id, reference, description,processor_id,  brand_id, screen_type_id, size_screen, ram_size, rom_size, rom_type_id, price, purchase_price) VALUES
(1, 'APPLE_XD1FFG', 'Description de l''ordinateur 1', 1,1, 1,18, 8, 256, 1, 1000.00, 900.00),
(2, 'DELL_KL5D9P', 'Description de l''ordinateur 2',2, 2, 2,17, 16, 512, 2, 1500.00, 1300.00),
(3, 'HP_HJ7G4E', 'Description de l''ordinateur 3', 3,3, 3, 4,16, 128, 1, 800.00, 700.00),
(4, 'LENOVO_JU2D1K', 'Description de l''ordinateur 4',4, 4, 1,18, 8, 256, 2, 1200.00, 1100.00),
(5, 'ASUS_GD5S9L', 'Description de l''ordinateur 5',5, 5, 2, 16,17, 512, 1, 1400.00, 1200.00),
(6, 'APPLE_WD8SF1', 'Description de l''ordinateur 6',6, 1, 3, 4,16, 128, 2, 900.00, 800.00),
(7, 'DELL_PT6J5G', 'Description de l''ordinateur 7',7, 2, 1, 8,18, 256, 1, 1100.00, 1000.00),
(8, 'HP_FD2P4R', 'Description de l''ordinateur 8',8, 3, 2,18, 16, 512, 2, 1300.00, 1100.00),
(9, 'LENOVO_YF9D3S', 'Description de l''ordinateur 9',9, 4, 3,17, 4, 128, 1, 1000.00, 900.00),
(10, 'ASUS_MK1F3L', 'Description de l''ordinateur 10',10, 5, 1,15, 8, 256, 2, 1200.00, 1000.00),
(11, 'APPLE_PQ6D8R', 'Description de l''ordinateur 11',1, 1, 2,14, 16, 512, 1, 1300.00, 1200.00),
(12, 'DELL_GF2S6P', 'Description de l''ordinateur 12',2, 2, 3,16, 4, 128, 2, 900.00, 800.00),
(13, 'HP_KJ4G5F', 'Description de l''ordinateur 13',3, 3, 1,15, 8, 256, 1, 1100.00, 1000.00);
ALTER SEQUENCE laptop_id_seq RESTART WITH 14;

INSERT INTO central_stock(id, laptop_id, date_add, quantity) VALUES
(1,1,'2022-01-01',10),
(2,2,'2022-01-01',10),
(3,3,'2022-01-01',10),
(4,4,'2022-01-01',10),
(5,5,'2022-01-01',10),
(6,6,'2022-01-01',10),
(7,7,'2022-01-01',10),
(8,8,'2022-01-01',10),
(9,9,'2022-01-01',10),
(10,10,'2022-01-01',10);
ALTER SEQUENCE central_stock_id_seq RESTART WITH 11;


INSERT INTO transfert(id,laptop_id, date_transfert, store_id, users_id, type, quantity )VALUES
(1,1,'2022-01-02',2,1,1,5),
(2,2,'2022-01-02',2,1,1,5),
(3,3,'2022-01-02',2,1,1,5),
(4,4,'2022-01-02',2,1,1,5),
(5,5,'2022-01-02',2,1,1,5),
(6,6,'2022-01-02',2,1,1,5),
(7,7,'2022-01-02',2,1,1,5),
(8,8,'2022-01-02',2,1,1,5),
(9,9,'2022-01-02',2,1,1,5),
(10,10,'2022-01-02',2,1,1,5);
ALTER SEQUENCE transfert_id_seq RESTART WITH 11;


INSERT INTO receipt(id,laptop_id, quantity, date_receive, users_id, store_id, transfert_id)VALUES
(1,1,5,'2022-01-03',2,2,1),
(2,2,5,'2022-01-03',2,2,2),
(3,3,5,'2022-01-03',2,2,3),
(4,4,5,'2022-01-03',2,2,4),
(5,5,5,'2022-01-03',2,2,5),
(6,6,5,'2022-01-03',2,2,6),
(7,7,4,'2022-01-03',2,2,7),
(8,8,4,'2022-01-03',2,2,8),
(9,9,4,'2022-01-03',2,2,9);
ALTER SEQUENCE receipt_id_seq RESTART WITH 10;


INSERT INTO sale(id, client, date_sale, store_id, users_id) VALUES
(1,'Jean', '2022-01-04',2,2),
(2,'Capucin', '2022-02-04',2,2),
(3,'George', '2022-03-04',2,2),
(4,'Jean', '2022-04-04',3,3),
(5,'Capucin', '2022-05-04',3,3),
(6,'George', '2022-06-04',3,3);
ALTER SEQUENCE sale_id_seq RESTART WITH 7;


INSERT INTO sale_details(id, sale_id, laptop_id, quantity, unit_price) VALUES
(1,1,1,1,1000.00),
(2,1,2,1,1500.00),
(3,1,3,1,800.00),
(4,1,4,1,1200.00),
(5,1,5,1,1400.00),
(6,1,6,1,900.00),
(7,1,7,1,1100.00),
(8,1,8,1,1300.00),
(9,1,9,1,1000.00),
(11,2,1,1,1000.00),
(12,2,2,1,1500.00),
(13,2,3,1,800.00),
(14,2,4,1,1200.00),
(15,2,5,1,1400.00),
(16,2,6,1,900.00),
(17,2,7,1,1100.00),
(18,2,8,1,1300.00),
(19,2,9,1,1000.00),
(21,3,1,1,1000.00),
(22,3,2,1,1500.00),
(23,3,3,1,800.00),
(24,3,4,1,1200.00),
(25,3,5,1,1400.00),
(26,3,6,1,900.00),
(27,3,7,1,1100.00),
(28,3,8,1,1300.00),
(29,3,9,1,1000.00);
ALTER SEQUENCE sale_details_id_seq RESTART WITH 30;


--user
--commission
--romttype
