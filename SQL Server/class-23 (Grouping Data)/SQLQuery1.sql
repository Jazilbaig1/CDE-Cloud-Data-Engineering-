SELECT * FROM sales.customers;

SELECT DISTINCT state
FROM sales.customers;

SELECT state, COUNT(customer_id) AS customer_count
FROM sales.customers
GROUP BY state;

SELECT state, city, COUNT(customer_id) AS customer_count
FROM sales.customers
GROUP BY state, city;

SELECT state, city, COUNT(customer_id) AS customer_count
FROM sales.customers
GROUP BY state, city
ORDER BY state;

SELECT *
FROM production.products;

SELECT SUM(list_price) AS total_sales
FROM production.products;

SELECT model_year, SUM(list_price) AS total_sales
FROM production.products
GROUP BY model_year;

SELECT model_year, MAX(list_price) AS total_sales
FROM production.products
GROUP BY model_year;

SELECT model_year, MIN(list_price) AS total_sales
FROM production.products
GROUP BY model_year;

SELECT model_year, AVG(list_price) AS total_sales
FROM production.products
GROUP BY model_year;

SELECT model_year, SUM(list_price) AS total_sales
FROM production.products
GROUP BY model_year;

SELECT model_year, SUM(list_price) AS total_sales
FROM production.products
GROUP BY model_year
HAVING SUM(list_price) > 150000;

SELECT
    customer_id,
    YEAR (order_date),
    COUNT (order_id) order_count
FROM
    sales.orders
GROUP BY
    customer_id,
    YEAR (order_date)
HAVING
    COUNT (order_id) >= 2
ORDER BY
    customer_id;

SELECT * FROM sales.order_items;

SELECT 
	b.brand_name,
	c.category_name,
	p.model_year,
	ROUND(
		SUM(quantity * i.list_price * (1 - discount)), 0
		) as sales
FROM sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON p.category_id = c.category_id
GROUP BY b.brand_name, c.category_name, p.model_year
ORDER BY b.brand_name, c.category_name, p.model_year;

SELECT 
	b.brand_name,
	c.category_name,
	p.model_year,
	ROUND(
		SUM(quantity * i.list_price * (1 - discount))
		) as sales INTO sales.sales_summary
FROM sales.order_items i
INNER JOIN production.products p ON p.product_id = i.
INNER JOIN production.brands b ON b.brand_id = p.bran
INNER JOIN production.categories c ON p.category_id =
GROUP BY b.brand_name, c.category_name, p.model_year
ORDER BY b.brand_name, c.category_name, p.model_year;

SELECT * FROM sales.sales_summary;

SELECT
	brand_name, category_name, SUM(sales) as sales
FROM sales.sales_summary
GROUP BY brand_name, category_name;

SELECT
	brand_name, SUM(sales) as sales
FROM sales.sales_summary
GROUP BY brand_name;

SELECT
	category_name, SUM(sales) as sales
FROM sales.sales_summary
GROUP BY category_name;

SELECT
	SUM(sales) as sales
FROM sales.sales_summary;

SELECT
	brand_name,
	category_name,
	SUM(sales) AS sales
FROM sales.sales_summary
GROUP BY
	GROUPING SETS (
		(brand_name, category_name),
		(brand_name),
		(category_name),
		()
	)
ORDER BY brand_name, category_name;

SELECT
	brand_name,
	category_name,
	SUM(sales) AS sales
FROM sales.sales_summary
GROUP BY
	CUBE(brand_name, category_name)
ORDER BY brand_name, category_name;

SELECT
	brand_name,
	category_name,
	SUM(sales) AS sales
FROM sales.sales_summary
GROUP BY
	ROLLUP(brand_name, category_name)
ORDER BY brand_name, category_name;

SELECT *
FROM master.sys.databases;

EXEC sp_databases;

SELECT 
    s.name AS schema_name, 
    u.name AS schema_owner
FROM 
    sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY 
    s.name;
