-- 1-тапсырма. JOIN

-- 1-сұраныс. Клиенттер мен тапсырыстар
SELECT klient.aty, tapsyrys.zhalpy_soma
FROM klient
JOIN tapsyrys
ON klient.id = tapsyrys.klient_id;

-- 2-сұраныс. LEFT JOIN
SELECT klient.aty, tapsyrys.zhalpy_soma
FROM klient
LEFT JOIN tapsyrys
ON klient.id = tapsyrys.klient_id;

-- 3-сұраныс. Әр клиенттің тапсырыс саны
SELECT klient.aty, COUNT(tapsyrys.id)
FROM klient
JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 2-тапсырма. Бір жолды, бір бағанды ішкі сұраныстар

-- 1-сұраныс. Орташа бағадан қымбат тауарлар
SELECT *
FROM tauar
WHERE bagasy > (SELECT AVG(bagasy) FROM tauar);

-- 2-сұраныс. Ең қымбат тауар
SELECT *
FROM tauar
WHERE bagasy = (SELECT MAX(bagasy) FROM tauar);

-- 3-сұраныс. Ең арзан тауар
SELECT *
FROM tauar
WHERE bagasy = (SELECT MIN(bagasy) FROM tauar);

-- 3-тапсырма. Бірнеше жолды ішкі сұраныстар

-- 1-сұраныс. Тапсырыс жасаған клиенттер
SELECT *
FROM klient
WHERE id IN (SELECT klient_id FROM tapsyrys);

-- 2-сұраныс. Қымбат тауарлардың санаттары
SELECT *
FROM tauar
WHERE sanat IN (
    SELECT sanat
    FROM tauar
    WHERE bagasy > 100000
);

-- 3-сұраныс. Қымбат тапсырыс жасаған клиенттер
SELECT *
FROM klient
WHERE id IN (
    SELECT klient_id
    FROM tapsyrys
    WHERE zhalpy_soma > 400000
);

-- 4-тапсырма. CASE

-- 1-сұраныс. Тауарларды бағасына қарай бөлу
SELECT atauy, bagasy,
    CASE
        WHEN bagasy > 100000 THEN 'Qymbat'
        ELSE 'Arzan'
    END AS baga_turi
FROM tauar;

-- 2-сұраныс. Тапсырыстарды сомасына қарай бөлу
SELECT id, zhalpy_soma,
    CASE
        WHEN zhalpy_soma >= 400000 THEN 'Ulken'
        ELSE 'Kishi'
    END AS tapsyrys_turi
FROM tapsyrys;

-- 3-сұраныс. Тауарларды үш баға тобына бөлу
SELECT atauy, bagasy,
    CASE
        WHEN bagasy < 20000 THEN 'Arzan'
        WHEN bagasy < 400000 THEN 'Ortasha'
        ELSE 'Qymbat'
    END AS baga_turi
FROM tauar;

-- 5-тапсырма. Күрделі аналитикалық сұраныстар

-- 1-сұраныс. Әр клиенттің тапсырыстарының жалпы сомасы
SELECT klient.aty, SUM(tapsyrys.zhalpy_soma)
FROM klient
JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 2-сұраныс. Әр клиенттің орташа тапсырыс сомасы
SELECT klient.aty, AVG(tapsyrys.zhalpy_soma)
FROM klient
JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 3-сұраныс. Жалпы тапсырыс сомасы жоғары клиенттер
SELECT klient.aty, SUM(tapsyrys.zhalpy_soma)
FROM klient
JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty
HAVING SUM(tapsyrys.zhalpy_soma) > 400000;

