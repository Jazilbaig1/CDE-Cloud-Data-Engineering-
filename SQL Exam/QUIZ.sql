
--------------------------QUESTION NO 1----------------------

SELECT top 5
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(so.TotalAmount) AS TotalSpent
FROM customer c
JOIN SalesOrder so
    ON c.CustomerID = so.CustomerID
GROUP BY 
    c.CustomerID, 
    c.Name
ORDER BY 
    TotalSpent DESC

-------------------QUESTION NO 2--------------------

SELECT
    s.SupplierID,
    s.Name AS SupplierName,
    COUNT(p.ProductID) AS ProductCount
FROM supplier s
JOIN purchaseorder po ON s.SupplierID = po.SupplierID
JOIN purchaseorderdetail pod ON po.OrderID = pod.OrderID
JOIN product p ON pod.ProductID = p.ProductID
GROUP BY s.SupplierID, s.Name
HAVING COUNT(p.ProductID) > 10;

-----------------------------QUESTION NO 3----------------------------

SELECT
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.Quantity) AS TotalOrderQuantity
FROM product p
JOIN salesorderdetail sod ON p.ProductID = sod.ProductID
LEFT JOIN returndetail rd ON p.ProductID = rd.ProductID
WHERE rd.ProductID IS NULL
GROUP BY p.ProductID, p.Name;

------------------- QUESTION NO 4--------------------------

SELECT
    c.CategoryID,
    c.Name AS CategoryName,
    p.Name AS ProductName,
    p.Price
FROM product p
JOIN category c ON p.CategoryID = c.CategoryID
WHERE p.Price = (
    SELECT MAX(p2.Price)
    FROM product p2
    WHERE p2.CategoryID = p.CategoryID
);

-------------------QUESTION NO 5-------------------------

SELECT
    so.OrderID,
    c.Name AS CustomerName,
    p.Name AS ProductName,
    cat.Name AS CategoryName,
    s.Name AS SupplierName,
    sod.Quantity
FROM salesorder so
JOIN customer c ON so.CustomerID = c.CustomerID
JOIN salesorderdetail sod ON so.OrderID = sod.OrderID
JOIN product p ON sod.ProductID = p.ProductID
JOIN category cat ON p.CategoryID = cat.CategoryID
JOIN purchaseorderdetail pod ON p.ProductID = pod.ProductID
JOIN purchaseorder po ON pod.OrderID = po.OrderID
JOIN supplier s ON po.SupplierID = s.SupplierID;



--------------------question no 6------------------------------

SELECT
    sh.ShipmentID,
    w.WarehouseID AS WarehouseName,
    e.Name AS ManagerName,
    p.Name AS ProductName,
    sd.Quantity AS QuantityShipped,
    sh.TrackingNumber
FROM shipment sh
JOIN warehouse w ON sh.WarehouseID = w.WarehouseID
JOIN employee e ON w.ManagerID = e.EmployeeID
JOIN shipmentdetail sd ON sh.ShipmentID = sd.ShipmentID
JOIN product p ON sd.ProductID = p.ProductID;

--------------------QUESTION NO 7-----------------------------

SELECT
    CustomerID,
    CustomerName,
    OrderID,
    TotalAmount
FROM (
    SELECT
        c.CustomerID,
        c.Name AS CustomerName,
        so.OrderID,
        so.TotalAmount,
        RANK() OVER (
            PARTITION BY c.CustomerID
            ORDER BY so.TotalAmount DESC
        ) AS rnk
    FROM customer c
    JOIN salesorder so ON c.CustomerID = so.CustomerID
) t
WHERE rnk <= 3;

----------------------------QUESTION NO 9-------------------

CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.CustomerID,
    c.Name AS CustomerName,
    COUNT(so.OrderID) AS TotalOrders,
    SUM(so.TotalAmount) AS TotalAmountSpent,
    MAX(so.OrderDate) AS LastOrderDate
FROM customer c
LEFT JOIN salesorder so ON c.CustomerID = so.CustomerID
GROUP BY c.CustomerID, c.Name;

SELECT *
FROM vw_CustomerOrderSummary 

