SELECT * FROM sales.orders;

SELECT TOP(10) *
FROM sales.orders;

select *
from sales.orders
order by order_id
OFFSET 10 ROW;

select *
from sales.orders
order by order_id
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

select *
from sales.orders
order by order_id
OFFSET 10 ROWS
FETCH FIRST 10 ROWS ONLY;

select * from production.products;

select TOP(10) * 
from production.products
ORDER BY list_price DESC;

select * 
from production.products
ORDER BY list_price DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM production.products
WHERE list_price IN (6499.99, 5499.99);

select * from sales.orders;

SELECT *
FROM sales.orders
WHERE order_date IN ('2016-01-04', '2017-11-07', '2017-12-01');

SELECT *
FROM sales.orders
WHERE order_date BETWEEN '2016-01-04' AND '2016-01-14';

select * 
from sales.customers
where first_name LIKE 'S%';


select * 
from sales.customers
where first_name LIKE '%es';

select * 
from sales.customers
where first_name LIKE 'S%er';

select * 
from sales.customers
where first_name LIKE '__t%';

select * 
from sales.customers
where first_name LIKE '[AC]%';

select * 
from sales.customers
where first_name LIKE '[A-E]%';

select * 
from sales.customers
where first_name NOT LIKE '[A-E]%';

CREATE TABLE sales.feedbacks (
  feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
  comment VARCHAR(255) NOT NULL
);

INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');

select * from sales.feedbacks;

select *
from sales.feedbacks
where comment LIKE '%30!%%' ESCAPE '!';

select *
from [sales].[customers]
where first_name LIKE '[A-J]%e_';


SELECT first_name, last_name
FROM sales.customers
ORDER BY first_name;

SELECT first_name + ' ' + last_name AS full_name
FROM sales.customers
ORDER BY first_name;

SELECT first_name + ' ' + last_name full_name
FROM sales.customers
ORDER BY first_name;

-- JOINS In SQL Server
CREATE SCHEMA hr;
GO

CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

select * from hr.candidates;
select * from hr.employees;

SELECT *
FROM hr.candidates c
INNER JOIN hr.employees e
	ON c.fullname = e.fullname;

SELECT c.id, c.fullname, e.fullname
FROM hr.candidates c
INNER JOIN hr.employees e
	ON c.fullname = e.fullname;

SELECT *
FROM hr.candidates c
LEFT JOIN hr.employees e
	ON c.fullname = e.fullname;

SELECT *
FROM hr.candidates c
LEFT JOIN hr.employees e
	ON c.fullname = e.fullname
WHERE e.id IS NULL;

SELECT *
FROM hr.candidates c
RIGHT JOIN hr.employees e
	ON c.fullname = e.fullname;

SELECT *
FROM hr.candidates c
RIGHT JOIN hr.employees e
	ON c.fullname = e.fullname
WHERE c.id IS NULL;

SELECT *
FROM hr.candidates c
FULL JOIN hr.employees e
	ON c.fullname = e.fullname;

select * from production.products;

select p.product_id, p.product_name, c.category_name, b.brand_name
from production.products p
INNER JOIN production.categories c
	ON p.category_id = c.category_id
INNER JOIN production.brands b
	ON p.brand_id = b.brand_id;

select * from sales.order_items;

SELECT
	*
FROM sales.order_items ot
LEFT JOIN production.products p
	ON ot.product_id = p.product_id;

SELECT
	*
FROM sales.order_items ot
RIGHT JOIN production.products p
	ON ot.product_id = p.product_id;

SELECT *
FROM production.products
CROSS JOIN sales.stores;

SELECT
	m.first_name manager,
	s.first_name staff
FROM sales.staffs s
INNER JOIN sales.staffs m
	ON m.staff_id = s.manager_id;