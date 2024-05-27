USE Sample_DB;

CREATE TABLE UserActivity
(
username VARCHAR(20) ,
activity VARCHAR(20),
startDate DATE,
endDate DATE
);

INSERT INTO UserActivity VALUES 
('Alice','Travel','2020-02-12','2020-02-20'),
('Alice','Dancing','2020-02-21','2020-02-23'),
('Alice','Travel','2020-02-24','2020-02-28'),
('Bob','Travel','2020-02-11','2020-02-18');

-- Get the second most recent activity. If there is only one activity then return that one also.
with cte as (select *,
dense_rank() over (partition by username order by startdate desc ) as rn,
count(*) over( partition by username) as cnt
from useractivity)
select *
from cte
where rn =2 or cnt = 1;

-------------------------------------------------------------


CREATE TABLE exams (
	student_id INT, 
	subject VARCHAR(20), 
	marks INT
	);

INSERT INTO exams VALUES 
(1,'Chemistry',91),
(1,'Physics',91),
(1,'Maths',81),
(2,'Chemistry',80),
(2,'Physics',90),
(3,'Chemistry',80),
(4,'Chemistry',71),
(4,'Physics',54),
(4,'Maths',64);

-- Find students with same marks in Physics and Chemistry
with cte as (select *,
lag(marks) over (partition by student_id) as lagmarks
from exams
where subject in ('physics','chemistry'))
select *
from cte
where marks = lagmarks;


select student_id
from exams
where subject in ('physics','chemistry')
group by student_id
having count(*) = 2 and count(distinct marks) = 1;


--------------------------------------------------------------------------------

CREATE TABLE covid(
city VARCHAR(50),
days DATE,
cases INT);

INSERT INTO covid VALUES
('DELHI','2022-01-01',100),
('DELHI','2022-01-02',200),
('DELHI','2022-01-03',300),
('MUMBAI','2022-01-01',100),
('MUMBAI','2022-01-02',100),
('MUMBAI','2022-01-03',300),
('CHENNAI','2022-01-01',100),
('CHENNAI','2022-01-02',200),
('CHENNAI','2022-01-03',150),
('BANGALORE','2022-01-01',100),
('BANGALORE','2022-01-02',300),
('BANGALORE','2022-01-03',200),
('BANGALORE','2022-01-04',400);

-- Find cities with increasing number of covid cases every day.

SELECT * FROM covid;
with  cte as (select *,
cast(dense_rank() over (partition by city order by days) as signed)-
cast(dense_rank() over (partition by city order by cases) as signed) as diff
from covid)
select city,count(distinct diff)
from cte 
group by city
having count(distinct diff)=1;
-------------------------------------------------------------------------

CREATE TABLE students(
 studentid INT NULL,
 studentname NVARCHAR(255) NULL,
 subject NVARCHAR(255) NULL,
 marks INT NULL,
 testid INT NULL,
 testdate DATE NULL
);

INSERT INTO students VALUES 
(2,'Max Ruin','Subject1',63,1,'2022-01-02'),
(3,'Arnold','Subject1',95,1,'2022-01-02'),
(4,'Krish Star','Subject1',61,1,'2022-01-02'),
(5,'John Mike','Subject1',91,1,'2022-01-02'),
(4,'Krish Star','Subject2',71,1,'2022-01-02'),
(3,'Arnold','Subject2',32,1,'2022-01-02'),
(5,'John Mike','Subject2',61,2,'2022-11-02'),
(1,'John Deo','Subject2',60,1,'2022-01-02'),
(2,'Max Ruin','Subject2',84,1,'2022-01-02'),
(2,'Max Ruin','Subject3',29,3,'2022-01-03'),
(5,'John Mike','Subject3',98,2,'2022-11-02');

SELECT * FROM students;
-- Write a SQL query to get the list of students who scored above average marks in each subject
WITH cte as (
	SELECT *,
	AVG(marks) OVER (PARTITION BY subject) as AvgMarks
	FROM students
)
SELECT *
FROM cte
WHERE marks > AvgMarks;

with cte as (select subject,avg(marks) as avgmarks
from students
group by subject)
select s.*,c.avgmarks
from students as s
left join cte as c
on s.subject=c.subject
where s.marks > avgmarks;

-- Write a SQL query to get the percentage of students who scored 90 or above in any subject 
	-- amongst total students
SELECT 100.0*(SELECT COUNT(DISTINCT studentid) as cnt
FROM students
WHERE marks > 90)/(SELECT COUNT(DISTINCT studentid) as cnt
FROM students) as percent;

-- Write a SQL query to get the second highest and second lowest marks for each subject
 with cte as (select *,
dense_rank () over (partition by subject order by marks desc) as rn,
dense_rank() over (partition by subject order by marks asc) as rn2
from students)
select *
from cte 
where rn=2 or rn2 = 2;

-- For each student and test, identify if their marks increased or decreased from the previous test.
 with cte as (select *,
lag(marks) over (partition by studentname order by studentid) as lagmarks
from students)
select *,
case when marks < lagmarks then 'decrease' when lagmarks is null then null  else 'increase' end
from cte ;

----------------------------------------------------------------

CREATE TABLE icc_world_cup
(
Team_1 VARCHAR(20),
Team_2 VARCHAR(20),
Winner VARCHAR(20)
);

INSERT INTO icc_world_cup values
('India','SL','India'),
('SL','Aus','Aus'),
('SA','Eng','Eng'),
('Eng','NZ','NZ'),
('Aus','India','India');

SELECT * FROM icc_world_cup;

