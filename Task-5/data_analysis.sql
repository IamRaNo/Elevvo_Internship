-- ================================================
-- SINGLE TABLE ANALYSIS
-- ================================================

-- CUSTOMERS

-- 1. How many customers are there in total?
SELECT COUNT(DISTINCT(`CustomerId`)) FROM customer;

-- 2. How many unique countries are customers from?
SELECT COUNT(DISTINCT(`Country`)) FROM customer;

-- 3. Which country has the most customers?
SELECT `Country`,COUNT(`Country`) as 'customer_count' FROM customer
GROUP BY `Country`
ORDER BY customer_count DESC
LIMIT 1;

-- 4. How many customers are from each city?
SELECT `City`,COUNT(`City`) as 'customer_count' FROM customer
GROUP BY `City`
ORDER BY customer_count DESC;

-- 5. How many customers are from each state?
SELECT `State`,COUNT(`State`) as 'customer_count' FROM customer
GROUP BY `State`
ORDER BY customer_count DESC;

-- 6. Are there customers with duplicate emails?
SELECT `Email`, COUNT(`Email`) 'email_count' FROM customer
GROUP BY `Email`
HAVING email_count >1;

-- 7. Are there customers with missing address details?
SELECT * FROM customer
WHERE `Address` IS NULL;

-- 8. Are there customers with duplicate phone number?
SELECT `Phone`, COUNT(`Phone`) 'phone_count' FROM customer
GROUP BY `Phone`
HAVING phone_count >1;

-- 9. Distribution of customers by postal code?
SELECT `PostalCode`,COUNT(`PostalCode`) as 'customer_count' FROM customer
GROUP BY `PostalCode`
ORDER BY customer_count DESC;


-- INVOICES

-- 10. How many invoices are there?
SELECT COUNT(DISTINCT(`InvoiceId`)) FROM invoice;

-- 11. Total revenue from all invoices?
SELECT SUM(`Total`) FROM invoice;

-- 12. Average invoice total?
SELECT AVG(`Total`) FROM invoice;

-- 13. Minimum and maximum invoice total?
SELECT MIN(`Total`),MAX(`Total`) FROM invoice;

-- 14. Number of invoices per billing country?
SELECT `BillingCountry`,COUNT(`InvoiceId`) as 'total_invoices' FROM invoice
GROUP BY `BillingCountry`
ORDER BY total_invoices DESC;

-- 15. How many invoices per customer?
SELECT `CustomerId`,COUNT(`CustomerId`) from invoice
GROUP BY `CustomerId`;

-- 16. How many invoices per year/month?
SELECT MONTH(`InvoiceDate`),COUNT(`InvoiceId`) FROM invoice
GROUP BY(MONTH(`InvoiceDate`));
SELECT YEAR(`InvoiceDate`),COUNT(`InvoiceId`) FROM invoice
GROUP BY(YEAR(`InvoiceDate`));

-- 17. Distribution of invoices by postal code?
SELECT `BillingPostalCode`,COUNT(`InvoiceId`) as 'total_invoices' FROM invoice
GROUP BY `BillingPostalCode`
ORDER BY total_invoices DESC;


-- TRACKS

-- 18. Total number of tracks?
SELECT COUNT(`TrackId`) FROM track;

-- 19. Number of tracks per genre?
SELECT `GenreId`,COUNT(`GenreId`) as 'total_songs' FROM track
GROUP BY `GenreId`
ORDER BY total_songs DESC;

-- 20. Number of tracks per album?
SELECT `AlbumId`,COUNT(`AlbumId`) as 'total_songs' FROM track
GROUP BY `AlbumId`
ORDER BY total_songs DESC;

-- 21. Number of tracks per media type?
SELECT `MediaTypeId`,COUNT(`MediaTypeId`) as 'total_songs' FROM track
GROUP BY `MediaTypeId`
ORDER BY total_songs DESC;

-- 22. Average track length?
SELECT ROUND((AVG(`Milliseconds`)/1000)/60) FROM track;

-- 23. Minimum and maximum track length?
SELECT ROUND((MAX(`Milliseconds`)/1000)/60),ROUND((MIN(`Milliseconds`)/1000),2) FROM track;


-- ALBUMS

-- 24. Total number of albums?
SELECT COUNT(*) FROM album;

-- 25. Number of albums per artist?
SELECT `ArtistId`,COUNT(`ArtistId`) FROM album
GROUP BY `ArtistId`
ORDER BY COUNT(`ArtistId`) DESC;

-- 26. Albums with the same name?
SELECT `Title`,COUNT(`Title`) FROM album
GROUP BY `Title`
HAVING COUNT(`Title`)>1;


-- ARTISTS

-- 27. Total number of artists?
SELECT COUNT(*) FROM artist;

