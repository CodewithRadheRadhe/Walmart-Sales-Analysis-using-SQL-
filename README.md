# Walmart-Sales-Analysis-using-SQL-
Analysis of the SQL Script (Walmart Sales Analysis)
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
