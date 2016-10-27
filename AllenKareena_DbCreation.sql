CREATE DATABASE AllenKareena_Db;
GO

USE AllenKareena_Db;
GO

---Creating Tables
CREATE TABLE [dbo].[Location] (
    [LocationID]     BIGINT       NOT NULL,
    [City]           VARCHAR (50) NULL,
    [State/Province] VARCHAR (50) NULL,
    [ZipCode]        VARCHAR (9)  NULL,
    [Country]        VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([LocationID] ASC)
);
GO

CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]  BIGINT        NOT NULL,
    [CompanyName] TEXT          NULL,
    [AddressLine] TEXT          NULL,
    [City]        VARCHAR (MAX) NULL,
    [State]       VARCHAR (MAX) NULL,
    [Country]     VARCHAR (50)  NULL,
    [ZipCode]     VARCHAR (9)   NULL,
    PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);
GO


CREATE TABLE [dbo].[Product] (
    [ProductID]     BIGINT        NOT NULL,
    [SKUNum]        VARCHAR (MAX) NOT NULL,
    [ProductName]   VARCHAR (50)  NOT NULL,
    [ProductType]   VARCHAR (50)  NULL,
    [SuggUnitPrice] MONEY         NULL,
    [SupplierID]    BIGINT        NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Product_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])
);
GO

CREATE TABLE [dbo].[PurchaseOrder] (
    [OrderID]       BIGINT NOT NULL,
    [DatePlaced]    DATE   NULL,
    [DateDelivered] DATE   NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC)
);
GO

CREATE TABLE [dbo].[PurchaseOrderDetail] (
    [OrderDetailID] BIGINT NOT NULL,
    [OrderID]       BIGINT NOT NULL,
    [SupplierID]    BIGINT NOT NULL,
    [ProductID]     BIGINT NOT NULL,
    [OrderQty]      BIGINT NULL,
    [LineTotal]     MONEY  NULL,
    PRIMARY KEY CLUSTERED ([OrderDetailID] ASC),
    CONSTRAINT [FK_PurchaseOrderDetail_OrderID] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[PurchaseOrder] ([OrderID]),
    CONSTRAINT [FK_PurchaseOrderDetail_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID]),
    CONSTRAINT [FK_PurchaseOrderDetail_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);
GO

CREATE TABLE [dbo].[Store] (
    [StoreID]       BIGINT        NOT NULL,
    [LocationID]    BIGINT        NOT NULL,
    [SqFootage]     BIGINT        NULL,
    [StoreSizeType] VARCHAR (50)  NULL,
    [NumEmployees]  BIGINT        NULL,
    [AddressLines]  VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([StoreID] ASC),
    CONSTRAINT [FK_Store_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID])
);
GO

CREATE TABLE [dbo].[Store_Products] (
    [Store_ProductID] BIGINT NOT NULL,
    [StoreID]         BIGINT NOT NULL,
    [ProductID]       BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([Store_ProductID] ASC),
    CONSTRAINT [FK_Store_Products] FOREIGN KEY ([StoreID]) REFERENCES [dbo].[Store] ([StoreID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_Store_Products_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [dbo].[Store] ([StoreID]),
    CONSTRAINT [FK_Store_Products_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID])
);
GO

CREATE TABLE [dbo].[StoreSales] (
    [SalesID]           BIGINT NOT NULL,
    [StoreID]           BIGINT NOT NULL,
    [Date]              DATE   NOT NULL,
    [TotalTransactions] BIGINT NULL,
    [TotalRevenue]      MONEY  NULL,
    [TotalCost]         MONEY  NULL,
    PRIMARY KEY CLUSTERED ([SalesID] ASC),
    CONSTRAINT [FK_StoreSales_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [dbo].[Store] ([StoreID])
);
GO

CREATE TABLE [dbo].[Supplier Contact] (
    [ContactID]  BIGINT        NOT NULL,
    [SupplierID] BIGINT        NOT NULL,
    [FirstName]  VARCHAR (50)  NULL,
    [LastName]   NVARCHAR (50) NULL,
    [Email]      VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([ContactID] ASC),
    CONSTRAINT [FK_Supplier Contact_SupplierID] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])
);
GO

---Inserting Data into Tables
INSERT INTO Location ([LocationID], [City], [State/Province], [ZipCode], [Country]) VALUES 
(1, N'Boston', N'MA', N'02108', N'United States'),
(2, N'New York', N'NY', N'10012', N'United States'),
(3, N'Los Angeles', N'CA', N'90001', N'United States'),
(4, N'Chicago', N'IL', N'60290', N'United States'),
(5, N'Houston', N'TX', N'77001', N'United States'),
(6, N'San Fransisco', N'CA', N'94101', N'United States'),
(7, N'Wellesley', N'MA', N'02481', N'United States'),
(8, N'Newton', N'MA', N'02458', N'United States'),
(9, N'San Antonio', N'TX', N'78201', N'United States'),
(10, N'Miami', N'FL', N'33101', N'United States');
GO

INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [AddressLine], [City], [State], [Country], [ZipCode]) VALUES 
(1, N'AK Furnitures', N'123 Forest Street', N'Wellesley', N'MA', N'United States', N'02481'),
(2, N'KA Stationary', N'98 Tower Road', N'Bangkok', NULL, N'Thailand', N'10110'),
(3, N'AK2 Office', N'110 Tree Street', N'Bangkok', NULL, N'Thailand', N'10230'),
(4, N'KA2 Woodwork', N'333 Wood Avenue', N'Shanghai', NULL, N'China', N'200000'),
(5, N'KAA Supplies', N'900 Chair Street', N'Chengdu', N'Sichuan', N'China', N'610000'),
(6, N'AKA Furnishings', N'888 Sky Avenue', N'Mumbai', N'Maharashtra', N'India', N'400058'),
(7, N'AKK Super Supplies', N'288 Milton Circle', N'Detroit', N'MI', N'United States', N'48201'),
(8, N'KAK & Company', N'999 Zhi County', N'Shenzhen City', N'Guangdong', N'China', N'518000'),
(9, N'AAA Exports', N'512 Andra Boulevard', N'Kolkata', N'West Bengal', N'India', N'700001'),
(10, N'AAK Stationary Supplies', N'201 Bird Street', N'Seattle', N'WA', N'United States', N'98101');
GO

INSERT INTO Product ([ProductID], [SKUNum], [ProductName], [ProductType], [SuggUnitPrice], [SupplierID]) VALUES
(1, N'10000', N'Bark Table', N'Furniture', CAST(250.0000 AS Money), 1),
(2, N'10001', N'Bark Chair', N'Furniture', CAST(100.0000 AS Money), 1),
(3, N'10002', N'2B Pencil 6-Set', N'Stationary', CAST(2.0000 AS Money), 2),
(4, N'10003', N'Blue Ballpoint 6-Set', N'Stationary', CAST(7.0000 AS Money), 2),
(5, N'10004', N'Small Plastic Drawers', N'Office Supplies', CAST(18.0000 AS Money), 3),
(6, N'10005', N'Wooden Stool', N'Furniture', CAST(30.0000 AS Money), 4),
(7, N'10006', N'Wired Desk Organizer', N'Office Supplies', CAST(24.9900 AS Money), 5),
(8, N'10007', N'Walnut XL Shelf', N'Furniture', CAST(188.9900 AS Money), 6),
(9, N'10008', N'Paperclip 500-Pack', N'Office Supplies', CAST(5.7900 AS Money), 7),
(10, N'10009', N'Wireless Printer', N'Office Supplies', CAST(90.0000 AS Money), 8),
(11, N'10010', N'Erasers 5-Pack', N'Stationary', CAST(3.0000 AS Money), 9),
(12, N'10011', N'Highlighters 5-Pack', N'Stationary', CAST(5.0000 AS Money), 10);
GO

INSERT INTO [dbo].[PurchaseOrder] ([OrderID], [DatePlaced], [DateDelivered]) VALUES 
(1, N'2016-12-20', N'2016-02-01'),
(2, N'2016-03-05', N'2016-04-02'),
(3, N'2016-04-08', N'2016-04-20'),
(4, N'2016-04-09', N'2016-04-25'),
(5, N'2016-09-08', N'2016-09-18'),
(6, N'2016-09-15', N'2016-09-30'),
(7, N'2016-09-26', N'2016-10-04'),
(8, N'2016-09-30', N'2016-10-15'),
(9, N'2016-10-04', N'2016-10-22'),
(10, N'2016-10-07', N'2016-10-25');
GO

INSERT INTO [dbo].[PurchaseOrderDetail] ([OrderDetailID], [OrderID], [SupplierID], [ProductID], [OrderQty], [LineTotal]) VALUES 
(1, 1, 5, 7, 700, CAST(7000.0000 AS Money)),
(2, 2, 10, 12, 1200, CAST(4200.0000 AS Money)),
(3, 3, 1, 2, 300, CAST(15000.0000 AS Money)),
(4, 3, 1, 1, 100, CAST(18000.0000 AS Money)),
(5, 4, 3, 5, 650, CAST(6500.0000 AS Money)),
(6, 5, 8, 10, 50, CAST(2500.0000 AS Money)),
(7, 6, 9, 11, 5000, CAST(7500.0000 AS Money)),
(8, 7, 7, 9, 5000, CAST(15000.0000 AS Money)),
(9, 8, 6, 8, 100, CAST(13000.0000 AS Money)),
(10, 9, 2, 3, 5000, CAST(5000.0000 AS Money)),
(11, 10, 4, 6, 1000, CAST(22000.0000 AS Money));
GO

INSERT INTO [dbo].[Store] ([StoreID], [LocationID], [SqFootage], [StoreSizeType], [NumEmployees], [AddressLines]) VALUES 
(1, 1, 500, N'Medium', 35, N'111 Berkeley Street'),
(2, 1, 1000, N'Large', 70, N'800 Clarendon Street'),
(3, 2, 200, N'Small', 20, N'200 W 14th Street'),
(4, 3, 700, N'Medium', 43, N'1000 Sunset Boulevard'),
(5, 4, 1500, N'Large', 100, N'76 D Street'),
(6, 5, 300, N'Small', 26, N'400 Woodside Street'),
(7, 6, 800, N'Medium', 47, N'190 Manchester Avenue'),
(8, 7, 200, N'Small', 20, N'12 Bearing Road'),
(9, 8, 150, N'Small', 17, N'99 Coleman Drive'),
(10, 9, 500, N'Medium', 32, N'110 Wellesley Street'),
(11, 10, 300, N'Small', 24, N'88 East Street');
GO

