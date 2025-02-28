USE Sample;
-- Display all the records from works_on table
SELECT *
FROM Works_On;

-- Display all the records from project table
SELECT *
FROM Project;

-- Display the department names that are located in Seattle
SELECT dept_no	
	  ,dept_name
	  ,location
FROM Department	
WHERE Location='Seattle';

-- Display the employees who are not working in department d3
SELECT Emp_no
	,Emp_fname
	,Emp_lname
	,Dept_no
FROM Employee
WHERE Dept_no != 'd3' OR Dept_no IS NULL ;

-- Get employee number and project number for employees with valid designation 
-- and who have joined before 1st Aug 2007 
SELECT emp_no
	,project_no
	,job
	,enter_date
FROM Works_On
WHERE job IS NOT NULL AND enter_date < '08-01-2007';


-- Display the employee details whose salary is more than 500 USD or less than 300 USD 
-- and who are not assigned to departments d1 or d2
SELECT Emp_no
	,Emp_fname
	,Emp_lname
	,Dept_no
	,Salary
FROM Employee
WHERE  Salary NOT  BETWEEN 300 AND 500
	 AND  Dept_no NOT IN ('d1','d2') OR Dept_no IS NULL;

-- Display employee details who has 'r' as third letter in his/her last name
SELECT Emp_fname
		,Emp_lname
	
FROM Employee
WHERE Emp_lname LIKE '__r%'

                                     

-- Calculate the average of all budgets with an amount greater than $100,000
SELECT AVG(budget)
FROM  project
WHERE budget > 100000 

-- Find the number of different types of jobs
SELECT
	 COUNT (DISTINCT Job ) [Job Types]
FROM Works_On


-- Find number of employees in each job
SELECT 
	 COUNT (emp_no) [No. Of Emp]
	 ,job
FROM Works_On
GROUP BY job
--or
SELECT 
	 COUNT (emp_no) [No. Of Emp]
	 ,job
FROM Works_On
WHERE job IS NOT NULL
GROUP BY job

-- Find the number of employees in each job for jobs that do not start with letter 'M'
SELECT 
	 COUNT (emp_no) [No. Of Emp]
	 ,job
FROM Works_On
WHERE job NOT LIKE 'M%' 
GROUP BY  job

--what will be the salary if we add 100$ and then increment by 10%
USE SAMPLE;
SELECT emp_fname               
		,emp_lname
		,Salary		[Act Salary]
		,(Salary +100)+ ((Salary + 100) * 0.1) 	[Incre Salary]
		
FROM employee
--OR
SELECT Emp_fname
	  ,Emp_lname
	  ,Salary	[Actual salary]
	  ,(Salary + 100) *1.1		[Incremented Salary]
FROM Employee



---------------------------------************************************---------------------------



--19/07/2023
-- What is the previous quarter
SELECT
		GETDATE()					[current year]
		,DATEPART(QQ, GETDATE())-1 [prev Quarter]
		
-- What will be the experience of each employee after 5 years from now?
SELECT  emp_no
		,enter_date
		,DATEDIFF(YEAR,enter_date,GETDATE())    [Current experience]
		,DATEDIFF(YEAR,enter_date,GETDATE())+5	[Experience after 5 years]
FROM Works_On
		--,GETDATE()								[Current date]
		--,DATEADD(YY, 5,GETDATE() )				[5 years exp From now]
FROM Works_On


-- Display the domain name (gmail, hotmail etc) from email id

SELECT SUBSTRING(Email_ID, CHARINDEX('@',Email_ID)+1 , CHARINDEX('.',Email_ID)-1 - CHARINDEX('@',Email_ID)) AS [Domain name]
FROM Employee
		 

-- Display the employee details, with Jana as the first name for employees whose first name is 'Dave'
SELECT Emp_fname
		,REPLACE(Emp_fname,'Dave','Jana')
FROM employee				

-- Display project number, employee number and the number of days the employees are working in their projects
SELECT emp_no
		,project_no
		,enter_date
		 ,DATEDIFF(DAY,enter_date,GETDATE()) [No Of Days]
FROM works_on	


-- Display the employees who earn least 6 salaries
SELECT  TOP(6) WITH TIES
		emp_no
		,emp_fname               
		,emp_lname
		,Salary
		 
FROM employee
 ORDER BY Salary ;

-- Display the top 2nd salaried employee
SELECT Emp_fname, salary
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE salary < (
        SELECT MAX(salary)
        FROM Employee
    ))

	SELECT MAX(salary) AS second_highest_salary 
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee)

--Employee first names with duplicate enrties

