CREATE SCHEMA Sales;
GO

CREATE TABLE Sales.Product
(
	ProductID INTEGER IDENTITY PRIMARY KEY,
	ProductName VARCHAR(20) NOT NULL,
	Price DECIMAL(8,2) DEFAULT 0.00,
	Supplier INTEGER NULL
);
GO

CREATE TABLE Sales.Supplier
(
	SupplierID INTEGER IDENTITY PRIMARY KEY,
	SupplierName VARCHAR(20) NOT NULL, 
);
GO

ALTER TABLE Sales.Product 
ADD CONSTRAINT fk_product_supplier
FOREIGN KEY (Supplier) REFERENCES Sales.Supplier(SupplierID);

INSERT INTO Sales.Supplier
VALUES('VERDE')

SELECT * FROM Sales.Supplier;
	
DECLARE @intFlag INT
SET @intFlag = 1
DECLARE @decimalPrice DECIMAL
SET @decimalPrice = 100.00
DECLARE @intCounter INT
SET @intCounter = 1

WHILE (@intFlag <=100) 
BEGIN
    PRINT @intFlag
    INSERT INTO Sales.Product
	VALUES('CAR', @decimalPrice, @intCounter)
	IF @intCounter < 6   
		SET @intCounter = @intCounter + 1    
	ELSE   
		SET @intCounter = @intCounter - 1 

	SET @intFlag = @intFlag + 1
END
GO

SELECT * FROM Sales.Product;

DECLARE @intFlag INT
SET @intFlag = 1
DECLARE @decimalPrice DECIMAL
SET @decimalPrice = 100.00
DECLARE @intCounter INT
SET @intCounter = 1

WHILE (@intFlag <=100) 
BEGIN
    PRINT @intFlag
    UPDATE Sales.Product
	SET ProductName = 'CAR',
	Price = @decimalPrice,
	Supplier = @intCounter
	WHERE ProductID = @intFlag
	IF @intCounter = 6
		BEGIN TRY   
			SET @intCounter = 1
			SET @decimalPrice = 10.00
		END TRY
		BEGIN CATCH
			SET @intCounter = 1
			SET @decimalPrice = 100.00
		END CATCH
	ELSE
		SET @intCounter = @intCounter + 1 
		SET @decimalPrice = @decimalPrice + 10.00

	SET @intFlag = @intFlag + 1
END
GO

CREATE VIEW vw_ProductPrice
AS
SELECT ProductName, Price
FROM Sales.Product
WHERE Supplier = 2;

CREATE VIEW vw_ProductPrice2
AS
SELECT ProductName, Price
FROM Sales.Product
WHERE Supplier = 2;

SELECT ProductName, Price
FROM vw_ProductPrice;

SELECT *
FROM vw_ProductPrice2;

SELECT * FROM Sales.Product;

CREATE PROCEDURE transferFunds
AS
BEGIN TRANSACTION
UPDATE Sales.Product
SET Price += 500
WHERE Supplier = 3;

UPDATE Sales.Product
SET Price -= 500
WHERE Supplier = 2;

COMMIT TRANSACTION
-- or if some error occurs
ROLLBACK TRANSACTION

EXEC transferFunds;

