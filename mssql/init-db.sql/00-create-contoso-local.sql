-- Create Contoso Retail Data Warehouse for Local SQL Server
-- This is a simplified version that works without PolyBase/Azure dependencies

USE master;
GO

-- Drop database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ContosoRetailDW')
BEGIN
    ALTER DATABASE ContosoRetailDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ContosoRetailDW;
END
GO

-- Create the database
CREATE DATABASE ContosoRetailDW;
GO

USE ContosoRetailDW;
GO

-- Create schemas
CREATE SCHEMA [cso];
GO

-- Create dimension tables with sample data

-- DimCurrency
CREATE TABLE [cso].[DimCurrency] (
    [CurrencyKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CurrencyLabel] [nvarchar](10) NOT NULL,
    [CurrencyName] [nvarchar](20) NOT NULL,
    [CurrencyDescription] [nvarchar](50) NOT NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL
);

INSERT INTO [cso].[DimCurrency] ([CurrencyLabel], [CurrencyName], [CurrencyDescription], [LoadDate])
VALUES 
    ('USD', 'US Dollar', 'United States Dollar', GETDATE()),
    ('EUR', 'Euro', 'European Union Euro', GETDATE()),
    ('GBP', 'British Pound', 'British Pound Sterling', GETDATE()),
    ('CAD', 'Canadian Dollar', 'Canadian Dollar', GETDATE()),
    ('JPY', 'Japanese Yen', 'Japanese Yen', GETDATE());

-- DimChannel
CREATE TABLE [cso].[DimChannel] (
    [ChannelKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ChannelLabel] [nvarchar](100) NOT NULL,
    [ChannelName] [nvarchar](20) NULL,
    [ChannelDescription] [nvarchar](50) NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL
);

INSERT INTO [cso].[DimChannel] ([ChannelLabel], [ChannelName], [ChannelDescription], [LoadDate])
VALUES 
    ('Store Channel', 'Store', 'Physical retail stores', GETDATE()),
    ('Online Channel', 'Online', 'E-commerce website', GETDATE()),
    ('Catalog Channel', 'Catalog', 'Mail order catalog', GETDATE()),
    ('Reseller Channel', 'Reseller', 'Third-party resellers', GETDATE());