SELECT Emp_fname, COUNT(Emp_fname)
FROM Employee
GRoup by Emp_fname
HAVING COUNT(Emp_fname) > 1;


 SELECT  ee.Emp_fname
		,ee.emp_lname
		,ee.domicile
		,d.Location

 FROM department d RIGHT OUTER JOIN Employee_enh ee
     ON  d.Dept_no = ee.dept_no
	
--display all employee information with their domicile and department location whether location matches with domicile or not.
SELECT ee.Emp_fname
		,ee.emp_lname
		,ee.domicile
		,d.Location
		,d.Dept_name
FROM Employee_enh ee LEFT OUTER JOIN Department d
  ON ee.domicile = d.Location

--Display the info about all the employees as well as all departments
  SELECT e.Emp_fname
		,e.emp_lname
		,d.dept_no
		,d.dept_name
		,d.Location
FROM Employee e FULL OUTER JOIN Department d
  ON e.Dept_no = d.Dept_no




 -----------------------------**********************************-------------------------------





 --Hands on work 20-07-2023
 --Get the department names of all employees who joined their projects on or after oct ,15, 2007;
 SELECT d.Dept_name
		,e.emp_no
		,w.enter_date
		
 FROM Department d INNER JOIN Employee e 
 ON d.Dept_no = e. Dept_no
 INNER JOIN Works_On w 
 ON w.emp_no = e.Emp_no
 WHERE w.enter_date >= '10-15-2007'

 -- Display the employees with their department names and project names


 SELECT e.Emp_fname
		,e.Emp_lname
		,d.Dept_name
		,p.project_name
 FROM	Employee e INNER JOIN Department d
		ON e.Dept_no = d. Dept_no
		INNER JOIN Works_On w  
		ON e.Emp_no = w.emp_no
		INNER JOIN Project p 
		ON p.project_no = w.project_no

 -- Find employees who work in Seattle as analysts
 SELECT e.Emp_fname
		,e.Emp_lname
		,w.job
		,d.location
 FROM	 Employee e INNER JOIN Department d 
		ON e.Dept_no = d.Dept_no
		INNER JOIN Works_On w 
		ON e.Emp_no = w.emp_no
WHERE d.Location = 'Seattle' AND w.Job ='Analyst'

-- Get the department names of employees who are working in 'Mercury' project
SELECT   e.Emp_fname
		,e.Emp_lname
		,e.Emp_no
		,d.Dept_name
		,p.project_name
FROM	Department d INNER JOIN Employee e
		ON d.Dept_no = e.Dept_no
		INNER JOIN Works_On w  ON  e.Emp_no = w.emp_no
		INNER JOIN Project p ON w.project_no = p.project_no
WHERE	p.project_name ='Mercury'


-- Get the Names of projects (with redundant duplicates eliminated) being worked on by employees in the Accounting department
SELECT --e.Emp_fname
--		,e.Emp_lname
--		,e.Emp_no
--		,d.Dept_name
		DISTINCT p.project_name
FROM Employee e INNER JOIN Department d
	ON d.Dept_no = e.Dept_no
	INNER JOIN Works_On w  ON  e.Emp_no = w.emp_no
	INNER JOIN Project p ON w.project_no = p.project_no
WHERE d.Dept_name = 'Accounting'








-----------------------------**************************---------------------------------

--24/07/2023

-- Display the names and departments of employees with highest experience in each project
SELECT RTRIM(e.Emp_fname)+ SPACE(1)+RTRIM(e.Emp_lname) [Emp name]
		,e.Dept_no
		,w.enter_date
		,p1.project_no
		,p1.project_name
FROM Employee e INNER JOIN  Works_On w
ON e.Emp_no=w.emp_no INNER JOIN Project p1
ON p1.project_no = w.project_no
WHERE w.enter_date = (SELECT MIN(w2.enter_date)
						FROM Works_On w2 INNER JOIN Project p2
							ON p2.project_no = w2.project_no
						WHERE p1.project_no = p2.project_no
						)


-- Display the names and departments of employees with highest experience in each project
SELECT  RTRIM(e.Emp_fname)+ SPACE(1)+RTRIM(e.Emp_lname) [Emp name]
		,e.Dept_no
		,w.project_no
		,w.enter_date
		,d.Dept_name
FROM Employee e inner join Works_On w
  on  e.Emp_no = w.emp_no INNER JOIN Department d
  ON  e.Dept_no = d.Dept_no
WHERE w.enter_date = (SELECT MIN(w1.enter_date)
						FROM Works_On w1
						WHERE w1.project_no=w.project_no)