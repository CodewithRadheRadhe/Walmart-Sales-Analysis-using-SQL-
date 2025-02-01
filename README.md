# Walmart-Sales-Analysis-using-SQL

Summary of Key Insights
Database & Table Creation

The script creates a database (WalmartSales) and a sales table containing attributes like invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, tax_pct, total, date, time, payment, cogs, gross_margin_pct, gross_income, and rating.
Basic Data Exploration

Queries retrieve all sales records (SELECT * FROM sales;).
The script identifies the earliest (MIN(time)) and latest (MAX(time)) sales transactions, confirming operating hours from 10 AM to 9 PM.
Feature Engineering

Time-based features are extracted:
Sales transactions are categorized into Morning, Afternoon, and Evening periods.
A day_type column is created to classify sales as Weekday or Weekend.
Customer behavior analysis:
Sales are grouped by Customer Type, Payment Method, and Gender.
Sales Performance Analysis

Branch-wise Sales Performance: Summarizes total sales per branch.
Most and Least Popular Product Lines: Identifies the best- and worst-selling product categories.
Revenue Trends Over Time: Analyzes how revenue varies by day, week, and month.
Customer Insights

Gender-based purchasing patterns.
Customer rating trends to analyze service satisfaction.

2. Visualization of sales analysis
![image](https://github.com/user-attachments/assets/5bba3b70-70da-4d84-9ff5-16c5b439257e)

The bar chart illustrates sales activity across store operating hours (10 AM to 9 PM). The highest sales volume is observed in the evening hours (5 PM - 7 PM), likely due to peak shopping times.



Here are the visualizations for further analysis:

Sales by Day Type (Weekday vs. Weekend)
![image](https://github.com/user-attachments/assets/ee1a4a2b-dc7c-4d4a-b4c5-cce3ad25923f)

Sales by Day Type (Weekday vs. Weekend) – More sales occur on weekdays than weekends.

Sales by Customer Type
![image](https://github.com/user-attachments/assets/655a4b8f-414d-47a5-85db-9f82fa543951)

Sales by Customer Type – Sales are evenly split between Members and Normal customers.

Sales by Product Line
![image](https://github.com/user-attachments/assets/ba01379a-0f1f-4232-af1b-a6887905b3d3)

Sales by Product Line – Groceries have the highest sales, followed by Clothing and Electronics.

Revenue Trends Over Time
![image](https://github.com/user-attachments/assets/7859f34e-80f2-440d-80c3-04cb6734998a)

Revenue Trends Over Time – Fluctuations in revenue suggest periodic spikes, possibly due to promotions or seasonal demand.