-- 28. Are there any duplicate artist names?
SELECT `Name`,COUNT(`Name`) FROM artist
GROUP BY `Name`
HAVING COUNT(`Name`)>1;

-- 29. What is the average name length of artists?
SELECT AVG(LENGTH(`Name`)) FROM artist;


-- GENRES

-- 30. Total number of genres?
SELECT COUNT(*) FROM genre;


-- PLAYLISTS

-- 31. Total number of playlists?
SELECT COUNT(*) FROM playlist;


-- MEDIA TYPES

-- 32. Total number of media types?
SELECT COUNT(*) FROM mediatype;


-- EMPLOYEE

-- 33. How many employees are there?
SELECT COUNT(*) FROM employee;

-- 34. How many people are from each job title?
SELECT `Title`,COUNT(`Title`) as 'count' FROM employee
GROUP BY `Title`
ORDER BY count desc;

-- 35. Which employee reports to Which employee?
SELECT e.`FirstName` as 'Employee',m.`FirstName` as 'Manager' FROM employee e
LEFT JOIN employee m ON
e.`ReportsTo`= m.`EmployeeId`;

-- 36. Most senior and most junior employee by date of joining?
SELECT `FirstName`, `HireDate` FROM employee
ORDER BY `HireDate` ASC
LIMIT 1;
SELECT `FirstName`, `HireDate` FROM employee
ORDER BY `HireDate` DESC
LIMIT 1;

-- 37. Are there any employee with the same address?
SELECT `Address`,COUNT(`Address`) FROM employee
GROUP BY `Address`
HAVING COUNT(`Address`)>1;

-- 38. Are there any duplicate email address?
SELECT `Email`, COUNT(`Email`) 'email_count' FROM employee
GROUP BY `Email`
HAVING email_count >1;


-- ================================================
-- MULTI-TABLE ANALYSIS (SALES & REVENUE)
-- ================================================


-- 39. Which are the top 10 best-selling tracks by total revenue?
SELECT il.`TrackId`,t.`Name`,SUM(il.`UnitPrice`*il.`Quantity`) as revenue 
FROM invoiceline il
JOIN track t USING (`TrackId`)
GROUP BY `TrackId`
ORDER BY revenue DESC
LIMIT 10;

-- 40. Which albums generated the highest total sales revenue?
SELECT a.`Title`,SUM(il.`UnitPrice`*il.`Quantity`) as revenue 
FROM invoiceline il
JOIN track t USING(`TrackId`)
JOIN album a USING(`AlbumId`)
GROUP BY a.`Title`
ORDER BY revenue DESC
LIMIT 10;

-- 41. Who are the top 5 artists with the highest total revenue?
SELECT ar.`Name`,SUM(il.`UnitPrice`*il.`Quantity`) as revenue 
FROM invoiceline il
JOIN track t USING(`TrackId`)
JOIN album a USING(`AlbumId`)
JOIN artist ar USING(`ArtistId`)
GROUP BY ar.`ArtistId`
ORDER BY revenue DESC
LIMIT 10;

-- 42. Which genres contribute the most revenue overall?
SELECT g.`Name`,SUM(il.`UnitPrice`*il.`Quantity`) as revenue 
FROM invoiceline il
JOIN track t USING(`TrackId`)
JOIN genre g USING(`GenreId`)
GROUP BY g.`GenreId`,g.`Name`
ORDER BY revenue DESC
LIMIT 10;

-- 43. Which media type (e.g., MPEG, AAC, etc.) generates the most sales?
SELECT mt.`Name`,SUM(il.`UnitPrice`*il.`Quantity`) as revenue 
FROM invoiceline il
JOIN track t USING(`TrackId`)
JOIN mediatype mt USING(`MediaTypeId`)
GROUP BY mt.`MediaTypeId`,mt.`Name`
ORDER BY revenue DESC;

-- 44. What is the average revenue per invoice?
SELECT AVG(`Total`) as Average_Revenue FROM invoice;

-- 45. How many unique customers made purchases in each country?
SELECT c.`Country`,COUNT(DISTINCT(c.`CustomerId`)) AS Total_Customers 
FROM invoice i
JOIN customer c USING(`CustomerId`)
GROUP BY c.`Country`
ORDER BY Total_Customers DESC;

-- 46. What is the total revenue by billing country?
SELECT `BillingCountry`,SUM(`Total`) Revenue FROM invoice
GROUP BY `BillingCountry`
ORDER BY Revenue DESC;

-- 47. What is the total revenue by billing city (top 10 cities)?
SELECT `BillingCity`,SUM(`Total`) Revenue FROM invoice
GROUP BY `BillingCity`
ORDER BY Revenue DESC
LIMIT 10;

-- 48. Which customers generated the most revenue?
SELECT c.`FirstName`,SUM(`Total`) as Revenue FROM invoice i
JOIN customer c USING(`CustomerId`)
GROUP BY c.`CustomerId`,c.`FirstName`
ORDER BY Revenue DESC;

