USE Sample_DB;

-- Q1. Change the Category "Office Supplies" to "School Supplies".
select category,
replace (category,"Office Supplies","School Supplies") as newcol
from superstore;

-- Q2. Change the Category "Office Supplies" to "School Supplies" only when Ship Mode is "Second Class".
SELECT ship_mode,category,
case
   when ship_mode="Second Class" then replace (category,"Office Supplies","School Supplies") 
   else category
end as newcol
from superstore;
select *, replace(category,"office supplies","school supplies")
from superstore
where ship_mode = "second class";
 
-- Q3. Get the first three letters of Customer Name and make them capital.
select customer_name,
upper(left(customer_name,3))as newcol
from superstore;

-- Q4. Get the first name of Customer Name. (Hint: Find the occurence of the first space)
SELECT customer_name,
left( customer_name, instr(customer_name," ")-1) as newcol
from superstore;

-- Q5. Get the last name of Customer Name. Get the last word from the Product Name.
SELECT customer_name,
right( customer_name, length(customer_name) - instr(customer_name," ")) as  newcol
from superstore;
select product_name,
reverse(left(reverse(product_name), instr(reverse(product_name)," ")-1)) as newcol
from superstore;

-- Q6. Write a query to get records where the length of the Product Name is less than or equal to 10.
SELECT product_name, length(product_name)
from superstore
where length(product_name) <= 10 ;

-- Q7. Get details of records where lenght of first name of Customer Name is greater than 4.
SELECT customer_name,length(left(customer_name,instr(customer_name," ")-1)) as newcol
from superstore
where length(left(customer_name,instr(customer_name," ")-1)) > 4;

-- Q8. Get records from alternative rows.
select *
from superstore
where row_id % 2=0;

-- Q9. Create a column to get both Category and Sub Catergory. For example: "Furniture - Bookcases".
select Category,Sub_Category,
concat(Category,' - ',Sub_Category) as newcol
from superstore;

-- Q10. Remove last three characters for the Customer Name.
select customer_name,
left(customer_name,length(customer_name)-3)as newcln
from superstore;

-- Q11. Get the records which have smallest Product Name.
select distinct product_name
from superstore
where length(product_name)=(select min(length(product_name))
from superstore
);

-- Q12. Get the records where the Sub Category contains character "o" after 2nd character.
select distinct Sub_Category
from superstore
where Sub_Category like "__%o%";

-- Q13. Find the number of spaces in Product Name.
select product_name,
length(product_name) -length(replace(product_name," ",""))
FROM superstore;








