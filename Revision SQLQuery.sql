USE Sample

-- Display the department names that are located in Seattle
SELECT Dept_name, Location
FROM Department 
WHERE Location = 'Seattle'

-- Display the employees who are not working in department d3
SELECT Emp_fname, Emp_lname,Dept_no
FROM Employee
WHERE Dept_no <> 'd3' OR Dept_no IS NULL

-- Get employee number and project number for employees with valid designation 
-- and who have joined before 1st Aug 2007
SELECT e.Emp_no, w.project_no,w.enter_date
FROM Employee e INNER JOIN Works_On w
ON e.Emp_no = w.emp_no
WHERE w.job IS NOT NULL  AND W.enter_date <= '08-01-2007'

SELECT e.Emp_no 
FROM Employee e 
WHERE Emp_no IN (SELECT w.emp_no FROM Works_On w WHERE w.job IS NOT NULL AND w.enter_date<= '08-01-2007')


 

-- Display the employee details whose salary is more than 500 USD or less than 300 USD
-- and who are not assigned to departments d1 or d2
SELECT *
FROM Employee
WHERE Salary NOT BETWEEN 300 AND 500 AND Dept_no NOT IN ('d1','d2') OR Dept_no IS NULL

-- Display employee details who has 'r' as third letter in his/her last name
SELECT Emp_fname,Emp_lname  FROM Employee WHERE Emp_lname LIKE '__r%'

-- Display the minimum and maximum employee numbers who are working in department d1
SELECT MIN(Emp_no),MAX(Emp_no),Dept_no FROM Employee WHERE Dept_no ='d1' GROUP BY Dept_no

-- Calculate the average of all budgets with an amount greater than $100,000
SELECT AVG(budget) FROM Project WHERE budget > '100000'

-- Find the number of different types of jobs

SELECT COUNT(DISTINCT job), job FROM Works_On WHERE job is not null GROUP BY job 

-- Find number of employees in each job
		SELECT COUNT(e.Emp_no),
				w.job	[Job]
		FROM Employee e INNER JOIN Works_On w
		ON e.Emp_no = w.emp_no
		GROUP BY w.job
		ORDER BY [job]

-- Find the number of employees in each job for jobs that do not start with letter 'M'
SELECT COUNT(e.Emp_no),w.job  
FROM Employee e INNER JOIN Works_On w 
	ON e.Emp_no=w.emp_no 
WHERE w.job  NOT LIKE 'M%' 
GROUP BY w.job

-- Display the employee details, with Jana as the first name for employees whose first name is 'Dave'
SELECT REPLACE(Emp_fname,'Dave','Jana') FROM Employee 
-- Display project number, employee number and the number of days the employees are working in their projects
SELECT emp_no
		,project_no
		,enter_date
		 ,DATEDIFF(DAY,enter_date,GETDATE()) [No Of Days]
FROM works_on	
-- Display the employees who earn least 6 salaries
SELECT * FROM Employee
SELECT TOP(6)WITH TIES Emp_no,Salary   
FROM Employee 
ORDER BY Salary

 --Get the department names of all employees who joined their projects on or after oct ,15, 2007;
 SELECT	d.Dept_name,e.Emp_fname,w.project_no ,p.project_name,w.enter_date
 FROM Department d INNER JOIN Employee e ON d.Dept_no=e.Dept_no
 INNER JOIN Works_On w ON e.Emp_no=	w.emp_no
 INNER JOIN Project  p ON w.project_no=p.project_no
 WHERE w.enter_date>= '10-15-2007'

  -- Display the employees with their department names and project names
  SELECT CONCAT(RTRIM(e.Emp_fname),' ',RTRIM(e.Emp_lname)) [Emp.Name] ,d.Dept_name,p.project_name
  FROM Department d INNER JOIN Employee e ON d.Dept_no=e.Dept_no
 INNER JOIN Works_On w ON e.Emp_no=	w.emp_no
 INNER JOIN Project  p ON w.project_no=p.project_no
  --Interview qstn
  /*Write a query that will find all employees with same first name (duplicates) in employee table .
place the name with lowest duplicate values at the top*/

SELECT emp_fname, COUNT(*)
FROM Employee
GROUP BY Emp_fname
HAVING COUNT(*) >1 
ORDER BY COUNT(*) ;

--Duplicate Domicile entries with least Duplicate entries on Top
SELECT domicile, COUNT(*)
FROM Employee_enh
GROUP BY domicile
HAVING COUNT(*) >1 
ORDER BY COUNT(*) ;

