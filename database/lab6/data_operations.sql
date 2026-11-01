-- Klient kosu
INSERT INTO klient (aty, email, telefon)
VALUES ('Aruzhan', 'aruzhan@gmail.com', '87011234567');

-- Klienttin telefonyn ozgertu
UPDATE klient
SET telefon = '87075554433'
WHERE email = 'aruzhan@gmail.com';

-- Klientti oshiru
DELETE FROM klient
WHERE email = 'aruzhan@gmail.com';
