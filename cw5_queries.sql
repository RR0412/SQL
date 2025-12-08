--1
SELECT
    product_name,
    SUM(quantity) as quantity
FROM products
INNER JOIN actions ON products.product_id = actions.product_id
INNER JOIN warehouses on warehouses.warehouse_id = actions.to_warehouse_id
WHERE warehouses.warehouse_id = 1
GROUP BY product_name
ORDER BY product_name;

--2
SELECT
    product_name,
    SUM(quantity) as quantity
FROM products  as p
INNER JOIN actions as a
ON p.product_id = a.product_id
WHERE action_date BETWEEN '2025-01-05'::DATE AND '2025-04-04'::DATE
AND movement_type = 'OUT'
AND from_warehouse_id = 1
GROUP BY product_name
ORDER BY product_name;

--3
SELECT
    category_name,
    SUM(quantity) as quantity
FROM categories as c
INNER JOIN products as p
ON c.category_id = p.category_id
INNER JOIN actions as a
ON a.product_id = p.product_id
WHERE to_warehouse_id = 3
AND  action_date BETWEEN '2025-01-05'::DATE AND '2025-04-04'::DATE
AND movement_type = 'IN'
GROUP BY category_name
ORDER BY category_name;

--4
SELECT
    COALESCE(b.brand_name, 'No Brand') as brand,
    SUM(quantity) as total
FROM brands as b
LEFT JOIN products as p
ON b.brand_id = p.brand_id
INNER JOIN actions as a.
ON a.product_id = p.product_id
WHERE to_warehouse_id = 1
AND action_date BETWEEN '2025-01-05'::DATE AND '2025-04-04'::DATE
AND movement_type = 'IN'
GROUP BY brand_name
ORDER BY brand_name;

--5
SELECT
    product_name,
    SUM(s.quantity) as total
FROM products as p
LEFT JOIN stock as s on p.product_id= s.product_id
LEFT JOIN actions as a on p.product_id = a.product_id
WHERE warehouse_id = 1
AND action_date = '2025-01-21'
GROUP BY product_name
ORDER BY product_name;

--6
SELECT
    product_name,
    SUM(quantity) as total
FROM products as p
LEFT JOIN actions as a
ON p.product_id = a.product_id
WHERE a.counter_party_id = 5
AND a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND a.movement_type = 'IN'
GROUP BY product_name
ORDER BY product_name;

--7
SELECT
    product_name,
    SUM(quantity) as total
FROM products as p
INNER JOIN actions as a
ON p.product_id = a.product_id
INNER JOIN warehouses as w
ON w.warehouse_id = a.to_warehouse_id
WHERE a.counter_party_id = 3
AND w.warehouse_name = 'Central Warehouse'
AND a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND movement_type = 'IN'
GROUP BY p.product_name
ORDER BY p.product_name;

--8
SELECT
    product_name,
    SUM(quantity) as total
FROM products as p
INNER JOIN actions as a
ON p.product_id = a.product_id
INNER JOIN warehouses as w
ON w.warehouse_id = a.from_warehouse_id
INNER JOIN counter_parties as c
ON c.counter_party_id = a.counter_party_id
WHERE w.warehouse_name = 'South Warehouse'
AND movement_type = 'OUT'
AND a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND counter_party_name = 'Global Trade'
GROUP BY p.product_name
ORDER BY product_name;


--9
SELECT
    counter_party_name,
    SUM(quantity) as total
FROM counter_parties as c
INNER JOIN actions as a
ON c.counter_party_id = a.counter_party_id
INNER JOIN products as p
ON a.product_id = p.product_id
WHERE a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND product_name = 'Hammer'
AND a.movement_type = 'IN'
GROUP BY counter_party_name
ORDER BY total DESC;

--10
SELECT
    counter_party_name,
    SUM(quantity) as total
FROM counter_parties as c
INNER JOIN actions as a
ON c.counter_party_id = a.counter_party_id
INNER JOIN products as p
ON a.product_id = p.product_id
WHERE a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND product_name = 'Hammer'
AND a.movement_type = 'OUT'
GROUP BY counter_party_name
ORDER BY total DESC;

--11
SELECT
    product_name,
    SUM(quantity) as total
FROM products AS p
INNER JOIN actions as a
ON p.product_id = a.product_id
INNER JOIN warehouses w_from ON
w_from.warehouse_id = a.from_warehouse_id
INNER JOIN warehouses w_to ON
w_to.warehouse_id = a.to_warehouse_id
WHERE w_to.warehouse_name = 'Central Warehouse'
AND a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND a.movement_type = 'TRANSIT'
GROUP BY product_name
ORDER BY product_name;

--12
SELECT
    product_name,
    SUM(quantity) as total
FROM products AS p
INNER JOIN actions as a
ON p.product_id = a.product_id
INNER JOIN warehouses w_from ON
w_from.warehouse_id = a.from_warehouse_id
INNER JOIN warehouses w_to ON
w_to.warehouse_id = a.to_warehouse_id
WHERE w_from.warehouse_name = 'Central Warehouse'
AND a.action_date BETWEEN '2025-01-05' AND '2025-04-04'
AND a.movement_type = 'TRANSIT'
GROUP BY product_name
ORDER BY product_name;