-- DimGeography
CREATE TABLE [cso].[DimGeography] (
    [GeographyKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [GeographyType] [nvarchar](50) NOT NULL,
    [ContinentName] [nvarchar](50) NOT NULL,
    [CityName] [nvarchar](100) NULL,
    [StateProvinceName] [nvarchar](100) NULL,
    [RegionCountryName] [nvarchar](100) NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL
);

INSERT INTO [cso].[DimGeography] ([GeographyType], [ContinentName], [CityName], [StateProvinceName], [RegionCountryName], [LoadDate])
VALUES 
    ('City', 'North America', 'Seattle', 'Washington', 'United States', GETDATE()),
    ('City', 'North America', 'New York', 'New York', 'United States', GETDATE()),
    ('City', 'North America', 'Los Angeles', 'California', 'United States', GETDATE()),
    ('City', 'North America', 'Toronto', 'Ontario', 'Canada', GETDATE()),
    ('City', 'Europe', 'London', 'England', 'United Kingdom', GETDATE()),
    ('City', 'Europe', 'Paris', 'Île-de-France', 'France', GETDATE()),
    ('City', 'Europe', 'Berlin', 'Berlin', 'Germany', GETDATE()),
    ('City', 'Asia', 'Tokyo', 'Tokyo', 'Japan', GETDATE()),
    ('City', 'Asia', 'Sydney', 'New South Wales', 'Australia', GETDATE());

-- DimProductCategory
CREATE TABLE [cso].[DimProductCategory] (
    [ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ProductCategoryLabel] [nvarchar](100) NULL,
    [ProductCategoryName] [nvarchar](30) NOT NULL,
    [ProductCategoryDescription] [nvarchar](50) NOT NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL
);

INSERT INTO [cso].[DimProductCategory] ([ProductCategoryLabel], [ProductCategoryName], [ProductCategoryDescription], [LoadDate])
VALUES 
    ('Audio', 'Audio', 'Audio equipment and accessories', GETDATE()),
    ('TV and Video', 'TV and Video', 'Television and video equipment', GETDATE()),
    ('Computers', 'Computers', 'Desktop and laptop computers', GETDATE()),
    ('Cameras and camcorders', 'Cameras', 'Digital cameras and camcorders', GETDATE()),
    ('Cell phones', 'Cell phones', 'Mobile phones and accessories', GETDATE()),
    ('Music, Movies and Audio Books', 'Media', 'Entertainment media products', GETDATE()),
    ('Games and Toys', 'Games', 'Video games and toys', GETDATE()),
    ('Home Appliances', 'Appliances', 'Home and kitchen appliances', GETDATE());

-- DimProductSubcategory
CREATE TABLE [cso].[DimProductSubcategory] (
    [ProductSubcategoryKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ProductSubcategoryLabel] [nvarchar](100) NULL,
    [ProductSubcategoryName] [nvarchar](50) NOT NULL,
    [ProductSubcategoryDescription] [nvarchar](100) NULL,
    [ProductCategoryKey] [int] NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([ProductCategoryKey]) REFERENCES [cso].[DimProductCategory]([ProductCategoryKey])
);

INSERT INTO [cso].[DimProductSubcategory] ([ProductSubcategoryLabel], [ProductSubcategoryName], [ProductSubcategoryDescription], [ProductCategoryKey], [LoadDate])
VALUES 
    ('MP4&MP3', 'MP4&MP3', 'Portable music players', 1, GETDATE()),
    ('Audio Headphones', 'Headphones', 'Audio headphones and earbuds', 1, GETDATE()),
    ('Televisions', 'Televisions', 'LCD, LED, and OLED televisions', 2, GETDATE()),
    ('Home Theater System', 'Home Theater', 'Complete home theater systems', 2, GETDATE()),
    ('Desktops', 'Desktops', 'Desktop computer systems', 3, GETDATE()),
    ('Laptops', 'Laptops', 'Portable laptop computers', 3, GETDATE()),
    ('Digital Cameras', 'Digital Cameras', 'Digital photography cameras', 4, GETDATE()),
    ('Camcorders', 'Camcorders', 'Digital video recording devices', 4, GETDATE());

-- DimProduct
CREATE TABLE [cso].[DimProduct] (
    [ProductKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ProductLabel] [nvarchar](255) NULL,
    [ProductName] [nvarchar](500) NULL,
    [ProductDescription] [nvarchar](400) NULL,
    [ProductSubcategoryKey] [int] NULL,
    [Manufacturer] [nvarchar](50) NULL,
    [BrandName] [nvarchar](50) NULL,
    [ClassID] [nvarchar](10) NULL,
    [ClassName] [nvarchar](20) NULL,
    [StyleID] [nvarchar](10) NULL,
    [StyleName] [nvarchar](20) NULL,
    [ColorID] [nvarchar](10) NULL,
    [ColorName] [nvarchar](20) NOT NULL,
    [Size] [nvarchar](50) NULL,
    [SizeRange] [nvarchar](50) NULL,
    [SizeUnitMeasureID] [nvarchar](20) NULL,
    [Weight] [float] NULL,
    [WeightUnitMeasureID] [nvarchar](20) NULL,
    [UnitOfMeasureID] [nvarchar](10) NULL,
    [UnitOfMeasureName] [nvarchar](40) NULL,
    [StockTypeID] [nvarchar](10) NULL,
    [StockTypeName] [nvarchar](40) NULL,
    [UnitCost] [money] NULL,
    [UnitPrice] [money] NULL,
    [AvailableForSaleDate] [datetime] NULL,
    [StopSaleDate] [datetime] NULL,
    [Status] [nvarchar](7) NULL,
    [ImageURL] [nvarchar](150) NULL,
    [ProductURL] [nvarchar](150) NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([ProductSubcategoryKey]) REFERENCES [cso].[DimProductSubcategory]([ProductSubcategoryKey])
);

INSERT INTO [cso].[DimProduct] ([ProductLabel], [ProductName], [ProductDescription], [ProductSubcategoryKey], [Manufacturer], [BrandName], [ColorName], [UnitCost], [UnitPrice], [AvailableForSaleDate], [Status], [LoadDate])
VALUES 
    ('Contoso MP3 Player E100 Silver', 'Contoso MP3 Player E100', 'High-quality portable MP3 player', 1, 'Contoso', 'Contoso', 'Silver', 45.00, 89.99, '2023-01-01', 'Current', GETDATE()),
    ('Contoso Wireless Headphones WH200', 'Contoso Wireless Headphones WH200', 'Bluetooth wireless headphones', 2, 'Contoso', 'Contoso', 'Black', 75.00, 149.99, '2023-01-01', 'Current', GETDATE()),
    ('Contoso 55" 4K Smart TV', 'Contoso 55 inch 4K Smart Television', 'Ultra HD Smart TV with streaming capabilities', 3, 'Contoso', 'Contoso', 'Black', 450.00, 899.99, '2023-01-01', 'Current', GETDATE()),
    ('Contoso Desktop Pro D500', 'Contoso Desktop Computer Pro D500', 'High-performance desktop computer', 5, 'Contoso', 'Contoso', 'Black', 650.00, 1299.99, '2023-01-01', 'Current', GETDATE()),
    ('Contoso Laptop Ultra L300', 'Contoso Laptop Computer Ultra L300', 'Lightweight ultrabook laptop', 6, 'Contoso', 'Contoso', 'Silver', 550.00, 1099.99, '2023-01-01', 'Current', GETDATE()),
    ('Contoso Digital Camera DC400', 'Contoso Digital Camera DC400', 'Professional digital camera', 7, 'Contoso', 'Contoso', 'Black', 350.00, 699.99, '2023-01-01', 'Current', GETDATE());

-- DimStore
CREATE TABLE [cso].[DimStore] (
    [StoreKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [GeographyKey] [int] NOT NULL,
    [StoreManager] [int] NULL,
    [StoreType] [nvarchar](15) NULL,
    [StoreName] [nvarchar](100) NOT NULL,
    [StoreDescription] [nvarchar](300) NOT NULL,
    [Status] [nvarchar](20) NOT NULL,
    [OpenDate] [datetime] NOT NULL,
    [CloseDate] [datetime] NULL,
    [EntityKey] [int] NULL,
    [ZipCode] [nvarchar](20) NULL,
    [ZipCodeExtension] [nvarchar](10) NULL,
    [StorePhone] [nvarchar](15) NULL,
    [StoreFax] [nvarchar](14) NULL,
    [AddressLine1] [nvarchar](100) NULL,
    [AddressLine2] [nvarchar](100) NULL,
    [CloseReason] [nvarchar](20) NULL,
    [EmployeeCount] [int] NULL,
    [SellingAreaSize] [float] NULL,
    [LastRemodelDate] [datetime] NULL,
    [GeoLocation] NVARCHAR(50) NULL,
    [Geometry] NVARCHAR(50) NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([GeographyKey]) REFERENCES [cso].[DimGeography]([GeographyKey])
);

INSERT INTO [cso].[DimStore] ([GeographyKey], [StoreType], [StoreName], [StoreDescription], [Status], [OpenDate], [ZipCode], [StorePhone], [AddressLine1], [EmployeeCount], [SellingAreaSize], [LoadDate])
VALUES 
    (1, 'Store', 'Contoso Seattle Store', 'Flagship store in downtown Seattle', 'Open', '2020-01-15', '98101', '206-555-0100', '123 Pike Street', 45, 5000.0, GETDATE()),
    (2, 'Store', 'Contoso New York Store', 'Premium store in Manhattan', 'Open', '2020-03-01', '10001', '212-555-0200', '456 Broadway', 52, 6500.0, GETDATE()),
    (3, 'Store', 'Contoso Los Angeles Store', 'West Coast flagship store', 'Open', '2020-06-15', '90210', '310-555-0300', '789 Sunset Blvd', 38, 4800.0, GETDATE()),
    (4, 'Store', 'Contoso Toronto Store', 'Canadian flagship store', 'Open', '2021-01-01', 'M5V 3A8', '416-555-0400', '321 Queen Street', 35, 4200.0, GETDATE()),
    (5, 'Store', 'Contoso London Store', 'European flagship store', 'Open', '2021-04-01', 'SW1A 1AA', '020-7555-0500', '654 Oxford Street', 42, 5500.0, GETDATE());

-- DimCustomer
CREATE TABLE [cso].[DimCustomer] (
    [CustomerKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [GeographyKey] [int] NOT NULL,
    [CustomerLabel] [nvarchar](100) NOT NULL,
    [Title] [nvarchar](8) NULL,
    [FirstName] [nvarchar](50) NULL,
    [MiddleName] [nvarchar](50) NULL,
    [LastName] [nvarchar](50) NULL,
    [NameStyle] [bit] NULL,
    [BirthDate] [datetime] NULL,
    [MaritalStatus] [nchar](1) NULL,
    [Suffix] [nvarchar](10) NULL,
    [Gender] [nvarchar](1) NULL,
    [EmailAddress] [nvarchar](50) NULL,
    [YearlyIncome] [money] NULL,
    [TotalChildren] [tinyint] NULL,
    [NumberChildrenAtHome] [tinyint] NULL,
    [Education] [nvarchar](40) NULL,
    [Occupation] [nvarchar](100) NULL,
    [HouseOwnerFlag] [nchar](1) NULL,
    [NumberCarsOwned] [tinyint] NULL,
    [AddressLine1] [nvarchar](120) NULL,
    [AddressLine2] [nvarchar](120) NULL,
    [Phone] [nvarchar](20) NULL,
    [DateFirstPurchase] [datetime] NULL,
    [CustomerType] [nvarchar](15) NULL,
    [CompanyName] [nvarchar](100) NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([GeographyKey]) REFERENCES [cso].[DimGeography]([GeographyKey])
);

INSERT INTO [cso].[DimCustomer] ([GeographyKey], [CustomerLabel], [FirstName], [LastName], [Gender], [EmailAddress], [YearlyIncome], [Education], [Occupation], [CustomerType], [DateFirstPurchase], [LoadDate])
VALUES 
    (1, 'John Smith', 'John', 'Smith', 'M', 'john.smith@email.com', 75000, 'Bachelors', 'Professional', 'Person', '2023-02-15', GETDATE()),
    (2, 'Sarah Johnson', 'Sarah', 'Johnson', 'F', 'sarah.johnson@email.com', 85000, 'Graduate Degree', 'Management', 'Person', '2023-01-20', GETDATE()),
    (3, 'Michael Brown', 'Michael', 'Brown', 'M', 'michael.brown@email.com', 65000, 'Bachelors', 'Skilled Manual', 'Person', '2023-03-10', GETDATE()),
    (4, 'Emily Davis', 'Emily', 'Davis', 'F', 'emily.davis@email.com', 95000, 'Graduate Degree', 'Professional', 'Person', '2023-01-05', GETDATE()),
    (5, 'David Wilson', 'David', 'Wilson', 'M', 'david.wilson@email.com', 70000, 'Bachelors', 'Clerical', 'Person', '2023-02-28', GETDATE());

-- DimDate (simplified version with key dates)
CREATE TABLE [cso].[DimDate] (
    [Datekey] [datetime] NOT NULL PRIMARY KEY,
    [FullDateLabel] [nvarchar](20) NOT NULL,
    [DateDescription] [nvarchar](20) NOT NULL,
    [CalendarYear] [int] NOT NULL,
    [CalendarYearLabel] [nvarchar](20) NOT NULL,
    [CalendarHalfYear] [int] NOT NULL,
    [CalendarHalfYearLabel] [nvarchar](20) NOT NULL,
    [CalendarQuarter] [int] NOT NULL,
    [CalendarQuarterLabel] [nvarchar](20) NULL,
    [CalendarMonth] [int] NOT NULL,
    [CalendarMonthLabel] [nvarchar](20) NOT NULL,
    [CalendarWeek] [int] NOT NULL,
    [CalendarWeekLabel] [nvarchar](20) NOT NULL,
    [CalendarDayOfWeek] [int] NOT NULL,
    [CalendarDayOfWeekLabel] [nvarchar](10) NOT NULL,
    [FiscalYear] [int] NOT NULL,
    [FiscalYearLabel] [nvarchar](20) NOT NULL,
    [FiscalHalfYear] [int] NOT NULL,
    [FiscalHalfYearLabel] [nvarchar](20) NOT NULL,
    [FiscalQuarter] [int] NOT NULL,
    [FiscalQuarterLabel] [nvarchar](20) NOT NULL,
    [FiscalMonth] [int] NOT NULL,
    [FiscalMonthLabel] [nvarchar](20) NOT NULL,
    [IsWorkDay] [nvarchar](20) NOT NULL,
    [IsHoliday] [int] NOT NULL,
    [HolidayName] [nvarchar](20) NOT NULL,
    [EuropeSeason] [nvarchar](50) NULL,
    [NorthAmericaSeason] [nvarchar](50) NULL,
    [AsiaSeason] [nvarchar](50) NULL
);

-- Insert sample dates for 2023
DECLARE @StartDate datetime = '2023-01-01';
DECLARE @EndDate datetime = '2023-12-31';
DECLARE @CurrentDate datetime = @StartDate;

WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO [cso].[DimDate] (
        [Datekey], [FullDateLabel], [DateDescription], [CalendarYear], [CalendarYearLabel],
        [CalendarHalfYear], [CalendarHalfYearLabel], [CalendarQuarter], [CalendarQuarterLabel],
        [CalendarMonth], [CalendarMonthLabel], [CalendarWeek], [CalendarWeekLabel],
        [CalendarDayOfWeek], [CalendarDayOfWeekLabel], [FiscalYear], [FiscalYearLabel],
        [FiscalHalfYear], [FiscalHalfYearLabel], [FiscalQuarter], [FiscalQuarterLabel],
        [FiscalMonth], [FiscalMonthLabel], [IsWorkDay], [IsHoliday], [HolidayName],
        [EuropeSeason], [NorthAmericaSeason], [AsiaSeason]
    )
    VALUES (
        @CurrentDate,
        FORMAT(@CurrentDate, 'yyyy-MM-dd'),
        FORMAT(@CurrentDate, 'MMM dd, yyyy'),
        YEAR(@CurrentDate),
        'CY ' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        CASE WHEN MONTH(@CurrentDate) <= 6 THEN 1 ELSE 2 END,
        'H' + CAST(CASE WHEN MONTH(@CurrentDate) <= 6 THEN 1 ELSE 2 END AS varchar(1)) + ' CY' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        DATEPART(QUARTER, @CurrentDate),
        'Q' + CAST(DATEPART(QUARTER, @CurrentDate) AS varchar(1)) + ' CY' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        MONTH(@CurrentDate),
        FORMAT(@CurrentDate, 'MMMM yyyy'),
        DATEPART(WEEK, @CurrentDate),
        'Week ' + CAST(DATEPART(WEEK, @CurrentDate) AS varchar(2)),
        DATEPART(WEEKDAY, @CurrentDate),
        FORMAT(@CurrentDate, 'dddd'),
        YEAR(@CurrentDate),
        'FY ' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        CASE WHEN MONTH(@CurrentDate) <= 6 THEN 1 ELSE 2 END,
        'H' + CAST(CASE WHEN MONTH(@CurrentDate) <= 6 THEN 1 ELSE 2 END AS varchar(1)) + ' FY' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        DATEPART(QUARTER, @CurrentDate),
        'Q' + CAST(DATEPART(QUARTER, @CurrentDate) AS varchar(1)) + ' FY' + CAST(YEAR(@CurrentDate) AS varchar(4)),
        MONTH(@CurrentDate),
        FORMAT(@CurrentDate, 'MMMM yyyy'),
        CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1, 7) THEN 'Non Work Day' ELSE 'Work Day' END,
        0,
        'None',
        CASE 
            WHEN MONTH(@CurrentDate) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(@CurrentDate) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(@CurrentDate) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END,
        CASE 
            WHEN MONTH(@CurrentDate) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(@CurrentDate) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(@CurrentDate) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END,
        CASE 
            WHEN MONTH(@CurrentDate) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(@CurrentDate) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(@CurrentDate) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END
    );
    
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;

-- DimPromotion
CREATE TABLE [cso].[DimPromotion] (
    [PromotionKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [PromotionLabel] [nvarchar](100) NULL,
    [PromotionName] [nvarchar](100) NULL,
    [PromotionDescription] [nvarchar](255) NULL,
    [DiscountPercent] [float] NULL,
    [PromotionType] [nvarchar](50) NULL,
    [PromotionCategory] [nvarchar](50) NULL,
    [StartDate] [datetime] NOT NULL,
    [EndDate] [datetime] NULL,
    [MinQuantity] [int] NULL,
    [MaxQuantity] [int] NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL
);

INSERT INTO [cso].[DimPromotion] ([PromotionLabel], [PromotionName], [PromotionDescription], [DiscountPercent], [PromotionType], [PromotionCategory], [StartDate], [EndDate], [LoadDate])
VALUES 
    ('No Discount', 'No Discount', 'No discount applied', 0.0, 'None', 'None', '2023-01-01', NULL, GETDATE()),
    ('New Year Sale', 'New Year 2023 Sale', '15% off all electronics', 0.15, 'Percentage', 'Seasonal', '2023-01-01', '2023-01-15', GETDATE()),
    ('Spring Promotion', 'Spring Electronics Sale', '10% off selected items', 0.10, 'Percentage', 'Seasonal', '2023-03-01', '2023-03-31', GETDATE()),
    ('Summer Clearance', 'Summer Clearance Event', '20% off discontinued items', 0.20, 'Percentage', 'Clearance', '2023-06-01', '2023-08-31', GETDATE()),
    ('Black Friday', 'Black Friday Mega Sale', '25% off everything', 0.25, 'Percentage', 'Holiday', '2023-11-24', '2023-11-26', GETDATE());

-- Create fact tables

-- FactSales
CREATE TABLE [cso].[FactSales] (
    [SalesKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DateKey] [datetime] NOT NULL,
    [channelKey] [int] NOT NULL,
    [StoreKey] [int] NOT NULL,
    [ProductKey] [int] NOT NULL,
    [PromotionKey] [int] NOT NULL,
    [CurrencyKey] [int] NOT NULL,
    [UnitCost] [money] NOT NULL,
    [UnitPrice] [money] NOT NULL,
    [SalesQuantity] [int] NOT NULL,
    [ReturnQuantity] [int] NOT NULL,
    [ReturnAmount] [money] NULL,
    [DiscountQuantity] [int] NULL,
    [DiscountAmount] [money] NULL,
    [TotalCost] [money] NOT NULL,
    [SalesAmount] [money] NOT NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([DateKey]) REFERENCES [cso].[DimDate]([Datekey]),
    FOREIGN KEY ([channelKey]) REFERENCES [cso].[DimChannel]([ChannelKey]),
    FOREIGN KEY ([StoreKey]) REFERENCES [cso].[DimStore]([StoreKey]),
    FOREIGN KEY ([ProductKey]) REFERENCES [cso].[DimProduct]([ProductKey]),
    FOREIGN KEY ([PromotionKey]) REFERENCES [cso].[DimPromotion]([PromotionKey]),
    FOREIGN KEY ([CurrencyKey]) REFERENCES [cso].[DimCurrency]([CurrencyKey])
);

-- Insert sample sales data
INSERT INTO [cso].[FactSales] ([DateKey], [channelKey], [StoreKey], [ProductKey], [PromotionKey], [CurrencyKey], [UnitCost], [UnitPrice], [SalesQuantity], [ReturnQuantity], [ReturnAmount], [DiscountQuantity], [DiscountAmount], [TotalCost], [SalesAmount], [LoadDate])
VALUES 
    ('2023-01-15', 1, 1, 1, 2, 1, 45.00, 89.99, 5, 0, 0, 0, 67.49, 225.00, 382.46, GETDATE()),
    ('2023-01-20', 2, 2, 2, 1, 1, 75.00, 149.99, 3, 0, 0, 0, 0, 225.00, 449.97, GETDATE()),
    ('2023-02-10', 1, 3, 3, 1, 1, 450.00, 899.99, 2, 0, 0, 0, 0, 900.00, 1799.98, GETDATE()),
    ('2023-02-15', 1, 1, 4, 1, 1, 650.00, 1299.99, 1, 0, 0, 0, 0, 650.00, 1299.99, GETDATE()),
    ('2023-03-05', 2, 4, 5, 3, 1, 550.00, 1099.99, 2, 0, 0, 0, 219.998, 1100.00, 1979.98, GETDATE()),
    ('2023-03-15', 1, 5, 6, 3, 1, 350.00, 699.99, 3, 1, 629.99, 0, 209.997, 1050.00, 1469.97, GETDATE()),
    ('2023-04-01', 2, 1, 1, 1, 1, 45.00, 89.99, 10, 0, 0, 0, 0, 450.00, 899.90, GETDATE()),
    ('2023-04-15', 1, 2, 2, 1, 1, 75.00, 149.99, 4, 0, 0, 0, 0, 300.00, 599.96, GETDATE()),
    ('2023-05-01', 2, 3, 3, 1, 1, 450.00, 899.99, 1, 0, 0, 0, 0, 450.00, 899.99, GETDATE()),
    ('2023-05-20', 1, 4, 4, 1, 1, 650.00, 1299.99, 2, 0, 0, 0, 0, 1300.00, 2599.98, GETDATE()),
    ('2023-06-10', 2, 5, 5, 4, 1, 550.00, 1099.99, 3, 0, 0, 0, 659.994, 1650.00, 2639.97, GETDATE()),
    ('2023-07-04', 1, 1, 6, 4, 1, 350.00, 699.99, 5, 1, 559.99, 0, 699.99, 1750.00, 2799.95, GETDATE()),
    ('2023-08-15', 2, 2, 1, 4, 1, 45.00, 89.99, 8, 0, 0, 0, 143.984, 360.00, 575.92, GETDATE()),
    ('2023-09-01', 1, 3, 2, 1, 1, 75.00, 149.99, 6, 0, 0, 0, 0, 450.00, 899.94, GETDATE()),
    ('2023-10-15', 2, 4, 3, 1, 1, 450.00, 899.99, 1, 0, 0, 0, 0, 450.00, 899.99, GETDATE()),
    ('2023-11-25', 1, 5, 4, 5, 1, 650.00, 1299.99, 3, 0, 0, 0, 974.9925, 1950.00, 2924.97, GETDATE()),
    ('2023-12-01', 2, 1, 5, 5, 1, 550.00, 1099.99, 2, 0, 0, 0, 549.995, 1100.00, 1649.98, GETDATE()),
    ('2023-12-20', 1, 2, 6, 5, 1, 350.00, 699.99, 4, 0, 0, 0, 699.99, 1400.00, 2099.96, GETDATE());

-- FactOnlineSales
CREATE TABLE [cso].[FactOnlineSales] (
    [OnlineSalesKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DateKey] [datetime] NOT NULL,
    [StoreKey] [int] NOT NULL,
    [ProductKey] [int] NOT NULL,
    [PromotionKey] [int] NOT NULL,
    [CurrencyKey] [int] NOT NULL,
    [CustomerKey] [int] NOT NULL,
    [SalesOrderNumber] [nvarchar](20) NOT NULL,
    [SalesOrderLineNumber] [int] NULL,
    [SalesQuantity] [int] NOT NULL,
    [SalesAmount] [money] NOT NULL,
    [ReturnQuantity] [int] NOT NULL,
    [ReturnAmount] [money] NULL,
    [DiscountQuantity] [int] NULL,
    [DiscountAmount] [money] NULL,
    [TotalCost] [money] NOT NULL,
    [UnitCost] [money] NULL,
    [UnitPrice] [money] NULL,
    [ETLLoadID] [int] NULL,
    [LoadDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    FOREIGN KEY ([DateKey]) REFERENCES [cso].[DimDate]([Datekey]),
    FOREIGN KEY ([StoreKey]) REFERENCES [cso].[DimStore]([StoreKey]),
    FOREIGN KEY ([ProductKey]) REFERENCES [cso].[DimProduct]([ProductKey]),
    FOREIGN KEY ([PromotionKey]) REFERENCES [cso].[DimPromotion]([PromotionKey]),
    FOREIGN KEY ([CurrencyKey]) REFERENCES [cso].[DimCurrency]([CurrencyKey]),
    FOREIGN KEY ([CustomerKey]) REFERENCES [cso].[DimCustomer]([CustomerKey])
);

-- Insert sample online sales data
INSERT INTO [cso].[FactOnlineSales] ([DateKey], [StoreKey], [ProductKey], [PromotionKey], [CurrencyKey], [CustomerKey], [SalesOrderNumber], [SalesOrderLineNumber], [SalesQuantity], [SalesAmount], [ReturnQuantity], [ReturnAmount], [DiscountQuantity], [DiscountAmount], [TotalCost], [UnitCost], [UnitPrice], [LoadDate])
VALUES 
    ('2023-01-10', 1, 1, 2, 1, 1, 'SO-2023-001', 1, 2, 152.98, 0, 0, 0, 22.998, 90.00, 45.00, 89.99, GETDATE()),
    ('2023-01-25', 2, 2, 1, 1, 2, 'SO-2023-002', 1, 1, 149.99, 0, 0, 0, 0, 75.00, 75.00, 149.99, GETDATE()),
    ('2023-02-05', 1, 3, 1, 1, 3, 'SO-2023-003', 1, 1, 899.99, 0, 0, 0, 0, 450.00, 450.00, 899.99, GETDATE()),
    ('2023-02-20', 2, 4, 1, 1, 4, 'SO-2023-004', 1, 1, 1299.99, 0, 0, 0, 0, 650.00, 650.00, 1299.99, GETDATE()),
    ('2023-03-12', 1, 5, 3, 1, 5, 'SO-2023-005', 1, 1, 989.99, 0, 0, 0, 109.999, 550.00, 550.00, 1099.99, GETDATE()),
    ('2023-03-28', 2, 6, 3, 1, 1, 'SO-2023-006', 1, 2, 1259.98, 0, 0, 0, 139.998, 700.00, 350.00, 699.99, GETDATE()),
    ('2023-04-08', 1, 1, 1, 1, 2, 'SO-2023-007', 1, 3, 269.97, 0, 0, 0, 0, 135.00, 45.00, 89.99, GETDATE()),
    ('2023-04-22', 2, 2, 1, 1, 3, 'SO-2023-008', 1, 2, 299.98, 0, 0, 0, 0, 150.00, 75.00, 149.99, GETDATE()),
    ('2023-05-15', 1, 3, 1, 1, 4, 'SO-2023-009', 1, 1, 899.99, 0, 0, 0, 0, 450.00, 450.00, 899.99, GETDATE()),
    ('2023-06-30', 2, 4, 4, 1, 5, 'SO-2023-010', 1, 1, 1039.99, 0, 0, 0, 259.998, 650.00, 650.00, 1299.99, GETDATE());

-- Create indexes for better performance
CREATE INDEX IX_FactSales_DateKey ON [cso].[FactSales]([DateKey]);
CREATE INDEX IX_FactSales_ProductKey ON [cso].[FactSales]([ProductKey]);
CREATE INDEX IX_FactSales_StoreKey ON [cso].[FactSales]([StoreKey]);
CREATE INDEX IX_FactSales_ChannelKey ON [cso].[FactSales]([channelKey]);

CREATE INDEX IX_FactOnlineSales_DateKey ON [cso].[FactOnlineSales]([DateKey]);
CREATE INDEX IX_FactOnlineSales_ProductKey ON [cso].[FactOnlineSales]([ProductKey]);
CREATE INDEX IX_FactOnlineSales_CustomerKey ON [cso].[FactOnlineSales]([CustomerKey]);

GO

-- Create some useful views for analysis
CREATE VIEW [cso].[vw_SalesByProduct] AS
SELECT 
    p.ProductName,
    p.BrandName,
    pc.ProductCategoryName,
    SUM(fs.SalesQuantity) AS TotalQuantitySold,
    SUM(fs.SalesAmount) AS TotalSalesAmount,
    AVG(fs.UnitPrice) AS AverageUnitPrice
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimProduct] p ON fs.ProductKey = p.ProductKey
    INNER JOIN [cso].[DimProductSubcategory] psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
    INNER JOIN [cso].[DimProductCategory] pc ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY p.ProductName, p.BrandName, pc.ProductCategoryName;
GO

CREATE VIEW [cso].[vw_SalesByStore] AS
SELECT 
    s.StoreName,
    g.CityName,
    g.RegionCountryName,
    SUM(fs.SalesQuantity) AS TotalQuantitySold,
    SUM(fs.SalesAmount) AS TotalSalesAmount,
    COUNT(DISTINCT fs.DateKey) AS DaysWithSales
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimStore] s ON fs.StoreKey = s.StoreKey
    INNER JOIN [cso].[DimGeography] g ON s.GeographyKey = g.GeographyKey
GROUP BY s.StoreName, g.CityName, g.RegionCountryName;
GO

CREATE VIEW [cso].[vw_SalesByMonth] AS
SELECT 
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel,
    SUM(fs.SalesQuantity) AS TotalQuantitySold,
    SUM(fs.SalesAmount) AS TotalSalesAmount,
    COUNT(DISTINCT fs.ProductKey) AS UniqueProductsSold
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimDate] d ON fs.DateKey = d.Datekey
GROUP BY d.CalendarYear, d.CalendarMonth, d.CalendarMonthLabel;
GO

-- Sample query to test the database
SELECT 'Database setup completed successfully!' AS Status;
SELECT 'Sample query - Sales by brand:' AS QueryType;

SELECT  
    SUM(f.[SalesAmount]) AS [sales_by_brand_amount],
    p.[BrandName]
FROM    [cso].[FactSales] AS f
JOIN    [cso].[DimProduct] AS p ON f.[ProductKey] = p.[ProductKey]
GROUP BY p.[BrandName]
ORDER BY [sales_by_brand_amount] DESC;

PRINT 'Contoso Retail Data Warehouse has been successfully created and populated with sample data!';
