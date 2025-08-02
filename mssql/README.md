## useful scripts

- to check sql serve r is up and running (via docker compose)
```bash
docker exec mssql-server /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P TempSA_Password123! -C -Q "SELECT @@VERSION"
```
- to find out WSL ip 
```bash
#e.g. if blow command returns 172.22.3.106, then in SSMS UI "server" should be: 172.22.3.106,1433 
ip addr show eth0
```

# Contoso Retail Data Warehouse - Sample Database

This setup includes the Contoso Retail Data Warehouse sample database that gets automatically created when you start the SQL Server container.

## What's Included

### Database Structure
The Contoso database includes:

**Dimension Tables:**
- `DimCurrency` - Currency information (USD, EUR, GBP, CAD, JPY)
- `DimChannel` - Sales channels (Store, Online, Catalog, Reseller)
- `DimGeography` - Geographic locations (cities across North America, Europe, Asia)
- `DimProductCategory` - Product categories (Audio, TV & Video, Computers, etc.)
- `DimProductSubcategory` - Product subcategories
- `DimProduct` - Contoso products with pricing and details
- `DimStore` - Contoso retail stores worldwide
- `DimCustomer` - Customer information
- `DimDate` - Complete date dimension for 2023
- `DimPromotion` - Sales promotions and discounts

**Fact Tables:**
- `FactSales` - In-store sales transactions
- `FactOnlineSales` - Online sales transactions

**Views:**
- `vw_SalesByProduct` - Sales aggregated by product
- `vw_SalesByStore` - Sales aggregated by store
- `vw_SalesByMonth` - Sales aggregated by month

## Quick Start

1. **Start the database:**
   ```bash
   docker-compose up -d
   ```

2. **Wait for initialization:**
   The Contoso database will automatically be created and populated with sample data. This takes about 1-2 minutes.

3. **Connect to the Contoso database:**
   - **Server:** localhost,1433 (or WSL IP from script above)
   - **Database:** ContosoRetailDW
   - **Username:** sa
   - **Password:** TempSA_Password123!

4. **Verify the Contoso setup:**
   ```bash
   docker exec mssql-server /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P TempSA_Password123! -C -d ContosoRetailDW -Q "SELECT COUNT(*) as TableCount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'cso'"
   ```

## Sample Queries

### Sales by Product Brand
```sql
USE ContosoRetailDW;

SELECT  
    SUM(f.[SalesAmount]) AS [sales_by_brand_amount],
    p.[BrandName]
FROM [cso].[FactSales] AS f
JOIN [cso].[DimProduct] AS p ON f.[ProductKey] = p.[ProductKey]
GROUP BY p.[BrandName]
ORDER BY [sales_by_brand_amount] DESC;
```

### Sales by Product Category
```sql
SELECT 
    pc.ProductCategoryName,
    SUM(fs.SalesAmount) AS TotalSales,
    SUM(fs.SalesQuantity) AS TotalQuantity
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimProduct] p ON fs.ProductKey = p.ProductKey
    INNER JOIN [cso].[DimProductSubcategory] psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
    INNER JOIN [cso].[DimProductCategory] pc ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.ProductCategoryName
ORDER BY TotalSales DESC;
```

### Monthly Sales Trend
```sql
SELECT 
    d.CalendarMonthLabel,
    SUM(fs.SalesAmount) AS MonthlySales
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimDate] d ON fs.DateKey = d.Datekey
GROUP BY d.CalendarMonth, d.CalendarMonthLabel
ORDER BY d.CalendarMonth;
```

### Store Performance
```sql
SELECT 
    s.StoreName,
    g.CityName,
    g.RegionCountryName,
    SUM(fs.SalesAmount) AS TotalSales,
    COUNT(*) AS TransactionCount
FROM [cso].[FactSales] fs
    INNER JOIN [cso].[DimStore] s ON fs.StoreKey = s.StoreKey
    INNER JOIN [cso].[DimGeography] g ON s.GeographyKey = g.GeographyKey
GROUP BY s.StoreName, g.CityName, g.RegionCountryName
ORDER BY TotalSales DESC;
```

## Database Schema

The Contoso database follows a star schema design typical for data warehouses:

```
FactSales (Fact Table)
├── DimDate (Date dimension)
├── DimChannel (Sales channel)
├── DimStore (Store information)
├── DimProduct (Product details)
├── DimPromotion (Promotions/discounts)
└── DimCurrency (Currency information)

FactOnlineSales (Fact Table)
├── DimDate
├── DimStore
├── DimProduct
├── DimPromotion
├── DimCurrency
└── DimCustomer (Customer information)
```

## Connection Details

- **Host:** localhost (or WSL IP)
- **Port:** 1433
- **Database:** ContosoRetailDW
- **Schema:** cso
- **Username:** sa
- **Password:** TempSA_Password123!

## Data Volume

The sample database contains:
- 5 currencies, 4 sales channels, 9 geographic locations
- 8 product categories, 8 subcategories, 6 products
- 5 stores, 5 customers, 365 date records (full year 2023)
- 5 promotions, 18 sales transactions, 10 online sales transactions

This provides a good foundation for testing and development while being lightweight enough for quick setup and teardown.
