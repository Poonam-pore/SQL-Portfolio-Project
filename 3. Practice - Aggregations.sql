USE Sample_DB;

SELECT *
FROM superstore;

-- Q1. What is the difference between COUNT(*), COUNT(expression), 
		-- and COUNT(DISTINCT expression)?
     -- COUNT(*) = It gives number of rows in whole table.
     -- COUNT(expression) =  It gives number of rows in a particular column which do not includes NULL values
     -- COUNT(DISTINCT expression) = It gives number of rows in a particular column which ignores the duplicates
        
-- Q2. Do basic Exploratory data analysis (EDA) of the dataset. For example-
		-- How many rows do we have?
        select count(*) as n_rows
        from superstore;
	
    -- How many orders were placed?
        select count(distinct order_id) as n_order
        from superstore;
        
        -- How many customers do we have?
        select count(distinct customer_id)as n_col
        from superstore;
        
		-- How much profit did we make in total?
        select round(sum(profit),3) as totalprofit
        from superstore;
        
        -- How many days orders were placed?
        select count( distinct order_date)as newcol
        from superstore;
        
        -- What was the highest and lowest sales per quantity ?
        select min(sales) as min_sales,
        max(sales) as max_sales
        from superstore;
        
-- Q3- Write a query to get total profit, first order date and latest order date for each category
select category,sum(profit) as total_profit,
min(order_date) as min_date,
max(order_date) as max_dte
from superstore
group by category;

-- Q4. How many orders were placed on each day?
select order_date,count(distinct order_id)
from superstore
group by order_date;

-- Q5. How many orders were placed for each type of Ship mode? 
select ship_mode,count(distinct order_id)
from superstore
group by ship_mode;
    
-- Q6. How many orders were placed on each day for Furniture Category?
select order_date, count(distinct order_id) as newcol
from superstore
where category ="Furniture"
group by order_date;

-- Q7. How many orders were placed per day  for the days when sales was greater than 1000?
		select order_date, count(distinct order_id) as n_col,sum(sales) as totalsale
        from superstore
        group by order_date 
        having sum(sales) > 1000;
        
-- Q8. What will below codes return? What is the issue here?
		SELECT category, sub_category, SUM(profit) AS profit
		FROM superstore
		GROUP BY category,sub_category;

		SELECT category, SUM(profit) AS profit
		FROM superstore
		GROUP BY category, sub_category;
	
-- Q9. How many Sub categories and products are there for each categories?
select category, count(distinct sub_category),count(distinct product_name)
from superstore
group by  category;

-- Q10. Find sales, profit and Quantites sold for each categories.
select category ,sum(sales),sum(profit),sum(quantity)
from superstore
group by category;

-- Q11. Write a query to find top 5 sub categories in west region by total quantity sold
select sub_category,sum(quantity)as n_col
from superstore
where region = 'west'
group by sub_category
order by n_col desc 
limit 5 ;

-- Q12. Write a query to find total sales for each region and ship mode combination for orders in year 2020
select region ,ship_mode,sum(sales) as total_sales
from superstore
where order_date >= "2020-01-01" and order_date <= "2020-12-31" 
group by region ,ship_mode;

-- Q13. Find quantities sold for combination of each category and subcategory
select category,sub_category,sum(quantity)
from superstore
group by category, sub_category;

-- Q14. Find quantities sold for combination of each category and subcategory 
		-- when quantity sold is greater than 2
        select category,sub_category,sum(quantity)
        from superstore
        where quantity > 2 
        group by category, sub_category;

-- Q15. Find quantities sold for combination of each category and subcategory 
		-- when quantity sold in the combination is greater than 100
        select category,sub_category,sum(quantity) as totalquant
        from superstore
        group by category,sub_category
        having sum(quantity) > 100;
	
        -- Q16. Write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
select sub_category,avg(profit),max(profit),max(profit)/10 as half_max_profit
from superstore
group by sub_category 
having avg(profit) > half_max_profit;

-- Q17. Create the exams table with below script
-- Write a query to find students who have got same marks in Physics and Chemistry.

CREATE TABLE exams 
(student_id int, 
subject varchar(20), 
marks int);

INSERT INTO exams VALUES 
(1,'Chemistry',91),
(1,'Physics',91),
(1,'Maths',92),
(2,'Chemistry',80),
(2,'Physics',90),
(3,'Chemistry',80),
(3,'Maths',80),
(4,'Chemistry',71),
(4,'Physics',54),
(5,'Chemistry',79);
select student_id
from exams
where subject in ("physics","chemistry")
group by student_id
having count(*) = 2 and count(distinct marks) = 1;


 