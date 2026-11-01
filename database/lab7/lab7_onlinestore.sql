-- 1-тапсырма. SELECT
SELECT * FROM tauar;

-- 2-тапсырма. WHERE
SELECT *
FROM tauar
WHERE bagasy > 100000;

-- 3-тапсырма. Бірнеше шарт: AND
SELECT *
FROM tauar
WHERE bagasy > 100000 AND bagasy < 500000;

-- Бірнеше шарт: OR
SELECT *
FROM tauar
WHERE atauy = 'Telefon' OR atauy = 'Noutbuk';

-- 4-тапсырма. DISTINCT
SELECT DISTINCT atauy
FROM tauar;

-- 5-тапсырма. ORDER BY
SELECT *
FROM tauar
ORDER BY bagasy ASC;

SELECT *
FROM tauar
ORDER BY bagasy DESC;

-- 6-тапсырма. GROUP BY
SELECT bagasy, COUNT(*)
FROM tauar
GROUP BY bagasy;

-- 7-тапсырма. Агрегаттық функциялар
SELECT
    COUNT(*),
    SUM(bagasy),
    AVG(bagasy),
    MIN(bagasy),
    MAX(bagasy)
FROM tauar;

-- 8-тапсырма. HAVING
SELECT bagasy, COUNT(*)
FROM tauar
GROUP BY bagasy
HAVING COUNT(*) > 0;


-- ПРАКТИКАЛЫҚ АНАЛИТИКАЛЫҚ СҰРАНЫСТАР

-- 1. Әр санаттағы тауарлар санын анықтау
SELECT sanat, COUNT(*)
FROM tauar
GROUP BY sanat;

-- 2. Орташа бағадан қымбат тауарларды анықтау
SELECT *
FROM tauar
WHERE bagasy > (SELECT AVG(bagasy) FROM tauar);

-- 3. Ең көп тапсырыс жасаған пайдаланушыларды анықтау
SELECT klient_id, COUNT(*)
FROM tapsyrys
GROUP BY klient_id
ORDER BY COUNT(*) DESC;

-- 4. Белгілі бір кезеңдегі тапсырыстар санын анықтау
SELECT COUNT(*)
FROM tapsyrys
WHERE kuni BETWEEN '2026-10-01' AND '2026-10-31';

-- 5. Тапсырыстардың жалпы сомасын анықтау
SELECT SUM(zhalpy_soma)
FROM tapsyrys;
