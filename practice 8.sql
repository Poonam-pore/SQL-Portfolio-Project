Use sample_db;

create table Blue_table (
Driver_id int,
StartDate date,
EndDate date );

insert into Blue_table values 
(0,'2018-04-02',NULL),
(1,'2018-05-30',NULL),
(2,'2015-04-05','2017-04-06'),
(3,'2015-01-08',NULL),
(4,'2019-03-09','2020-06-10');

select *
from blue_table;

with cte as (
select year(StartDate) as year,count(EnsDate) as driversleft,
lag(count(EnsDate))over(order by year(startDate)) as lagdrivers
from blue_table
group by year(startDate))
select year,driversleft,
case when lagdrivers - driversleft > 0 then "decrease"
when lagdrivers - driversleft < 0 then "increase"
else "NA" 
end as status 
from cte;

select *
from superstore;

-- Get the middle name of the customer.
select customer_name,left(right(customer_name,length(customer_name)-instr(customer_name," ")),instr(right(customer_name,length(customer_name)-instr(customer_name," "))," ")-1) as newcol
from superstore;


