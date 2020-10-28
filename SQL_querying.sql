USE Northwind;
-- How many orders in NWDB?
SELECT COUNt(*) FROM orders;

-- How many order that the Ship City is Rio de Janeiro?
SELECT COUNT(*) FROM Orders WHERE ShipCity = 'Rio de Janeiro';

-- Select all orders that the Ship City is Rio de Janeiro or Reims?
SELECT * FROM Orders WHERE ShipCity IN ('Rio de Janeiro', 'Reims');

-- Select all of the entries where the Company name has a z or a Z in the table of Customers
SELECT * FROM Customers WHERE CompanyName LIKE '%z%';

-- We need to update all of our FAX information! Find the Name of All of the companies that we do not have their FAX numbers! 
-- I would also like to know with whom I need to speak with, their contact numbers and what city they are based in.
SELECT CompanyName, ContactName, Phone, City FROM Customers WHERE Fax IS NULL;

-- We need to re-target all of our Customers is Paris! Get me information on these clients.
SELECT * FROM Customers WHERE City = 'Paris';
-- Find out, these clients from Paris, whom orders the most by quantity? Who are our top 5 clients?
SELECT Customers.CompanyName, [Order Details].Quantity
FROM  ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID) 
WHERE Customers.City = 'Paris'
ORDER BY Quantity DESC;

-- I need to know more about these these Paris client. Can you find out which ones their deliveries took longer than 10 days? 
-- Display the Business/client name, contact name, all their contact details (don't forget the fax!), as well as the number of deliveries that where overdue! Just add a column named: 'Number overdue orders'.
SELECT  Customers.CompanyName, 
        Customers.ContactName,
        Customers.Phone,
        Customers.Fax,
        Customers.PostalCode,
        SUM(CASE WHEN DATEDIFF(DAY,Orders.RequiredDate, Orders.ShippedDate)>10 THEN 1 ELSE 0 END) AS 'Number of Overdue Orders'
FROM  ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID) 
WHERE Customers.City = 'Paris'
GROUP BY    Customers.CustomerID,
            Customers.CompanyName,
            Customers.ContactName,
            Customers.Phone,
            Customers.Fax,
            Customers.PostalCode;


SELECT RequiredDate, ShippedDate, DATEDIFF(DAY,RequiredDate, ShippedDate) AS 'Shipping Delay' FROM Orders;