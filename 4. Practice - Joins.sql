USE Sample_db;

CREATE TABLE IF NOT EXISTS employees(
emp_id INT,
emp_name VARCHAR(20),
department_id INT,
salary INT,
manager_id INT,
emp_age INT
);

SELECT * FROM employees;

INSERT INTO employees VALUES 
(1, 'Ankit', 100, 10000, 4, 30),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);

CREATE TABLE department(
dep_id INT,
dep_name VARCHAR(20)
);

INSERT INTO department VALUES
(100, 'Analytics'),
(300, 'IT');
select *
from department;

-- Q1. Given EMPLOYEES and DEPARTMENT table. How many rows will be returned after using left, right, inner, full outer joins
   -- Left = 10 records
   -- Right = 7 records
   -- Inner = 6 records
   -- Full outer join= 11 records

-- Q2. Create new column for department name in the EMPLOYEES table
select e.*,d.dep_name
from employees as e
left join department as d
on e.department_id = d.dep_id;

-- Q3. In case if the department does not exist, the default department should be "NA".
select e.*,d.dep_name,
case when d.dep_name is null then "NA" else d.dep_name end  as newcol 
from employees as e
left join department as d
on e.department_id =d.dep_id;

-- Q4. Find employees which are in Analytics department.
select e.*,d.dep_name
from employees as e 
left join department  as d
on e.department_id = d.dep_id
where d.dep_name = "analytics";

-- Q5. Find the managers of the employees
select e.*,m.emp_name as manager_name
from employees as e
left join employees as m
on e.manager_id = m.emp_id;

-- Q6. Find all employees who have the salary more than their manager salary
select e.*,m.salary as manager_slary
from employees as e
 join employees as m
on e.manager_id = m.emp_id
where e.salary > m.salary;

-- Q7. Find number of employees in each department
select d.dep_name,count(*) as cnt
from employees as e
left join department as d
on e.department_id = d.dep_id
group by d.dep_name;  

-- Q8. Find the highest paid employee in each department
 with cte as (select department_id,max(salary) as maxsalary
              from employees
			 group by department_id) 
select e.*
from employees as e
left join cte as c
on e.department_id = c.department_id
where e.salary = c.maxsalary;

-- Q9. Which department recieves more salary
select  *
from  ( select d.dep_id,sum(salary) as totalsalary
from employees as e 
left join department as d
on e.department_id= d.dep_id
group by d.dep_id) as a
where totalsalary = (select max(totalsalary)
from( select d.dep_id,sum(salary) as totalsalary
from employees as e 
left join department as d
on e.department_id= d.dep_id
group by d.dep_id) as b);


-- Q10. What is cross join? What it can be used for?
-- cartesian product 

select *
from employees
cross join department;
-- Cross join: It is a type of join that returns Cartesian product of rows from the tables in the join


