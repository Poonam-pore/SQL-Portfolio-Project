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


-- Write a SQL query to get the percentage of students who scored 90 or above in any subject 
	-- amongst total students

-- Write a SQL query to get the second highest and second lowest marks for each subject

-- For each student and test, identify if their marks increased or decreased from the previous test.

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










