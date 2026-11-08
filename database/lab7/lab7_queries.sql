USE Online_store_db;
GO
-- 1-tapsyrma. SELECT
SELECT * FROM tauar;

-- 2-tapsyrma. WHERE
SELECT *
FROM tauar
WHERE bagasy > 100000;

-- 3-tapsyrma. AND
SELECT *
FROM tauar
WHERE bagasy > 100000 AND bagasy < 500000;

-- OR
SELECT *
FROM tauar
WHERE atauy = 'Laptop' OR atauy = 'Smartphone';

-- 4-tapsyrma. DISTINCT
SELECT DISTINCT atauy
FROM tauar;

-- 5-tapsyrma. ORDER BY
SELECT *
FROM tauar
ORDER BY bagasy ASC;

SELECT *
FROM tauar
ORDER BY bagasy DESC;

-- 6-tapsyrma. GROUP BY
SELECT bagasy, COUNT(*) AS tauar_sany
FROM tauar
GROUP BY bagasy;

-- 7-tapsyrma. Agregattyq funktsiyalar
SELECT
    COUNT(*) AS tauar_sany,
    SUM(bagasy) AS zhalpy_baga,
    AVG(bagasy) AS ortasha_baga,
    MIN(bagasy) AS en_tomen_baga,
    MAX(bagasy) AS en_zhogary_baga
FROM tauar;

-- 8-tapsyrma. HAVING
SELECT klient_id, COUNT(*) AS tapsyrys_sany
FROM tapsyrys
GROUP BY klient_id
HAVING COUNT(*) >= 1;


-- PRAKTIKALYQ ANALITIKALYQ SURANYSTAR

-- 1. Bagasy 100000-nan zhogary tauarlar
SELECT *
FROM tauar
WHERE bagasy > 100000;

-- 2. Ortasha bagadan qymbat tauarlar
SELECT *
FROM tauar
WHERE bagasy > (
    SELECT AVG(bagasy) FROM tauar
);

-- 3. En kop tapsyrys zhasagan klientter
SELECT klient_id, COUNT(*) AS tapsyrys_sany
FROM tapsyrys
GROUP BY klient_id
ORDER BY tapsyrys_sany DESC;

-- 4. Tapsyrystar martebesi boiynsha sany
SELECT martebesi, COUNT(*) AS tapsyrys_sany
FROM tapsyrys
GROUP BY martebesi;

-- 5. Tapsyrystardyn zhalpy somasy
SELECT SUM(zhalpy_soma) AS zhalpy_soma
FROM tapsyrys;
