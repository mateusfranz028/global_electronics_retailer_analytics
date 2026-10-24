# Global Electronics Retailer Analytics

<img width="1364" height="775" alt="image" src="https://github.com/user-attachments/assets/42439412-5aef-41db-9a95-7b1c5063cb63" />


## Table of Contents
- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Tools & Analysis](#tools--analysis)
- [Key Insights](#key-insights)
- [Business Recommendations](#business-recommendations)
- [How to Explore](#how-to-explore)

## Project Overview

This project is a deep analysis of the "Global Electronics Retailer" dataset from Maven Analytics. It provides valious insights on the sales and profit data from 2016 to 2021 and business recommendations over this data.

## Dataset

The dataset is provided by Maven Analytics at [this link](https://mavenanalytics.io/data-playground/global-electronics-retailer) and brings sales data for a fictitious global electronics retailer, including .csv tables containing information about transactions, products, customers, stores and currency exchange rates.

## Tools & Analysis

**Tools used in this project:**

<img width="25" height="25" alt="postgresql" src="https://github.com/user-attachments/assets/50f6831e-ad37-4dff-a8ea-4873afa3d288" /> **PostgreSQL** - Database & ELT 

<img width="25" height="25" alt="powerbi" src="https://github.com/user-attachments/assets/ac1992ac-33b4-4d93-99ce-988b62b29f92" /> **Power BI** - BI & Modeling 


**The Process:**

1 - ETL data with PgAdmin for PostgreSQL server.

2 - Data cleaning and views creation.

3 - Star Schema modeling at 1:* cardinalytis. 

3 - Dashboard creation at Power BI.


## SQL view creation scripts used:



**vw_products**


```
CREATE VIEW vw_products AS

SELECT

product_key,

product_name,

brand,

color,

sub_category_key,

sub_category,

category_key,

category,

TRIM(REPLACE(REPLACE(unit_cost_usd, '$',''), ',',''))::NUMERIC(10,2) AS unit_cost_usd,

    TRIM(REPLACE(REPLACE(unit_price_usd, '$',''), ',',''))::NUMERIC(10,2) AS unit_price_usd

FROM

products;
```

---

**vw_sales**


```
CREATE OR REPLACE VIEW vw_sales AS

SELECT

    s.order_number,

    s.line_item,

    s.order_date,

    s.delivery_date,

    s.customer_key,

    s.store_key,

    s.product_key,

    s.quantity,

    s.currency_code,

    e.exchange,

    p.unit_price_usd,

    p.unit_cost_usd,

    ROUND((s.quantity * p.unit_price_usd) / e.exchange, 2) AS line_revenue_usd,

    ROUND((s.quantity * p.unit_cost_usd) / e.exchange, 2) AS line_cost_usd

FROM

    sales s

LEFT JOIN

    exchange_rates e

    ON s.order_date = e.date 

    AND s.currency_code = e.currency

LEFT JOIN

    vw_products p

    ON s.product_key = p.product_key; 

```


## Star Schema tables relations

<img width="949" height="788" alt="image" src="https://github.com/user-attachments/assets/7b885e37-9702-4f8c-a8fe-5a7fea968a77" />



* **Central Fact Table**
  * `vw_sales`
  
* **Dimension Tables:**
  * `d_date`
  * `vw_products`
  * `customers`
  * `stores`


## DAX formulas used for personalized measures creation:

**Total Profit:**
```
Total Profit = [Total Revenue] - [Total Cost]
``` 

**Total Revenue:**
```
Total Revenue = SUM('vw_sales'[line_revenue_usd])
```

**Total Orders:**
```
Total Orders = DISTINCTCOUNT('vw_sales'[order_number])
```

**Total Cost:**
```
Total Cost = SUM('vw_sales'[line_cost_usd])
```

**Gross Margin:**
```
Gross Margin % = DIVIDE([Total Profit], [Total Revenue], 0)
```

## Key Insights 

- Computers lead profit:
  - $11.6M profit.
  - Over a third of the company's total profit.

- Strong consolidated Gross Margin: 
  - 58.6% global average.

- Historic peak: 
  - Consistent growth and a revenue peak in Q4-2019.  

- 2020 Contraction:
  - Significant revenue crash at Q1-2020 that kept low until 2021.

- Games & Toys almost negligible:
  - $0.4M profit.
  - Less than 2% of total profit.


## Business Recommendations

- Focus promotional and inventory replenishment budget
on leading categories. 

- Evaluate the discontinuing of low-revenue SKUs 
on Games & Toys and Audio categories, or negotiate
lower storage costs.

- Implement customer base retention strategies
to revert the plateau after 2020 decline.

- Anticipate season logistics and promotions 
for Q4.


## How to Explore

### Repository Structure
```text
├── assets/
│   └── dashboard_preview.jpg    
├── dataset/
|   └── Data_Dictionary.csv
|   └── Customers.csv
|   └── Exchange_Rates.csv
|   └── Products.csv
|   └── Sales.csv
|   └── Stores.csv   
├── sql/
│   ├── vw_products.sql         
│   └── vw_sales.sql            
├── powerbi/
│   └── global_electronics.pbix 
├── .gitignore
├── LICENSE                     
└── README.md                   
