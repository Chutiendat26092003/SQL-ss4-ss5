-- SS 4
--1
USE AdventureWorks2019
SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer' -- lấy ra những JobTitle có nội dung là 'Design Engineer'
GO

--2
CREATE TYPE usertype FROM varchar(20) NOT NULL
GO

--3
DECLARE @Number int; -- khai báo biến cục bộ
SET @Number = 2 + 2 * (4 + (5 - 3)) -- gán giá trị cho biến bằng 1 hàm phép tính
SELECT @Number
GO

--4
USE AdventureWorks2019
SELECT SalesOrderID, CustomerID, SalesPersonID, TerritoryID, YEAR(OrderDate) AS CurrentYear
, YEAR(OrderDate) +  1 AS NextYear
FROM Sales.SalesOrderHeader
GO

--5
IF DATENAME(weekday, GETDATE()) IN (N'Saturday', N'Sunday')
    SELECT 'It is a Weekend';
ELSE 
    SELECT 'It is a Weekday';
GO

--6; 7 
-- comment 1 dòng thì sử '--'
/*
cmt nhiều dòng thì sử dụng ' /* ...  */'
*/

-- 8 
USE AdventureWorks2019
SELECT * FROM HumanResources.Employee
GO  --  báo hiệu kết thúc 1 đợt

-- 9 
USE AdventureWorks2019
GO
SELECT ProductID --  lấy ra ProductID
FROM Production.Product
INTERSECT 
SELECT ProductID -- lấy ra ProductID  và sắp xếp 
FROM Production.WorkOrder

--10
USE AdventureWorks2019
SELECT SalesPersonID, YEAR(OrderDate) AS OrderYear FROM Sales.SalesOrderHeader
WHERE CustomerID = 30084 --  chỉ lấy các phần CustomerID có nội dung 30084
GROUP BY SalesPersonID, YEAR(OrderDate) --sắp xếp các giá trị đã lọc nhận được từ mệnh đề where.
HAVING COUNT(*) > 1  --được đánh giá dựa trên vị từ được cung cấp.
ORDER BY SalesPersonID, OrderYear; --được đánh giá để hiển thị đầu ra.




-- SS 5
-- 1 
CREATE DATABASE Customer_DB ON PRIMARY
( NAME = 'Customer_DBX', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Customer_DB.mdf')
LOG ON 
( NAME = 'Customer_DB_log', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Customer_DB_log.ldf')
COLLATE SQL_Latinl_General_CP1_CI_AS
/* tệp .mdf, được gọi là tệp cơ sở dữ liệu chính, chứa lược đồ và dữ liệu và tệp .Idf, chứa nhật ký. Cơ sở dữ liệu cũng có thể 
sử dụng tệp cơ sở dữ liệu thứ cấp, tệp này thường sử dụng phần mở rộng .ndf.
MDF là viết tắt của Master Database File. Nó chứa thông tin chính của cơ sở dữ liệu là một phần của máy chủ. Phần mở rộng này
cũng trỏ đến nhiều tệp khác. Nó đóng một vai trò quan trọng trong việc lưu trữ thông tin.
LDF là viết tắt của Log Database File. Tệp này lưu trữ thông tin liên quan đến nhật ký giao dịch cho tệp dữ liệu chính. Về cơ bản, 
nó theo dõi những thay đổi đã được thực hiện trong cơ sở dữ liệu.*/

--2
ALTER DATABASE EXAMPLE1 MODIFY NAME = CUST_DB -- đổi tên bảng

--3
USE CUST_DB 
EXEC sp_changedbowner 'sa'

--4 
USE CUST_DB
ALTER DATABASE CUST_DB SET AUTO_SHINK ON

--5
CREATE DATABASE [SalesDB] ON PRIMARY
(NAME = 'SalesDB', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SalesDB.mdf',
 SIZE = 3072KB, MAXSIZE = UNLIMIDTED, FILEGROWTH = 1024KB ),
 FILEGROUD [MyFileGroup]
(NAME = 'SalesDB_FG', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SalesDB_FG.ndf',
 SIZE = 3072KB, MAXSIZE = UNLIMIDTED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = 'SalesDB_log', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SalesDB_log.ldf',
 SIZE = 2048KB, MAXSIZE = 2048KB, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS 
 --6
 USE CUST_DB
 ALTER DATABASE CUST_DB
 ADD FILEGROUD FG_ReadOnly
