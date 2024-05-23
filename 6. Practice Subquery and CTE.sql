USE Sample_db;

-- Q1- write a query to find premium customers from superstore data. 
	-- Premium customers are those who have 
		-- done more orders than average no of orders per customer
        
	  
		with cte as (select customer_id,count(distinct order_id) as totalorders
        from superstore
        group by customer_id)
        select *
        from cte
        where totalorders > (select avg(totalorders) from cte);        
        
-- Q2- write a query to find employees whose salary 
	-- is more than average salary of employees in their department
select e.*,d.avgsalary
from employees as e
left join(select department_id,avg(salary)as avgsalary
          from employees
group by department_id) as d
on e.department_id = d.department_id
where e.salary > d.avgsalary;


with cte as (select department_id,avg(salary)as avgsalary
          from employees
		group by department_id
        )
select e.*
from employees as e
left join cte as c
on e.department_id=c.department_id
where e.salary = c.avgsalary;
 
-- Q3- write a query to find employees whose age 
	-- is more than average age of all the employees.
select *
from employees
where emp_age > (select avg(emp_age) as avgage from employees);
with cte as (select avg(emp_age) as avgage from employees)

select *
from employees
where emp_age > (select avgage from cte);


-- Q4- write a query to print emp name, salary and dep id 
	-- of highest salaried employee in each department 
   select e.*,d.maxsalary
   from employees as e
   left join (select department_id, max(salary) as maxsalary
    from employees
    group by department_id) as d
    on e.department_id = d.department_id
    where e.salary = d.maxsalary;
    
    with cte as (select department_id,max(salary) as maxsalary
    from employees
    group by department_id )
    select e.*
    from employees as e
    left join cte as c 
    on e.department_id = c.department_id
    where e.salary =c.maxsalary;

-- Q5- write a query to print emp name, salary and dep id of 
	-- highest salaried employee overall
   select *
   from employees
   where salary =( select max(salary)
    from employees);
   
-- Q6- write a query to print product id and total sales 
	-- of highest selling products (by no of units sold) in each category
   select xyz.*,def.maxquantity
   from (select category,product_id,sum(quantity) as totalquantity,sum(sales) as totalsales
   from superstore
   group by category,product_id) as xyz
   left join (select category,max(totalquantity) as maxquantity  
   from (select category,product_id,sum(quantity) as totalquantity,sum(sales) as totalsales
   from superstore
   group by category,product_id) as abc
   group by category) as def
   on xyz.category = def.category
   where xyz.totalquantity = def.maxquantity;
    
   
with cte1 as (select category,product_id,sum(quantity) as totalquantity,sum(sales) as totalsales
from superstore 
group by category,product_id),
cte2 as (select category,max(totalquantity) as maxquantity 
         from cte1
         group by category)
select c1.*,maxquantity
from cte1 as c1
left join cte2 as c2
on c1.category=c2.category
where c1.totalquantity= c2.maxquantity;


    