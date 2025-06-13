SELECT * FROM Superstore1.df_orders;

-- find the top 10 highest revenue generating products
SELECT 
	Product_id,
    sum(Quantity)
FROM Superstore1.df_orders
group by Product_id
order by sum(Quantity) desc
LIMIT 10;

-- find top 5 highest selling products in each region
SELECT *
FROM (
    SELECT 
        region,
        Product_id,
        SUM(Quantity) AS sales,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY SUM(Quantity) DESC) AS rn
    FROM Superstore1.df_orders
    GROUP BY region, Product_id
) AS ranked
WHERE rn <= 5;

-- find month over month growth comparison for 2022 and 2023 sales e.g jan 2022 vs jan 2023
with cte as (
select 
	year(order_date) as order_year,
    month(order_date) as order_month,
    sum(sale_price) as sales
FROM Superstore1.df_orders
group by year(order_date), month(order_date)
)
 SELECT 
	order_month,
    sum(case when order_year = 2022 then sales else 0 end) as sales_2022,
    sum(case when order_year = 2023 then sales else 0 end) as sales_2023
 from cte 
 group by order_month
 order by order_month; 
 
 
-- for each category which month had highest sales
with cte as (
select 
 Category,
 DATE_FORMAT(order_date, '%Y%m') AS yr_mnt,
 sum(Sale_price) as sales
from Superstore1.df_orders
group by Category, yr_mnt
order by Category, yr_mnt
)
select * from (
select *,
row_number() over(partition by Category order by sales Desc) as rn
from cte 
) a where rn = 1;


-- which sub category had highest growth by profit in 2023 compare to 2022
WITH cte AS (
    SELECT 
        Sub_Category,
        YEAR(order_date) AS order_year,
        SUM(sale_price) AS sales
    FROM Superstore1.df_orders
    GROUP BY Sub_Category, YEAR(order_date)
), 
cte2 AS (
    SELECT 
        Sub_Category,
        SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
        SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY Sub_Category
)
SELECT 
    Sub_Category,
	(sales_2023 - sales_2022) * 100.0 / sales_2022  AS percent_change
FROM cte2
ORDER BY percent_change DESC
LIMIT 1;