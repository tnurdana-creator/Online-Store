--1-тапсырма:SELECT
SELECT * FROM products;

--2-тапсырма: WHERE
SELECT *
FROM products
WHERE price > 100000;


-- 3-тапсырма: Бірнеше шарт
SELECT *
FROM products
WHERE price > 10000 AND price < 300000;

--OR

-- 3-тапсырма: OR
SELECT *
FROM products
WHERE price < 10000 OR price > 300000;


-- 4-тапсырма: DISTINCT
SELECT DISTINCT status
FROM orders;


-- 5-тапсырма: ORDER BY
SELECT *
FROM products
ORDER BY price ASC;


-- Бағасы бойынша кему ретімен
SELECT *
FROM products
ORDER BY price DESC;


-- 6-тапсырма: GROUP BY
SELECT
    client_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY client_id
ORDER BY client_id;


-- 7-тапсырма: Агрегаттық функциялар
SELECT
    COUNT(*) AS product_count,
    SUM(price) AS total_price,
    AVG(price) AS average_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products;


-- 8-тапсырма: HAVING
SELECT
    client_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY client_id
HAVING COUNT(*) >= 1
ORDER BY client_id;


-- Аналитикалық сұраныс 1
-- Орташа бағадан қымбат тауарлар
SELECT name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;


-- Аналитикалық сұраныс 2
SELECT client_id, COUNT(*) AS order_count
FROM orders
GROUP BY client_id
ORDER BY order_count DESC;


-- Аналитикалық сұраныс 3
SELECT client_id, SUM(total_amount) AS total_amount
FROM orders
GROUP BY client_id
ORDER BY total_amount DESC;


-- Аналитикалық сұраныс 4
SELECT product_id, SUM(quantity) AS total_quantity
FROM warehouse_stock
GROUP BY product_id
ORDER BY total_quantity DESC;


-- Аналитикалық сұраныс 5
SELECT
    status,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_amount
FROM orders
GROUP BY status
HAVING COUNT(*) >= 1
ORDER BY order_count DESC;







