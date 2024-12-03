CREATE DATABASE SQL_Project;


-- Create TABLE
DROP TABLE IF EXISTS Retail_Sales;
CREATE TABLE Retail_Sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(50),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM Retail_Sales
LIMIT 10


    

SELECT 
    COUNT(*) 
FROM Retail_Sales

-- Data Cleaning
SELECT * FROM Retail_Sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM Retail_Sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM Retail_Sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM Retail_Sales



SELECT DISTINCT category FROM Retail_Sales


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from Retail_Sales 
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * 
from Retail_Sales 
where lower(category) = 'clothing' 
and quantity >= 4 
and extract(year from sale_date) = 2022 and extract(month from sale_date) = 11 -- to_char (sale_date , 'YYYY-MM') = '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category , sum(total_sale) as Total_Sales
from Retail_Sales 
group by category 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age) , 2) as Avg_age
from Retail_Sales 
where lower(category) = 'beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * 
from Retail_Sales 
where total_sale > 1000 

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender , category , count(transactions_id) as total_trans
from Retail_Sales
group by gender , category 
order by category 

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year , month , avg_sales 
from 
( 
select 
extract(year from sale_date) as year , 
extract(month from sale_date) as month , 
round( cast(avg(total_sale)as numeric) , 2) as avg_sales,
rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc ) as rank
from Retail_Sales 
group by 1 , 2 
) as t 
where rank =  1 

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id , sum(total_sale) as total_sales 
from Retail_Sales 
group by  customer_id 
order by sum(total_sale) desc 
limit 5 

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select
category , count(distinct customer_id) as  cnt_unique_cs
from Retail_Sales 
group by 1 

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as
(
select *,
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as shift
from retail_sales
)
select 
    shift,
    count(*) as total_orders    
from hourly_sale
group by shift