-- 49. Which employee (sales support rep) generates the highest revenue?
SELECT e.`FirstName`,SUM(`Total`) as Revenue FROM invoice i
JOIN customer c USING(`CustomerId`)
JOIN employee e ON c.`SupportRepId`=e.`EmployeeId`
GROUP BY e.`EmployeeId`
ORDER BY Revenue DESC;

-- 50. What is the monthly revenue trend across all years?
SELECT MONTH(`InvoiceDate`),SUM(`Total`) FROM invoice
GROUP BY MONTH(`InvoiceDate`);

-- 51. What is the year-over-year revenue growth?
SELECT YEAR(`InvoiceDate`),SUM(`Total`) FROM invoice
GROUP BY YEAR(`InvoiceDate`);

-- 52. Which customers have the highest average order value (AOV)?
SELECT c.`FirstName`,AVG(`Total`) as Revenue FROM invoice i
JOIN customer c USING(`CustomerId`)
GROUP BY c.`CustomerId`,c.`FirstName`
ORDER BY Revenue DESC
LIMIT 1;

-- 53. How many invoices were created per year?
SELECT YEAR(`InvoiceDate`),COUNT(`InvoiceDate`) FROM invoice
GROUP BY YEAR(`InvoiceDate`);

-- 54. What is the average number of tracks purchased per invoice?
SELECT AVG(total) FROM(SELECT `InvoiceId`,COUNT(`TrackId`) as total FROM invoiceline
GROUP BY `InvoiceId`) as tab;

-- 55. Which countries have the highest customer count?
SELECT `Country`,COUNT(`Country`) as total FROM customer
GROUP BY `Country`
ORDER BY total DESC;

-- 56. What percentage of revenue comes from the top 5 countries?
SELECT `BillingCountry`,ROUND((Revenue/(SELECT SUM(Total) FROM invoice))*100,2)
FROM(
SELECT `BillingCountry`,SUM(`Total`) Revenue FROM invoice
GROUP BY `BillingCountry`
ORDER BY Revenue DESC
LIMIT 5) as tab;

-- 57. Which tracks were purchased the most times (by quantity)?
SELECT * FROM invoiceline;
SELECT t.`Name`,COUNT(`TrackId`) as total FROM invoiceline il
JOIN track t USING(`TrackId`)
GROUP BY il.`TrackId`
ORDER BY total DESC;

-- 58. Which playlists include the most purchased tracks?
SELECT p.`PlaylistId`,p.`Name`,COUNT(il.`TrackId`) as total 
FROM invoiceline il
JOIN track t ON il.`TrackId`= t.`TrackId`
JOIN playlisttrack pt ON t.`TrackId`=pt.`TrackId`
JOIN playlist p ON pt.`PlaylistId`= p.`PlaylistId`
GROUP BY p.`PlaylistId`
ORDER BY total DESC;

-- 59. What is the distribution of sales across different genres?
SELECT g.`GenreId`,g.`Name`,SUM(i.`Total`) as Revenue FROM invoiceline il
JOIN invoice i ON il.`InvoiceId`=i.`InvoiceId`
JOIN track t USING(`TrackId`)
JOIN genre g ON t.`GenreId`=g.`GenreId`
GROUP BY g.`GenreId`
ORDER BY Revenue DESC;

-- 60. Which tracks have the highest unit price?
SELECT t.`Name`,il.`UnitPrice` FROM invoiceline il
JOIN track t ON il.`TrackId`=t.`TrackId`
ORDER BY il.`UnitPrice` DESC;

-- 61. Which genres have the highest average unit price?
SELECT g.`Name`,AVG(il.`UnitPrice`) FROM invoiceline il
JOIN track t ON il.`TrackId`=t.`TrackId`
JOIN genre g ON t.`GenreId`=g.`GenreId`
GROUP BY g.`GenreId`
ORDER BY AVG(il.`UnitPrice`) DESC;

-- 62. Which artists have the widest variety of tracks in the database?
SELECT a.`ArtistId`,a.`Name`,COUNT(DISTINCT(g.`GenreId`)) as types FROM artist a
JOIN album al ON a.`ArtistId`=al.`ArtistId`
JOIN track t ON al.`AlbumId`=t.`AlbumId`
JOIN genre g ON t.`GenreId`=g.`GenreId`
GROUP BY a.`ArtistId`
ORDER BY types DESC;

-- 63. Which customers from the USA generate the most revenue?
SELECT c.`FirstName`,SUM(i.`Total`) FROM invoice i 
JOIN customer c ON i.`CustomerId`=c.`CustomerId`
WHERE c.`Country`="USA"
GROUP BY c.`CustomerId`
ORDER BY SUM(i.`Total`) DESC;
