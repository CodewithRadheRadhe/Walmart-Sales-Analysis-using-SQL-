create database if not exists WalmartSales;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2)
);

select * from sales;

select max(time) from sales;
select min(time) from sales;
-- we can infer that sales timing is 10AM to 9 PM
-- ------------------------------------------------------------------------------------------------------------------------
-------------------------------------------  Feature Engineerig  ----------------------------------------------------
-- _____Time to time_in_day _____________________________________________________________________________________________________________
Select Time,( case when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'Time' between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening" end) as "timeofday" from sales;
alter table sales add column daytime varchar(25);
select * from sales;
update sales set daytime = ( case when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'Time' between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening" end);
select count(distinct city) from sales;

-- day of sales-----
-- ________________________________________________________________________________________________________
SELECT
	date,
	DAYNAME(date)
FROM sales;
alter table sales add column day_name varchar(25);
update sales set day_name = dayname(date);
select * from sales;

-- Add month_name column
-- ________________________________________________________________________________
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
select month(date) from sales;
UPDATE sales
SET month_name = MONTHNAME(date);
select * from sales;

-- sales in quarter 
ALTER TABLE sales ADD COLUMN quarter_name VARCHAR(10);
UPDATE sales
SET quarter_name = 
(case 
when MONTH(date)<=3 then "Q1"
when 3<MONTH(date)<=6 then "Q2"
when 6<MONTH(date)<=9 then "Q3"
else "Q4" end);
select * from sales;
-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;
SELECT 
	DISTINCT city,
    branch
FROM sales;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT product_line
FROM sales;

-- What is the most selling product line
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;


-- What month had the largest COGS?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;
select product_line, sum(total) as revenue
from sales group by product_line order by revenue desc;
-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;
select branch, city, sum(total) as revenue
from sales group by city, branch order by revenue desc;
-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

select product_line, avg(tax_pct) as avgtax from sales group by product_line order by avgtax desc;
-- What product line had the largest VAT?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;
-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;

select branch, sum(quantity) as qnty from sales group by branch 
having sum(quantity) > ( select avg(quantity) from sales);
-- Which branch sold more products than average product sold?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

select gender, product_line, count(gender) as total_count from sales group by product_line, gender
order by total_count desc;
-- What is the most common product line by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;
select product_line, round(avg(rating),2) as rating from sales group by product_line
order by rating desc;
-- What is the average rating of each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------
select customer_type,count(customer_type) from sales group by customer_type;
select customer_type, gender, count(customer_type) from sales group by customer_type, gender;
select gender, count(gender) from sales group by gender;
-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;
select payment, count(*) from sales group by payment;
-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;

select customer_type, count(*) from sales group by customer_type order by count(customer_type) desc;
-- What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;
select * from sales;
select gender,customer_type, count(*) from sales group by customer_type, gender;
-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;
select branch, gender, count(gender) from sales group by branch,gender;
-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;
-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.
select daytime, avg(rating) as rate from sales group by daytime order by rate;
select distinct(timeofday) from sales;

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

select day_name , avg(rating) as rate from sales group by day_name order by rate desc;
-- Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
select day_name , sum(quantity) from sales group by day_name ;
-- why is that the case, how many sales are made on these days?


select day_name, branch, avg(rating) as rate from sales group by day_name, branch order by rate desc;
-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------