# Contoso Local Database - Schema Diagram

## Database Overview

**Database:** ContosoRetailDW (Local Version)  
**Schema:** cso  
**Architecture:** Simplified Star Schema  
**Purpose:** Local development and testing environment  

## Entity Relationship Diagram

```mermaid
erDiagram
    %% Dimension Tables
    DimDate {
        datetime Datekey PK
        nvarchar FullDateLabel
        nvarchar DateDescription
        int CalendarYear
        nvarchar CalendarYearLabel
        int CalendarHalfYear
        nvarchar CalendarHalfYearLabel
        int CalendarQuarter
        nvarchar CalendarQuarterLabel
        int CalendarMonth
        nvarchar CalendarMonthLabel
        int CalendarWeek
        nvarchar CalendarWeekLabel
        int CalendarDayOfWeek
        nvarchar CalendarDayOfWeekLabel
        int FiscalYear
        nvarchar FiscalYearLabel
        int FiscalHalfYear
        nvarchar FiscalHalfYearLabel
        int FiscalQuarter
        nvarchar FiscalQuarterLabel
        int FiscalMonth
        nvarchar FiscalMonthLabel
        nvarchar IsWorkDay
        int IsHoliday
        nvarchar HolidayName
        nvarchar EuropeSeason
        nvarchar NorthAmericaSeason
        nvarchar AsiaSeason
    }

    DimCurrency {
        int CurrencyKey PK
        nvarchar CurrencyLabel
        nvarchar CurrencyName
        nvarchar CurrencyDescription
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimChannel {
        int ChannelKey PK
        nvarchar ChannelLabel
        nvarchar ChannelName
        nvarchar ChannelDescription
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimGeography {
        int GeographyKey PK
        nvarchar GeographyType
        nvarchar ContinentName
        nvarchar CityName
        nvarchar StateProvinceName
        nvarchar RegionCountryName
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimProductCategory {
        int ProductCategoryKey PK
        nvarchar ProductCategoryLabel
        nvarchar ProductCategoryName
        nvarchar ProductCategoryDescription
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimProductSubcategory {
        int ProductSubcategoryKey PK
        nvarchar ProductSubcategoryLabel
        nvarchar ProductSubcategoryName
        nvarchar ProductSubcategoryDescription
        int ProductCategoryKey FK
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimProduct {
        int ProductKey PK
        nvarchar ProductLabel
        nvarchar ProductName
        nvarchar ProductDescription
        int ProductSubcategoryKey FK
        nvarchar Manufacturer
        nvarchar BrandName
        nvarchar ClassID
        nvarchar ClassName
        nvarchar StyleID
        nvarchar StyleName
        nvarchar ColorID
        nvarchar ColorName
        nvarchar Size
        nvarchar SizeRange
        nvarchar SizeUnitMeasureID
        float Weight
        nvarchar WeightUnitMeasureID
        nvarchar UnitOfMeasureID
        nvarchar UnitOfMeasureName
        nvarchar StockTypeID
        nvarchar StockTypeName
        money UnitCost
        money UnitPrice
        datetime AvailableForSaleDate
        datetime StopSaleDate
        nvarchar Status
        nvarchar ImageURL
        nvarchar ProductURL
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimStore {
        int StoreKey PK
        int GeographyKey FK
        int StoreManager
        nvarchar StoreType
        nvarchar StoreName
        nvarchar StoreDescription
        nvarchar Status
        datetime OpenDate
        datetime CloseDate
        int EntityKey
        nvarchar ZipCode
        nvarchar ZipCodeExtension
        nvarchar StorePhone
        nvarchar StoreFax
        nvarchar AddressLine1
        nvarchar AddressLine2
        nvarchar CloseReason
        int EmployeeCount
        float SellingAreaSize
        datetime LastRemodelDate
        nvarchar GeoLocation
        nvarchar Geometry
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimCustomer {
        int CustomerKey PK
        int GeographyKey FK
        nvarchar CustomerLabel
        nvarchar Title
        nvarchar FirstName
        nvarchar MiddleName
        nvarchar LastName
        bit NameStyle
        datetime BirthDate
        nchar MaritalStatus
        nvarchar Suffix
        nvarchar Gender
        nvarchar EmailAddress
        money YearlyIncome
        tinyint TotalChildren
        tinyint NumberChildrenAtHome
        nvarchar Education
        nvarchar Occupation
        nchar HouseOwnerFlag
        tinyint NumberCarsOwned
        nvarchar AddressLine1
        nvarchar AddressLine2
        nvarchar Phone
        datetime DateFirstPurchase
        nvarchar CustomerType
        nvarchar CompanyName
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    DimPromotion {
        int PromotionKey PK
        nvarchar PromotionLabel
        nvarchar PromotionName
        nvarchar PromotionDescription
        float DiscountPercent
        nvarchar PromotionType
        nvarchar PromotionCategory
        datetime StartDate
        datetime EndDate
        int MinQuantity
        int MaxQuantity
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    %% Fact Tables
    FactSales {
        int SalesKey PK
        datetime DateKey FK
        int channelKey FK
        int StoreKey FK
        int ProductKey FK
        int PromotionKey FK
        int CurrencyKey FK
        money UnitCost
        money UnitPrice
        int SalesQuantity
        int ReturnQuantity
        money ReturnAmount
        int DiscountQuantity
        money DiscountAmount
        money TotalCost
        money SalesAmount
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    FactOnlineSales {
        int OnlineSalesKey PK
        datetime DateKey FK
        int StoreKey FK
        int ProductKey FK
        int PromotionKey FK
        int CurrencyKey FK
        int CustomerKey FK
        nvarchar SalesOrderNumber
        int SalesOrderLineNumber
        int SalesQuantity
        money SalesAmount
        int ReturnQuantity
        money ReturnAmount
        int DiscountQuantity
        money DiscountAmount
        money TotalCost
        money UnitCost
        money UnitPrice
        int ETLLoadID
        datetime LoadDate
        datetime UpdateDate
    }

    %% Views
    vw_SalesByProduct {
        nvarchar ProductName
        nvarchar BrandName
        nvarchar ProductCategoryName
        int TotalQuantitySold
        money TotalSalesAmount
        money AverageUnitPrice
    }

    vw_SalesByStore {
        nvarchar StoreName
        nvarchar CityName
        nvarchar RegionCountryName
        int TotalQuantitySold
        money TotalSalesAmount
        int DaysWithSales
    }

    vw_SalesByMonth {
        int CalendarYear
        int CalendarMonth
        nvarchar CalendarMonthLabel
        int TotalQuantitySold
        money TotalSalesAmount
        int UniqueProductsSold
    }

    %% Relationships - Dimension Hierarchies
    DimProductCategory ||--o{ DimProductSubcategory : "contains"
    DimProductSubcategory ||--o{ DimProduct : "categorizes"
    DimGeography ||--o{ DimStore : "located_in"
    DimGeography ||--o{ DimCustomer : "resides_in"

    %% Fact Table Relationships - FactSales
    DimDate ||--o{ FactSales : "sales_date"
    DimChannel ||--o{ FactSales : "sales_channel"
    DimStore ||--o{ FactSales : "sold_at"
    DimProduct ||--o{ FactSales : "product_sold"
    DimPromotion ||--o{ FactSales : "promotion_applied"
    DimCurrency ||--o{ FactSales : "currency_used"

    %% Fact Table Relationships - FactOnlineSales
    DimDate ||--o{ FactOnlineSales : "order_date"
    DimStore ||--o{ FactOnlineSales : "fulfillment_store"
    DimProduct ||--o{ FactOnlineSales : "product_ordered"
    DimPromotion ||--o{ FactOnlineSales : "promotion_used"
    DimCurrency ||--o{ FactOnlineSales : "transaction_currency"
    DimCustomer ||--o{ FactOnlineSales : "customer"

    %% View Relationships (conceptual)
    FactSales ||--o{ vw_SalesByProduct : "aggregates"
    FactSales ||--o{ vw_SalesByStore : "aggregates"
    FactSales ||--o{ vw_SalesByMonth : "aggregates"
    DimProduct ||--o{ vw_SalesByProduct : "product_info"
    DimStore ||--o{ vw_SalesByStore : "store_info"
    DimDate ||--o{ vw_SalesByMonth : "time_info"
```

## Schema Legend

- **Dimension Tables (Dim\*):** Master data tables with descriptive attributes
- **Fact Tables (Fact\*):** Transaction tables with measurable business metrics
- **Views (vw_\*):** Pre-built analytical views for common reporting needs
- **PK:** Primary Key (Identity columns)
- **FK:** Foreign Key (References other tables)
- **Relationships:** Lines show foreign key constraints and data flow

## Key Features

- **Simplified Structure:** Focused on core retail operations
- **Sample Data:** Pre-populated with test data for 2023
- **Performance Optimized:** Includes indexes on fact table foreign keys
- **Analytical Views:** Ready-to-use views for common business questions

## Business Areas Covered

- **Product Management:** Categories, subcategories, and product details
- **Store Operations:** Store locations and geographic information
- **Customer Management:** Customer demographics and purchase history
- **Sales Tracking:** In-store and online sales transactions
- **Promotions:** Discount and promotional campaign tracking
- **Time Intelligence:** Complete date dimension for temporal analysis

## Sample Data Included

- **Currencies:** USD, EUR, GBP, CAD, JPY
- **Channels:** Store, Online, Catalog, Reseller
- **Geographies:** 9 cities across North America, Europe, and Asia
- **Product Categories:** 8 categories (Audio, TV, Computers, etc.)
- **Products:** 6 sample Contoso brand products
- **Stores:** 5 flagship stores in major cities
- **Customers:** 5 sample customer profiles
- **Promotions:** 5 promotional campaigns
- **Sales Data:** 18 sales transactions and 10 online orders
- **Date Range:** Complete 2023 calendar year

## Table Details

### Dimension Tables

| Table | Purpose | Key Relationships |
|-------|---------|-------------------|
| DimDate | Time dimension with calendar and fiscal periods | Referenced by all fact tables |
| DimGeography | Geographic locations (cities, states, countries) | Referenced by DimStore, DimCustomer |
| DimProductCategory | Product categories (Audio, TV, Computers, etc.) | Parent of DimProductSubcategory |
| DimProductSubcategory | Product subcategories | Child of DimProductCategory, parent of DimProduct |
| DimProduct | Individual products with detailed attributes | Referenced by fact tables |
| DimStore | Store locations and details | Referenced by fact tables |
| DimCustomer | Customer demographics and information | Referenced by FactOnlineSales |
| DimChannel | Sales channels (Store, Online, Catalog, Reseller) | Referenced by FactSales |
| DimCurrency | Currency definitions | Referenced by all fact tables |
| DimPromotion | Promotional campaigns and discounts | Referenced by fact tables |

### Fact Tables

| Table | Purpose | Grain |
|-------|---------|-------|
| FactSales | In-store sales transactions | One row per product sold per transaction |
| FactOnlineSales | Online sales orders | One row per product per online order line |

### Analytical Views

| View | Purpose |
|------|---------|
| vw_SalesByProduct | Sales aggregated by product and category |
| vw_SalesByStore | Sales aggregated by store and location |
| vw_SalesByMonth | Sales aggregated by month and year |
