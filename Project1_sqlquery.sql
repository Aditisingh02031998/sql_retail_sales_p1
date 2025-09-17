-- Create database
create database Retail_sales_p2;

-- create Table
Drop Table if exists retail_sales;
Create table retail_sales ( transactions_id	int Primary Key,
sale_date	date,
sale_time	time,
customer_id	int,
gender varchar (15),
age	int,
category varchar(15),	
quantiy	int,
price_per_unit float,
cogs	float,
total_sale float
)

Select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or total_sale is null;

-- Data cleaning
delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or total_sale is null;

--
Select * from retail_sales limit 10;
Select Count(*) from retail_sales;

-- data exploration

-- how many sales we have?
Select count(total_sale) as total_sales from retail_sales;

-- how many unique customer we have
select count(distinct customer_id) from retail_sales;

-- how many categories we have
select distinct category from retail_sales;

-- data analysis or business key problems or answer

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

Select * from retail_sales
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

Select * from retail_sales
where category = 'Clothing' 
and quantiy >= 4
and TO_CHAR (sale_date, 'yyyy-mm') = '2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as net_sale, count(*) as net_orders
 from retail_sales
 group by 1;

 -- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Select round(avg (age), 2) as avg_age from retail_sales
where category = 'Beauty';

 -- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
 Select * from retail_sales
 where total_sale >1000;

 -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 select gender,category, count(transactions_id) as total_transaction
 from retail_sales
 group by 1,2;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

with avg_retail_sales as (Select Extract(Year from sale_date) as Year,Extract(Month from sale_date) as month, avg(total_sale) as avg_sale,
Rank () over (partition by Extract(Year from sale_date) order by avg(total_sale) desc) as Ranks
From Retail_sales
Group by 1, 2)

Select Year,month, avg_sale, ranks
from avg_retail_sales
where ranks = 1
;

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:

Select customer_id, sum(total_sale)
from retail_sales
group by 1
order by 2 desc
limit 5
;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

Select category, count(distinct customer_id) as unique_customers
from retail_sales
group by 1;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with each_shifts as (Select *,
 case 
     When Extract(hour from sale_time) < 12 then 'Morning'
	 When Extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	 Else 'Evening'
 End as Shifts
from retail_sales)

Select shifts, count (*) 
 from each_shifts
 group by 1;

 -- End of Project





