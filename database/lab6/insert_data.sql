USE Online_store_db;
GO
-- 1.Клиенттер
INSERT INTO klient (aty, email, telefon)
VALUES
('Aruzhan', 'aruzhan@gmail.com', '87011234567'),
('Aigerim', 'aigerim@gmail.com', '87021234567'),
('Dias', 'dias@gmail.com', '87031234567');

SELECT * FROM klient;
-- 2. Тауарлар
INSERT INTO tauar (atauy, bagasy)
VALUES
('Laptop', 350000),
('Smartphone', 180000),
('Headphones', 15000),
('Mouse', 5000),
('Keyboard', 12000);

SELECT * FROM tauar;
-- 3. Тапсырыстар
INSERT INTO tapsyrys
(martebesi, zhalpy_soma, klient_id)
VALUES
('Zhana', 350000, 1),
('Tolendi', 180000, 2),
('Zhetkizildi', 15000, 3);

SELECT * FROM tapsyrys;
-- 4. Төлем
INSERT INTO tolem
(soma, martebesi, tapsyrys_id)
VALUES
(350000, 'Kutilude', 1),
(180000, 'Tolendi', 2),
(15000, 'Tolendi', 3);

SELECT * FROM tolem;

-- 5. Zhetkizu
INSERT INTO zhetkizu
(martebesi, tapsyrys_id)
VALUES
('Kutilude', 1),
('Zholda', 2),
('Zhetkizildi', 3);

SELECT * FROM zhetkizu;
-- 6. Kuryer
INSERT INTO kuryer (aty, telefon)
VALUES
('Alibek', '87015554433'),
('Nursultan', '87027778899'),
('Dias', '87036665544');

SELECT * FROM kuryer;
-- 7. Zhinaktau nuktesi
INSERT INTO zhinaktau_nuktesi (mekenzhai)
VALUES
('Almaty, Abay 25'),
('Almaty, Dostyk 100'),
('Astana, Mangilik El 35');

SELECT * FROM zhinaktau_nuktesi;
-- 8. Qoima
INSERT INTO qoima (mekenzhai)
VALUES
('Almaty, Raimbek 150'),
('Almaty, Suyunbay 200'),
('Astana, Turan 45');

SELECT * FROM qoima;
-- 9. Qoima qory
INSERT INTO qoima_qory (qoima_id, tauar_id, sany)
VALUES
(1, 1, 10),
(1, 2, 15),
(2, 3, 25),
(2, 4, 30),
(3, 5, 20);

SELECT * FROM qoima_qory;
-- 10. Sebet
INSERT INTO sebet (klient_id)
VALUES
(1),
(2),
(3);

SELECT * FROM sebet;

-- 11. Sebet pozitsiyasy
INSERT INTO sebet_pozitsiyasy
(sebet_id, tauar_id, sany)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 4, 1),
(3, 5, 2);

SELECT * FROM sebet_pozitsiyasy;

-- 12. Tapsyrys pozitsiyasy
INSERT INTO tapsyrys_pozitsiyasy
(tapsyrys_id, tauar_id, sany, bagasy)
VALUES
(1, 1, 1, 350000),
(2, 2, 1, 180000),
(3, 3, 1, 15000);

SELECT * FROM tapsyrys_pozitsiyasy;

-- 13. Qateni tekseru
INSERT INTO error_check
(qate_turi, eskertu_matini, klient_rastady, tapsyrys_id)
VALUES
('Tolem qatesi', 'Tolem ali jasalmady', 0, 1),
('Mekenjai qatesi', 'Mekenjai durys emes', 1, 2),
('Tauar qatesi', 'Tauar tekserildi', 1, 3);

SELECT * FROM error_check;

-- 14. Zhetkizu zhospary
INSERT INTO delivery_plan
(martebesi, tapsyrys_id)
VALUES
('Zhosparlandy', 1),
('Zholda', 2),
('Ayaqtaldy', 3);

SELECT * FROM delivery_plan;

-- UPDATE
-- Tauar bagasyn ozgertu
UPDATE tauar
SET bagasy = 360000
WHERE id = 1;

SELECT * FROM tauar;

-- DELETE
-- Kuryerdi oshiru
DELETE FROM kuryer
WHERE id = 3;

SELECT * FROM kuryer;


