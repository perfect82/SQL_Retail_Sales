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


2. Data Exploration & Cleaning
    Record Count: Determine the total number of records in the dataset.
    Customer Count: Find out how many unique customers are in the dataset.
    Category Count: Identify all unique product categories in the dataset.
    Null Value Check: Check for any null values in the dataset and delete records with missing data.

-- Data Exploration
-- How many sales we have?
SELECT COUNT(*) as total_sale FROM Retail_Sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_customers FROM Retail_Sales;

-- List all unique categories
SELECT DISTINCT category FROM Retail_Sales;

-- Check for null values
SELECT * FROM Retail_Sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Delete records with null values
DELETE FROM Retail_Sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

-- Q1: Retrieve all columns for sales made on '2022-11-05'
SELECT * FROM Retail_Sales 
WHERE sale_date = '2022-11-05';

-- Q2: Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in Nov 2022
SELECT * 
FROM Retail_Sales 
WHERE LOWER(category) = 'clothing' 
AND quantity > 10 
AND EXTRACT(YEAR FROM sale_date) = 2022 
AND EXTRACT(MONTH FROM sale_date) = 11;

-- Q3: Calculate the total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS Total_Sales
FROM Retail_Sales 
GROUP BY category;

-- Q4: Find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age), 2) AS Avg_Age
FROM Retail_Sales 
WHERE LOWER(category) = 'beauty';

-- Q5: Find all transactions where the total_sale is greater than 1000
SELECT * 
FROM Retail_Sales 
WHERE total_sale > 1000;

-- Q6: Find the total number of transactions made by each gender in each category
SELECT gender, category, COUNT(transaction_id) AS total_trans
FROM Retail_Sales
GROUP BY gender, category 
ORDER BY category;

-- Q7: Calculate the average sale for each month and find the best-selling month in each year
SELECT year, month, avg_sales 
FROM 
( 
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year, 
        EXTRACT(MONTH FROM sale_date) AS month, 
        ROUND(AVG(total_sale), 2) AS avg_sales,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM Retail_Sales 
    GROUP BY 1, 2 
) AS t 
WHERE rank = 1;

-- Q8: Find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales 
FROM Retail_Sales 
GROUP BY customer_id 
ORDER BY SUM(total_sale) DESC 
LIMIT 5;

-- Q9: Find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_customers
FROM Retail_Sales 
GROUP BY category;

-- Q10: Create shifts and number of orders (Morning <12, Afternoon 12-17, Evening >17)
WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_Sales
)
SELECT shift, COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

Findings : 
    Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
    High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
    Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
    Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

Reports : 
    Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
    Trend Analysis: Insights into sales trends across different months and shifts.
    Customer Insights: Reports on top customers and unique customer counts per category.

Conclusion :
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

How to Use : 
    Clone the Repository: Clone this project repository from GitHub.
    Set Up the Database: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.
    Run the Queries: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.
    Explore and Modify: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions
