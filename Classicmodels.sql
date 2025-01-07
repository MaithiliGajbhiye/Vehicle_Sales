USE `classicmodels`;

--- Find the total number of customers ---

SELECT COUNT(*) AS total_customers 
FROM customers;

--- Retrieve the customer details for those whose credit limit is above $50,000. ---

SELECT customerNumber, customerName, creditLimit 
FROM customers 
WHERE creditLimit > 50000;

--- List the employees who work in a specific office, say officeCode '1'. ---

SELECT firstName, lastName 
FROM employees 
WHERE officeCode = '1';

--- List customers from a specific country, say 'USA'. ---

SELECT customerName, city, state 
FROM customers 
WHERE country = 'USA';

--- Find the number of employees reporting to each manager. ---

SELECT reportsTo, COUNT(*) AS num_reports
FROM employees
GROUP BY reportsTo;

--- Retrieve the names of employees who have no direct reports. ---

SELECT e.employeeNumber, e.firstName, e.lastName
FROM employees e
LEFT JOIN employees e2 ON e.employeeNumber = e2.reportsTo
WHERE e2.employeeNumber IS NULL;

--- Find the total number of offices in each country. ---

SELECT country, COUNT(*) AS total_offices 
FROM offices 
GROUP BY country;

--- Find the details of the top 5 products with the highest order quantity. ---

SELECT productCode, orderNumber, quantityOrdered 
FROM orderdetails 
ORDER BY quantityOrdered DESC LIMIT 5;

--- Calculate the total price for each order (quantity times price each). ---

SELECT orderNumber, SUM(quantityOrdered * priceEach) AS total_order_price 
FROM orderdetails 
GROUP BY orderNumber;

--- List all orders placed by a specific customer, say with customerNumber 103. ---

SELECT orderNumber, orderDate, status 
FROM orders 
WHERE customerNumber = 103;

---  Find the number of orders placed in each status category. ---

SELECT status, COUNT(*) AS total_orders 
FROM orders 
GROUP BY status;

--- Retrieve the payment details of customers who have made payments above $50,000. ---

SELECT customerNumber, paymentDate, amount 
FROM payments 
WHERE amount > 50000;

--- Calculate the total payments made by each customer. ---

SELECT customerNumber, SUM(amount) AS total_payments 
FROM payments 
GROUP BY customerNumber;

--- Count the number of products in each product line. ---

SELECT productLine, COUNT(*) AS total_products 
FROM products 
GROUP BY productLine;

--- Find the top 5 most expensive products. ---

SELECT productCode, productName, buyPrice 
FROM products 
ORDER BY buyPrice DESC LIMIT 5;

--- List all products with a buy price between $50 and $100. ---

SELECT productCode, productName, buyPrice 
FROM products 
WHERE buyPrice BETWEEN 50 AND 100;

--- List all customers and their corresponding orders, including customers who havent placed any orders. ---

SELECT c.customerName, o.orderNumber
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
ORDER BY c.customerName;

--- List all employees and their assigned customers, including employees who have no assigned customers. ---

SELECT e.firstName, e.lastName, c.customerName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
ORDER BY e.lastName;

--- Retrieve all order details and their corresponding products, including order details for products that are no longer in the products table. ---

SELECT od.orderNumber, p.productName, od.quantityOrdered
FROM orderdetails od
RIGHT JOIN products p ON od.productCode = p.productCode
ORDER BY od.orderNumber;
