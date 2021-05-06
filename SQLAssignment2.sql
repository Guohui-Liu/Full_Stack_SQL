--1, What is a result set? 
--An SQL result set is a set of rows from a database, as well as metadata about the query such as the column names, 
--and the types and sizes of each column. Depending on the database system, the number of rows in the result set may or may not be known.

--2, What is the difference between Union and Union All?  
--union can not be used with recursive CTE but union all can be used with recursive CTEunion will give the unique records 
--but union all gives duplicate tounion will sort the resultset based on the first column of the first select statement 
--but union all will notunion is slower than union all

--3, What are the other Set Operators SQL Server has? 
--UNION, UNION ALL, INTERSECT, EXCEPT

--4, What is the difference between Union and Join? 
--JOIN combines data from many tables based on a matched condition between them. where as SQL combines the result-set of two or more 
--SELECT statements.
--Number of columns selected from each table may not be same. where as Number of columns selected from each table should be same.
--Datatypes of corresponding columns selected from each table can be different.where as Datatypes of corresponding columns selected 
--from each table should be same.

--5, What is the difference between INNER JOIN and FULL JOIN? 
--Inner join returns only the matching rows between both the tables, non matching rows are eliminated where as Full Join or Full Outer 
--Join returns all rows from both the tables (left & right tables), including non-matching rows from both the tables.

--6, What is difference between left join and outer join 
--Left join is a kind of outer join. Left outer join will return all rows from left query, even if there are unmatched data. 
--There are another two kinds of outer joins, which are right join and full join.  

--7, What is cross join? 
--The CROSS JOIN is used to generate a paired combination of each row of the first table with each row of the second table. 
--This join type is also known as cartesian join.

--8, What is the difference between WHERE clause and HAVING clause? 
--The WHERE clause is used in the selection of rows according to given conditions whereas the HAVING clause is used in column operations 
--and is applied to aggregated rows or groups. If GROUP BY is used then it is executed after the WHERE clause is executed in the query

--9,Can there be multiple group by columns? 
--Yes, a group by clause can contain two or more columns and these columns will group in order

use AdventureWorks2019
--1, How many products can you find in the Production.Product table? 
 select count(*) from Production.product 

--2, Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
--The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory. 
  select count(*) from Production.product where productsubcategoryId is not null

--3, How many Products reside in each SubCategory? Write a query to display the results with the following titles.  
--ProductSubcategoryID CountedProducts
-------------------- ---------------
Select distinct productsubcategoryId, count(*) as CountedProducts from Production.product
group by productsubcategoryId

--4, How many products that do not have a product subcategory.
select count(*) as CountedProducts from Production.product where productsubcategoryId is null


--5, Write a query to list the summary of products in the Production.ProductInventory table. 
select [ProductID], sum(Quantity) as theSum from Production.ProductInventory 
Group by ProductID

--6, Write a query to list the summary of products in the Production.ProductInventory table and LocationID set to 40 
--and limit the result to include just summarized quantities less than 100. 
--     ProductID    TheSum
-----------        ----------
select [ProductID], sum(Quantity) as theSum from Production.ProductInventory where LocationID =40 and Quantity < 100
Group by ProductID

--7, Write a query to list the summary of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 
--and limit the result to include just summarized quantities les s than 100 
--       Shelf      ProductID    TheSum
---------- -----------        -----------
select [Shelf],[ProductID], sum(Quantity) as theSum  from Production.ProductInventory where LocationID = 40 and Quantity < 100
Group by Shelf, ProductID

--8, Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table. 
select [ProductID], avg(Quantity) as theAVG from Production.ProductInventory where LocationID = 10 
Group by ProductID

--9, Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory 
--ProductID   Shelf      TheAvg
----------- ---------- -----------
select [ProductID],[Shelf], avg(Quantity) as theAVG from Production.ProductInventory 
Group by [Shelf],ProductID

--10, Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from 
--the table Production.ProductInventory 
--ProductID   Shelf      TheAvg
----------- ---------- -----------
select [ProductID],[Shelf], avg(Quantity) as theAVG from Production.ProductInventory where shelf not like 'N/A'
Group by [Shelf],ProductID

--11, List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and 
--the Class column. Exclude the rows where Color or Class are null. 
--Color           	Class 	TheCount   	 AvgPrice
--------------	- ----- 	----------- 	---------------------
select color, class, count(productid) as TheCount, avg(listprice) as avgprice from Production.product where color is not null
group by color, Class

--12,  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them 
--and produce a result set similar to the following.  
--Country                        Province
---------                          ----------------------
select c.Name as Country, s.Name as Province  from  person.stateprovince s
inner join person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode

--13, Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and 
--list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following. 
--Country                        Province
---------                          ----------------------
select c.Name as Country, s.Name as Province  from  person.stateprovince s
inner join person.CountryRegion c
on s.CountryRegionCode = c.CountryRegionCode
where c.name ='Germany' or c.name = 'Canada'

