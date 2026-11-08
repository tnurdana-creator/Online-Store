
USE Online_store_db;
GO
-- 1-ТАПСЫРМА. КЕСТЕЛЕРДІ БІРІКТІРУ (JOIN)
-- 1-сұраныс. Клиенттер мен тапсырыстарды біріктіру
SELECT
    klient.aty,
    tapsyrys.zhalpy_soma,
    tapsyrys.martebesi
FROM klient
INNER JOIN tapsyrys
ON klient.id = tapsyrys.klient_id;

-- 2-сұраныс. LEFT JOIN арқылы кестелерді біріктіру
SELECT
    klient.aty,
    tapsyrys.zhalpy_soma
FROM klient
LEFT JOIN tapsyrys
ON klient.id = tapsyrys.klient_id;

-- 3-сұраныс. Әр клиенттің тапсырыстар санын анықтау
SELECT
    klient.aty,
    COUNT(tapsyrys.id) AS tapsyrys_sany
FROM klient
LEFT JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 2-ТАПСЫРМА. БІР ЖОЛДЫ, БІР БАҒАНДЫ ІШКІ СҰРАНЫСТАР
-- 1-сұраныс. Орташа бағадан қымбат тауарларды анықтау
SELECT *
FROM tauar
WHERE bagasy > (
    SELECT AVG(bagasy)
    FROM tauar
);

-- 2-сұраныс. Ең қымбат тауарды анықтау
SELECT *
FROM tauar
WHERE bagasy = (
    SELECT MAX(bagasy)
    FROM tauar
);

-- 3-сұраныс. Ең арзан тауарды анықтау
SELECT *
FROM tauar
WHERE bagasy = (
    SELECT MIN(bagasy)
    FROM tauar
);

-- 3-ТАПСЫРМА. БІРНЕШЕ ЖОЛДЫ ІШКІ СҰРАНЫСТАР

-- 1-сұраныс. Тапсырыс жасаған клиенттерді анықтау
SELECT *
FROM klient
WHERE id IN (
    SELECT klient_id
    FROM tapsyrys
);

-- 2-сұраныс. Қымбат тауарлары бар тапсырыстарды анықтау
SELECT *
FROM tapsyrys
WHERE id IN (
    SELECT tapsyrys_id
    FROM tapsyrys_pozitsiyasy
    WHERE tauar_id IN (
        SELECT id
        FROM tauar
        WHERE bagasy > 100000
    )
);

-- 3-сұраныс. Қымбат тапсырыс жасаған клиенттерді анықтау
SELECT *
FROM klient
WHERE id IN (
    SELECT klient_id
    FROM tapsyrys
    WHERE zhalpy_soma > 100000
);

-- 4-ТАПСЫРМА. CASE АРҚЫЛЫ ШАРТТЫ МӘНДЕРДІ ҚАЛЫПТАСТЫРУ
-- 1-сұраныс. Тауарларды бағасына қарай бөлу
SELECT
    atauy,
    bagasy,
    CASE
        WHEN bagasy > 100000 THEN 'Qymbat'
        ELSE 'Arzan'
    END AS baga_turi
FROM tauar;

-- 2-сұраныс. Тапсырыстарды сомасына қарай бөлу
SELECT
    id,
    zhalpy_soma,
    CASE
        WHEN zhalpy_soma >= 100000 THEN 'Ulken'
        ELSE 'Kishi'
    END AS tapsyrys_turi
FROM tapsyrys;

-- 3-сұраныс. Тауарларды үш баға тобына бөлу
SELECT
    atauy,
    bagasy,
    CASE
        WHEN bagasy < 20000 THEN 'Arzan'
        WHEN bagasy < 200000 THEN 'Ortasha'
        ELSE 'Qymbat'
    END AS baga_turi
FROM tauar;

-- 5-ТАПСЫРМА. КҮРДЕЛІ АНАЛИТИКАЛЫҚ СҰРАНЫСТАР
-- 1-сұраныс. Әр клиенттің тапсырыстарының жалпы сомасын анықтау
SELECT
    klient.aty,
    SUM(tapsyrys.zhalpy_soma) AS zhalpy_soma
FROM klient
INNER JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 2-сұраныс. Әр клиенттің орташа тапсырыс сомасын анықтау
SELECT
    klient.aty,
    AVG(tapsyrys.zhalpy_soma) AS ortasha_soma
FROM klient
INNER JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty;

-- 3-сұраныс. Жалпы тапсырыс сомасы жоғары клиенттерді анықтау
SELECT
    klient.aty,
    SUM(tapsyrys.zhalpy_soma) AS zhalpy_soma
FROM klient
INNER JOIN tapsyrys
ON klient.id = tapsyrys.klient_id
GROUP BY klient.id, klient.aty
HAVING SUM(tapsyrys.zhalpy_soma) > 100000;

