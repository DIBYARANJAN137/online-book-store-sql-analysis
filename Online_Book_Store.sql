CREATE DATABASE Online_Book_Store;
USE Online_Book_Store;



SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- Basic Queries

-- 1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books WHERE genre = "Fiction";
-- 2) Find books published after the year 1950
SELECT * FROM Books WHERE Published_Year >  1950;
-- 3) List all customers from the Canada
SELECT * FROM Customers WHERE City = "Canada";
-- 4) Show orders placed in November 2023
SELECT * FROM Orders WHERE Order_Date > "2023-11-01" AND  Order_Date < "2023-11-30"  ;
-- 5) Retrieve the total stock of books available
SELECT SUM(Stock) AS Total_Available_Books FROM Books;
-- 6) Find the details of the most expensive book
SELECT * FROM Books WHERE Price = (SELECT MAX(Price) FROM Books);
-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT Name , COUNT(*) AS "Quantity" 
FROM Customers
GROUP BY Name
HAVING COUNT(*)>1;

SELECT Name 
FROM Customers
GROUP BY Name
HAVING COUNT(*)>1;
-- 8) Retrieve all orders where the total amount exceeds $20
SELECT * FROM Orders WHERE Total_Amount > 20;
-- 9) List all genres available in the Books table
SELECT Genre FROM Books GROUP BY Genre;
-- 10) Find the book with the lowest stock
SELECT * FROM Books WHERE Stock = (SELECT MIN(Stock) FROM Books);
-- 11) Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) AS "Total_Revenue" FROM Orders;

SELECT * FROM Orders;


-- Advance Queries

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- 1) Retrieve the total number of books sold for each genre

SELECT Genre , SUM(Orders.Quantity) AS "Total Quantity Sold"
FROM Books 
JOIN Orders
ON Books.book_id = Orders.order_id
GROUP BY Genre;

-- 2) Find the average price of books in the "Fantasy" genre

SELECT AVG(Price) 
FROM Books
 WHERE Genre = "Fantasy";

-- 3) List customers who have placed at least 2 orders
SELECT * FROM Customers;
SELECT * FROM Orders;
 

SELECT Customer_id  
FROM Orders 
GROUP BY Customer_id
HAVING  COUNT(Customer_ID)>=2
ORDER BY Customer_id ;


-- 4) Find the most frequently ordered book


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre 

SELECT * FROM Books 
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author
SELECT Author , COUNT(*) Total_Quantity_Sold
FROM Books
GROUP BY Author;


-- 7) List the cities where customers who spent over $30 are located
SELECT  DISTINCT Customers.City 
FROM Customers  
INNER JOIN Orders 
ON Customers.Customer_ID = Orders.Customer_ID
WHERE Total_Amount>30;
-- 8) Find the customer who spent the most on orders


SELECT Customers.Customer_id,Customers.Name , SUM(Orders.Total_Amount) "Total Amount"  FROM Customers
INNER JOIN Orders
ON Customers.Customer_id = Orders.Customer_id
GROUP BY Customers.Name
ORDER BY SUM(Orders.Total_Amount) DESC
LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all order
 
SELECT 
    Books.Book_ID AS Book_ID,
    Books.Title,
    SUM(Books.Stock) AS Total_Stock,
    CASE
        WHEN SUM(Orders.Quantity) IS NULL THEN 0
        ELSE SUM(Orders.Quantity)
    END AS Total_Quantity_Ordered,
    CASE
        WHEN SUM(Books.Stock) - SUM(Orders.Quantity) IS NULL THEN SUM(Books.Stock)
        ELSE SUM(Books.Stock) - SUM(Orders.Quantity)
    END AS 'Remaining Stock'
FROM
    Books
        LEFT JOIN
    Orders ON Books.Book_ID = Orders.Book_ID
GROUP BY Books.Title , Books.Book_ID;
 



