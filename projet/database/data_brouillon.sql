INSERT INTO settings (id, name, "value") VALUES (1, 'TVA', 20),(2, 'Frais de livraison', 10000),(3, 'benefits', 0.3);
ALTER SEQUENCE settings_id_seq RESTART WITH 4;

INSERT INTO role (id, nom) VALUES (1, 'central'), (2, 'vendeur');
ALTER SEQUENCE role_id_seq RESTART WITH 3;

INSERT INTO brand(id, name) VALUES (1, 'Apple'), (2, 'Dell'), (3, 'HP'), (4, 'Lenovo'), (5, 'Asus');
ALTER SEQUENCE brand_id_seq RESTART WITH 6;

INSERT INTO processor (id, name, brand) VALUES (1, 'Intel Core i9-9900K', 'Intel'),
 (2, 'AMD Ryzen 7 3700X', 'AMD'),
 (3, 'Intel Core i7-10700K', 'Intel'),
 (4, 'AMD Ryzen 9 5900X', 'AMD'),
 (5, 'Intel Core i5-11600K', 'Intel'),
 (6, 'AMD Ryzen 5 5600X', 'AMD'),
 (7, 'Intel Core i3-10100', 'Intel'),
 (8, 'AMD Ryzen 3 3300X', 'AMD'),
 (9, 'Intel Core i9-11900K', 'Intel'),
 (10, 'AMD Ryzen 9 5950X', 'AMD');
ALTER SEQUENCE processor_id_seq RESTART WITH 11;


INSERT INTO chipset_graphic (id, name,brand) VALUES (1, 'NVIDIA GeForce RTX 3080', 'NVIDIA'),
(2, 'AMD Radeon RX 6900 XT', 'AMD'),
(3, 'NVIDIA GeForce RTX 3070', 'NVIDIA'),
(4, 'AMD Radeon RX 6800 XT', 'AMD'),
(5, 'NVIDIA GeForce GTX 1660 Ti', 'NVIDIA'),
(6, 'AMD Radeon RX 6700 XT', 'AMD'),
(7, 'NVIDIA GeForce RTX 3060', 'NVIDIA'),
(8, 'AMD Radeon RX 6600 XT', 'AMD'),
(9, 'NVIDIA GeForce GTX 1650 Super', 'NVIDIA'),
(10, 'AMD Radeon RX 6500 XT', 'AMD');
ALTER SEQUENCE chipset_graphic_id_seq RESTART WITH 11;


INSERT INTO operating_system (id, nom) VALUES 
(1, 'Windows 10'),
(2, 'Windows 8.1'),
(3, 'Windows 7'),
(4, 'Windows Server 2019'),
(5, 'macOS Mojave'),
(6, 'Ubuntu 20.04 LTS'),
(7, 'Chrome OS');
ALTER SEQUENCE operating_system_id_seq RESTART WITH 8;


INSERT INTO store (id, nom, description, adresse, role_id, contact, email, username, password) VALUES 
(1, 'Magasin Central', 'Centre pivot des magasins mikolo', 'Lot inconnu', 1, '0340000000', 'emailcentral@mikolo.com', 'admin', 'admin'),
(2, 'Magasin A', 'Description du Magasin A', 'Adresse du Magasin A', 2, 'Contact du Magasin A', 'emailA@mikolo.com', 'usernameA', 'passwordA'),
(3, 'Magasin B', 'Description du Magasin B', 'Adresse du Magasin B', 2, 'Contact du Magasin B', 'emailB@mikolo.com', 'usernameB', 'passwordB'),
(4, 'Magasin C', 'Description du Magasin C', 'Adresse du Magasin C', 2, 'Contact du Magasin C', 'emailC@mikolo.com', 'usernameC', 'passwordC'),
(5, 'Magasin D', 'Description du Magasin D', 'Adresse du Magasin D', 2, 'Contact du Magasin D', 'emailD@mikolo.com', 'usernameD', 'passwordD'),
(6, 'Magasin E', 'Description du Magasin E', 'Adresse du Magasin E', 2, 'Contact du Magasin E', 'emailE@mikolo.com', 'usernameE', 'passwordE'),
(7, 'Magasin F', 'Description du Magasin F', 'Adresse du Magasin F', 2, 'Contact du Magasin F', 'emailF@mikolo.com', 'usernameF', 'passwordF'),
(8, 'Magasin G', 'Description du Magasin G', 'Adresse du Magasin G', 2, 'Contact du Magasin G', 'emailG@mikolo.com', 'usernameG', 'passwordG'),
(9, 'Magasin H', 'Description du Magasin H', 'Adresse du Magasin H', 2, 'Contact du Magasin H',  'emailH@mikolo.com', 'usernameH', 'passwordH'),
(10, 'Magasin I', 'Description du Magasin I', 'Adresse du Magasin I', 2, 'Contact du Magasin I', 'emailI@mikolo.com', 'usernameI', 'passwordI'),
(11, 'Magasin J', 'Description du Magasin J', 'Adresse du Magasin J', 2, 'Contact du Magasin J', 'emailJ@mikolo.com', 'usernameJ', 'passwordJ');
ALTER SEQUENCE store_id_seq RESTART WITH 12;


--ce qu'il y a dans le stock actuellement
CREATE OR REPLACE VIEW v_stock as
SELECT l.*, t.quantity from laptop l,(
SELECT laptop_id, count(laptop_id) quantity from central_stock c  
WHERE id NOT IN (SELECT central_stock_id from transfert t WHERE t.status = 1 or t.status=2 or t.status=4)
GROUP BY laptop_id) t WHERE l.id = t.laptop_id;

--ce qu'il y a dans le stock actuellement, mouvement d'achat
CREATE OR REPLACE VIEW v_centralstock_current as
SELECT * from central_stock where id not in(select central_stock_id from transfert where status=1 or status=2 or status=4);


