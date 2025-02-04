-- SQL Retail Sales Analysis - P1


-- Create TABLE
DROP TABLE IF EXISTS sales;
CREATE TABLE sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM sales;
LIMIT 10;


    

SELECT 
    COUNT(*) 
FROM sales;

-- Data Cleaning
select * from sales
where
 transaction_id isnull
or
 sale_date isnull
or
 customer_id isnull
or
 gender isnull
or
category isnull
or
quantity isnull
or 
 price_per_unit isnull
or 
 cogs isnull
or
 total_sale isnull;

-- 

delete from sales
where
 transaction_id isnull
or
 sale_date isnull
or
 customer_id isnull
or
 gender isnull
or
category isnull
or
quantity isnull
or 
 price_per_unit isnull
or 
 cogs isnull
or
 total_sale isnull;


    
-- Data Exploration

-- How many sales we have?		
select count(*) from sales;


-- How many uniuque customers we have ?
select count (distinct(transaction_id)) from sales;



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
 select * from sales
 where sale_date = '2022-11-05';



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from sales
where category ='Clothing' and quantity >4 and extract(month from sale_date)= 11 ;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale)from sales
group by category;




-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age)from sales
where category ='Beauty';




-- Q.5 Write a SQL query to find transactions where the total_ sale is greater than 1000.
select transaction_id,total_sale from sales
where total_sale >1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, sum (transaction_id) from sales
group by gender;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select extract(year from sale_date),
extract(month from sale_date),
avg(total_sale)as average_sale ,
rank() over ( order by avg(total_sale) desc)
from sales 
group by extract(year from sale_date ),extract(month from sale_date);


    


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 select customer_id, sum(total_sale) from sales 
 group by customer_id
 order by sum(total_sale) desc
 limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count (distinct(customer_id)) from sales
group by category;
  



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
select * , 
case
when extract (hour from sale_time ) < 12 then 'morning'
when extract (hour from sale_time) between 12 and 17 then 'aftyernoon'
else 'evening'
end as shift
from sales;



-- End of project