-- Create three columns - Matches_played, No_of_wins, No_of_losses
WITH cte as(
	SELECT Team_1,
	CASE WHEN team_1 = Winner THEN 1 ELSE 0 END as Win
	FROM icc_world_cup
	UNION ALL
	SELECT Team_2,
	CASE WHEN team_2 = Winner THEN 1 ELSE 0 END as Win
	FROM icc_world_cup
)
SELECT Team_1, COUNT(*) as Matches_played,
SUM(Win) as Wins,
COUNT(*) - SUM(Win) as Losses
FROM cte
GROUP BY Team_1;


-----------------------------------------------------------------

CREATE TABLE events (
ID INT,
event VARCHAR(255),
YEAR INt,
GOLD VARCHAR(255),
SILVER VARCHAR(255),
BRONZE VARCHAR(255)
);

INSERT INTO events VALUES 
(1,'100m',2016, 'Amthhew Mcgarray','donald','barbara'),
(2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith'),
(3,'500m',2016, 'Charles','Nichole','Susana'),
(4,'100m',2016, 'Ronald','maria','paula'),
(5,'200m',2016, 'Alfred','carol','Steven'),
(6,'500m',2016, 'Nichole','Alfred','Brandon'),
(7,'100m',2016, 'Charles','Dennis','Susana'),
(8,'200m',2016, 'Thomas','Dawn','catherine'),
(9,'500m',2016, 'Thomas','Dennis','paula'),
(10,'100m',2016, 'Charles','Dennis','Susana'),
(11,'200m',2016, 'jessica','Donald','Stefeney'),
(12,'500m',2016,'Thomas','Steven','Catherine');

-- PUSH YOUR LIMITS --
-- Write a query to find number of gold medal per swimmers for swimmers who only won gold medals.
SELECT GOLD, COUNT(*) as cnt
FROM events
WHERE GOLD IN (SELECT SILVER
					FROM events
					UNION ALL
					SELECT BRONZE
					FROM events)
GROUP BY GOLD;

WITH cte as(
	SELECT GOLD, "GOLD" as MedalType
	FROM events
	UNION ALL
	SELECT SILVER, "SILVER" as MedalType
	FROM events
	UNION ALL
	SELECT BRONZE, "BRONZE" as MedalType
	FROM events
)
SELECT GOLD, MedalType, COUNT(*) as Cnt
FROM cte 
GROUP BY GOLD, MedalType
ORDER BY GOLD;

-- Subquery

-- Having by, with cte

----------------------------------------------------------------


CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name VARCHAR(20)  NOT NULL,
    salary VARCHAR(30),
    dept_id INTEGER
);

INSERT INTO emp_salary VALUES
(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

-- Write a SQL query to return all employees whose salary is same in same department
	-- Using CTE
WITH cte as(    
	SELECT *,
	COUNT(*) OVER (PARTITION BY salary, dept_id) as cnt
	FROM emp_salary
)
SELECT *
FROM cte
WHERE cnt> 1;
	-- Using joins(inner join and left join)

----------------------------------------------------------------------

CREATE TABLE emp_2020
(
emp_id INT,
designation VARCHAR(20)
);

CREATE TABLE emp_2021
(
emp_id INT,
designation VARCHAR(20)
);

INSERT INTO emp_2020 VALUES 
(1,'Trainee'), 
(2,'Developer'),
(3,'Senior Developer'),
(4,'Manager');

INSERT INTO emp_2021 VALUES 
(1,'Developer'), 
(2,'Developer'),
(3,'Manager'),
(5,'Trainee');

-- Find the change in employee status.
	-- Types of status can only be - Promoted, No change, Resigned, New
WITH cte as (
	SELECT e20.emp_id, e20.designation, e21.emp_id as emp_id21,
    e21.designation as designation21
	FROM emp_2020 as e20
	LEFT JOIN emp_2021 as e21
	ON e20.emp_id = e21.emp_id
	UNION ALL
	SELECT e20.emp_id, e20.designation, e21.emp_id as emp_id21,
    e21.designation as designation21
	FROM emp_2020 as e20
	RIGHT JOIN emp_2021 as e21
	ON e20.emp_id = e21.emp_id
    WHERE e20.emp_id IS NULL
)
SELECT 
CASE WHEN emp_id IS NULL THEN emp_id21 ELSE emp_id END as emp_id,
CASE 
	WHEN designation = designation21 THEN "No Change"
    WHEN emp_id IS NULL THEN "New"
    WHEN emp_id21 IS NULL THEN "Resigned"
    ELSE "Promoted"
END as Status
FROM cte;



SELECT *
FROM emp_2021;
------------------------------------------------------------------


CREATE TABLE hospital ( 
emp_id INT,
action VARCHAR(10),
time DATETIME);

INSERT INTO hospital VALUES 
('1', 'in', '2019-12-22 09:00:00'),
('1', 'out', '2019-12-22 09:15:00'),
('2', 'in', '2019-12-22 09:00:00'),
('2', 'out', '2019-12-22 09:15:00'),
('2', 'in', '2019-12-22 09:30:00'),
('3', 'out', '2019-12-22 09:00:00'),
('3', 'in', '2019-12-22 09:15:00'),
('3', 'out', '2019-12-22 09:30:00'),
('3', 'in', '2019-12-22 09:45:00'),
('4', 'in', '2019-12-22 09:45:00'),
('5', 'out', '2019-12-22 09:40:00');

SELECT * FROM hospital;

-- Write a SQL Query to find the total number of people present 
	-- inside the hospital
-- 1-out, 2-in, 3-in, 4-in, 5-out
WITH cte as (
	SELECT *,
	DENSE_RANK() OVER (PARTITION BY emp_id ORDER BY time DESC) as rnk
	FROM hospital
)
SELECT COUNT(*) as cnt
FROM cte
WHERE rnk = 1 AND action = "in";