INSERT INTO [dbo].[Store_Products] ([Store_ProductID], [StoreID], [ProductID]) VALUES 
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 2, 1),
(12, 2, 2),
(13, 2, 3),
(14, 2, 4),
(15, 2, 5),
(16, 2, 6),
(17, 2, 7),
(18, 2, 8),
(19, 2, 9),
(20, 2, 10),
(21, 2, 11),
(22, 2, 12),
(23, 3, 1),
(24, 3, 2),
(25, 3, 6),
(26, 3, 7),
(27, 3, 12),
(28, 4, 1),
(29, 4, 2),
(30, 4, 3),
(31, 4, 4),
(32, 4, 5),
(33, 4, 8),
(34, 4, 10),
(35, 5, 1),
(36, 5, 2),
(37, 5, 3),
(38, 5, 4),
(39, 5, 5),
(40, 5, 6),
(41, 5, 7),
(42, 5, 8),
(43, 5, 9),
(44, 5, 10),
(45, 5, 11),
(46, 5, 12),
(47, 6, 2),
(48, 6, 3),
(49, 6, 4),
(50, 6, 5),
(51, 6, 6),
(52, 6, 7),
(53, 6, 9),
(54, 6, 10),
(55, 7, 1),
(56, 7, 3),
(57, 7, 4),
(58, 7, 5),
(59, 8, 2),
(60, 8, 3),
(61, 8, 5),
(62, 8, 6),
(63, 9, 1),
(64, 9, 2),
(65, 9, 3),
(66, 9, 4),
(67, 9, 5),
(68, 9, 6),
(69, 9, 8),
(70, 9, 12),
(71, 10, 4),
(72, 10, 5),
(73, 10, 6),
(74, 10, 7),
(75, 10, 8),
(76, 10, 9),
(77, 11, 1),
(78, 11, 2),
(79, 11, 5),
(80, 11, 10),
(81, 11, 11),
(82, 11, 12);
GO 

INSERT INTO [dbo].[StoreSales] ([SalesID], [StoreID], [Date], [TotalTransactions], [TotalRevenue], [TotalCost]) VALUES 
(1, 1, N'2016-09-30', 15000, CAST(61890.0000 AS Money), CAST(30000.0000 AS Money)),
(2, 2, N'2016-09-30', 30000, CAST(110890.0000 AS Money), CAST(40000.0000 AS Money)),
(3, 3, N'2016-09-30', 80000, CAST(900831.0000 AS Money), CAST(500158.0000 AS Money)),
(4, 4, N'2016-09-30', 55000, CAST(500600.0000 AS Money), CAST(24000.0000 AS Money)),
(5, 5, N'2016-09-30', 11000, CAST(54839.0000 AS Money), CAST(29888.0000 AS Money)),
(6, 6, N'2016-09-30', 77333, CAST(853053.0000 AS Money), CAST(699000.0000 AS Money)),
(7, 7, N'2016-09-30', 48888, CAST(400344.0000 AS Money), CAST(259933.0000 AS Money)),
(8, 8, N'2016-09-30', 23768, CAST(79999.0000 AS Money), CAST(88405.0000 AS Money)),
(9, 9, N'2016-09-30', 34777, CAST(149357.0000 AS Money), CAST(168384.0000 AS Money)),
(10, 10, N'2016-09-30', 98237, CAST(1000577.0000 AS Money), CAST(766747.0000 AS Money)),
(11, 11, N'2016-09-30', 67383, CAST(664733.0000 AS Money), CAST(493757.0000 AS Money));
GO

INSERT INTO [dbo].[Supplier Contact] ([ContactID], [SupplierID], [FirstName], [LastName], [Email]) VALUES 
(1, 1, N'Andrew', N'Anderson', N'aanderson@gmail.com'),
(2, 1, N'Mark', N'Webber', N'mwebber@gmail.com'),
(3, 2, N'Weerapat', N'Thongplengsri', N'wthongplengsri@gmail.com'),
(4, 3, N'James', N'Sertthin', N'jsertthin@gmail.com'),
(5, 4, N'Rob', N'Chen', N'rchen@gmail.com'),
(6, 5, N'Alex', N'Zhang', N'azhang@gmail.com'),
(7, 6, N'Rajesh', N'Zuvinder', N'rzuvinder@gmail.com'),
(8, 7, N'Alexandra', N'Smith', N'asmith@gmail.com'),
(9, 8, N'Zhi', N'Wang', N'zwang@gmail.com'),
(10, 9, N'Janak', N'Patel', N'jpatel@gmail.com'),
(11, 10, N'Wendy', N'Davis', N'wdavis@gmail.com');
GO
 