use Northwind 
--14, List all Products that has been sold at least once in last 25 years. 
 select distinct p.* from dbo.products p
 inner join [dbo].[Order Details] o
 on p.productId = o.productID

--15, List top 5 locations (Zip Code) where the products sold most
  select top(5) [ShipPostalCode], Count([ShipPostalCode]) as times from dbo.orders 
  Group by [ShipPostalCode]
  order by times desc

--16, List top 5 locations (Zip Code) where the products sold most in last 20 years. 
  select top(5) [ShipPostalCode], Count([ShipPostalCode]) as times from dbo.orders  WHERE year(OrderDate)  < DATEADD(year,-20,GETDATE())
  Group by [ShipPostalCode]
  order by times desc

--17, List all city names and number of customers in that city.  
    select [city], count(customerID) as NumberofCustomers from dbo.customers 
	Group by city 

--18, List city names which have more than 10 customers, and number of customers in that city  
 select [city], count(customerID) as NumberofCustomers from dbo.customers 
 Group by city 
 having count(customerID) > 10
 order by NumberofCustomers desc

--19, List the names of customers who placed orders after 1/1/98 with order date. 
select distinct c.*  from dbo.customers c
 inner join dbo.orders o
 on c.customerID = o.customerID
 where o.orderDate >'1/1/98' 

--20, List the names of all customers with most recent order dates  
 select  c.* , o.orderDate from dbo.customers c
 inner join dbo.orders o
 on c.customerID = o.customerID
 order by o.orderDate desc

--21, Display the names of all customers  along with the  count of products they bought
SELECT c.CustomerID, c.CompanyName, c.ContactName, 
SUM(od.Quantity) AS QTY FROM 
Customers c 
LEFT JOIN 
Orders o 
ON c.CustomerID = o.CustomerID
LEFT JOIN 
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.ContactName
ORDER BY QTY;

--22, Display the customer ids who bought more than 100 Products with count of products. 
 SELECT c.CustomerID,
SUM(od.Quantity) AS QTY FROM 
Customers c 
LEFT JOIN 
Orders o 
ON c.CustomerID = o.CustomerID
LEFT JOIN 
[Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100
ORDER BY QTY;

--23, List all of the possible ways that suppliers can ship their products. Display the results as below
--Supplier Company Name   	Shipping Company Name
---------------------------------            ----------------------------------
 select a.CompanyName as Supplier, b.CompanyName as ShippingCompany from dbo.suppliers a
 cross join dbo.shippers b

--24, Display the products order each day. Show Order date and Product Name. 
 select  c.CompanyName, o.Orderdate  from dbo.customers c
 inner join dbo.orders o
 on c.customerID = o.customerID

--25, Displays pairs of employees who have the same job title. 
select e.Title, e.FirstName, e.LastName from Employees as e
group by e.Title, e.FirstName, e.LastName

--26, Display all the Managers who have more than 2 employees reporting to them. 
select m.EmployeeID, m.FirstName, m.LastName, count(*) as num_respond
from Employees e join Employees m on m.EmployeeID = e.ReportsTo
group by m.EmployeeID, m.FirstName, m.LastName
having count(*)>2
	
--27--
/*
Display the customers and suppliers by city. The results should have the following columns
City Name 
Contact Name,
Type (Customer or Supplier)*/
select c.City as 'City Name', c.ContactName as 'Contact Name', 'Customer' as 'Type'
from Suppliers S 
inner join Products P on s.SupplierID = p.SupplierID
inner join [Order Details] od on od.ProductID = p.ProductID
inner join Orders O on o.OrderID = od.OrderID
inner join Customers C on c.CustomerID = o.CustomerID
group by c.City, c.ContactName
union all 
select c.City as 'City Name', s.ContactName as 'Contact Name','Supplier' as 'Type'
from Suppliers S 
inner join Products P on s.SupplierID = p.SupplierID
inner join [Order Details] od on od.ProductID = p.ProductID
inner join Orders O on o.OrderID = od.OrderID
inner join Customers C on c.CustomerID = o.CustomerID
group by c.City, s.ContactName

 --28--
/*
Have two tables T1 and T2
F1.T1	F2.T2
1	2
2	3
3	4
Please write a query to inner join these two tables and write down the result of this query
*/
create table T1 (F1_T1 int)
insert into T1 values (1)
insert into T1 values (2)
insert into T1 values (3)

create table T2 (F2_T2 int)
insert into T2 values (2)
insert into T2 values (3)
insert into T2 values (4)
select * from T1
select * from T2
select *
from T1 inner join T2 on T1.F1_T1 =T2.F2_T2 

--29. Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.
select *
from T1 left join T2 on T1.F1_T1 =T2.F2_T2 
-- Left join base on T2
select *
from T2 left join T1 on T1.F1_T1 =T2.F2_T2 
