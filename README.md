```
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
 **Database**: `SQL_Project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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

```
```
### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- Data Exploration
-- How many sales we have?
SELECT COUNT(*) as total_sale FROM Retail_Sales
-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM Retail_Sales
SELECT DISTINCT category FROM Retail_Sales

SELECT * FROM Retail_Aales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM Retail_Sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

``` ### 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

 Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
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
```
```
  ## Findings
- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.


