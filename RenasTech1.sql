SELECT country_name,city, department_name
FROM Countries 
INNER JOIN locations USING (country_id)
INNER JOIN Departments USING (location_id);


SELECT deparment_id, first_name ||''||last_name AS Employee_Name
FROM Deparments 
INNER JOIN Department D
INNER JOIN Employee E
ON (d.manager_id=e.employee_id);

SELECT department_name, first_name || ' ' || last_name AS name_of_manager
FROM departments D 
INNER JOIN employees E 
ON (D.manager_id=E.employee_id);

/* Write a SQL query to find those employees who earn $12000 and above. Return employee ID, 
starting date, end date, job ID and department ID (inner join) */

--UNION: COmbine two or more queries and return only distint records
SELECT *
FROM employees
WHERE employee_id >200
UNION 
SELECT *
FROM employees
WHERE employee_id >120;

/*INTERSECTION: compare the results of two queries and only returns distinc results that are 
output for both queries*/
SELECT *
FROM employees
WHERE employee_id>200

INTERSECT 
SELECT *
FROM employees
WHERE employee_id<220;

/* MINUS combina two queries and returns rwo from the first query that are not returned
by the second query*/

SELECT *
FROM employees
WHERE employee_id<220

MINUS
SELECT *
FROM employees
WHERE employee_id>200;

--GROUPING DATA 

SELECT *
FROM employees;

SELECT MAX (SALARY), MIN (salary), SUM (Salary), COUNT(*), AVG (Salary)
FROM employees;

/* Write a SQL query that returns job ids and minimum salaries for them */

SELECT job_id, MIN(SALARY)
FROM Employees
GROUP BY job_id
ORDER BY MIN(SALARY) desc;

SELECT MIN(SALARY), job_id
FROM Employees
GROUP BY job_id
ORDER BY 1 desc; --- 1: is the position of MIN (salary) 

/* RETRIEVE THE NAME OF EACH DEPARMENT AND THE MIN, MAX, AVE, TOTAL SALARY
AND NUMBER OF EMPLOYEES IN THE DEPARTMENT*/ 


SELECT  department_id, MIN(SALARY), MAX(SALARY), ROUND(AVG(SALARY)), COUNT (*), SUM(SALARY)
FROM Employees
GROUP BY Department_id;

SELECT  department_id
, MIN(SALARY) AS "Lowest Salary"
, MAX(SALARY) AS "Highest Salary"
, ROUND(AVG(SALARY)) AS "Average SAlary"
, COUNT (*) AS "Number of EMployee"
FROM Employees
GROUP BY Department_id;

-- Find the headcount of each department 

-- HOW MANY RECORDS YOU HAVE IN EACH DEPART 
SELECT department_id, count(*)
FROM employees 
GROUP BY department_id; 

-- Count how many employee ids you have in the each deparment id 
SELECT department_id, count(employee_id)
FROM employees 
GROUP BY department_id; 

-- find the headcount of each department in descending order, Return department ids, headcount

SELECT department_id, COUNT(*)
FROM Employees
GROUP BY department_id
ORDER BY COUNT (*) DESC; 

SELECT department_id, COUNT(*)
FROM Employees
GROUP BY department_id
ORDER BY 2 DESC; 

-- WRITE A SQL QUERY TO RETRIEVE DEPARTMENT ID, DEPARTMENT NAME, AND EMPLOYEE COUNT OF EACH DEPARTMENT

SELECT E.department_id, D.department_name
, count(E.employee_id) as "Numbe of employee"
FROM employees E
INNER JOIN departments D
ON E.department_id= D.department_id 
GROUP BY E.department_id, D.department_name
ORDER BY E.department_id, D.department_name;

SELECT E.department_id, D.department_name
, count(E.employee_id) as "Numbe of employee"
, MIN (E.salary)
, MAX(E.sAlary)
, ROUND (AVG(E.SALARY))
FROM employees E
INNER JOIN departments D
ON E.department_id= D.department_id 
GROUP BY E.department_id, D.department_name
HAVING MAX(E.salary)>4000;

SELECT E.department_id, D.department_name
, count(E.employee_id) as "Numbe of employee"
, MIN (E.salary)
, MAX(E.sAlary)
, ROUND (AVG(E.SALARY))
FROM employees E
INNER JOIN departments D
ON E.department_id= D.department_id 
GROUP BY E.department_id, D.department_name
HAVING MAX(E.SALARY)>4400;

-- HAVING WITH WHERE CLAUSE 

-- HAVING FILTERS GROUP AND WHERE FILTERS ROWS 

/* The following query will return only those departments whose total salary is 
between $20,000 and $30,000 */ 

SELECT department_id, sum(salary) 
FROM employees 
GROUP BY department_id
HAVING SUM(SALARY) BETWEEN 20000 and 30000; 

/*Use the countries table. Write a sql query that returns the number of countries in each region.
1.1. Find the regions that have exactly 6 countries*/

SELECT Region_id,count (country_id) 
FROM countries
group by region_id
HAVING COUNT (COUNTRY_ID)=6;

  SELECT region_id, COUNT(*) AS country_count
    FROM countries
    GROUP BY region_id
    HAVING COUNT(*) = 6;

/*Write a qsl query which returns the numner of departments in each location*/

SELECT location_id, count(department_id)
FROM departments 
group by location_id; 

SELECT location_id, count(department_id)
FROM departments 
group by location_id
HAVING count(department_id)>1;

/*Write a sql query which returns the number of employees each manager manages*/

SELECT manager_id, count (employee_id) AS COUNT_EMPLOYEE
FROM employees
GROUP BY manager_id;

-- MANAGE MORE THAN 10 PEOPLE
SELECT manager_id, count (employee_id) AS COUNT_EMPLOYEE
FROM employees
GROUP BY manager_id
HAVING COUNT (employee_id)>10;

--manage 6 people 
SELECT manager_id, count (employee_id) AS COUNT_EMPLOYEE
FROM employees
GROUP BY manager_id
HAVING COUNT (employee_id)=6;

SELECT SUBSTR(phone_number,1,3) AS AREA_CODE, COUNT(*)
FROM employees
GROUP BY SUBSTR(phone_number,1,3);

--how many employees where hired each year 

SELECT EXTRACT (YEAR FROM Hire_Date), count(*)
FROM employees
GROUP BY EXTRACT (YEAR FROM hire_date);

-- how many employees were hired in july 
SELECT EXTRACT (MONTH FROM Hire_Date), count(*)
FROM employees
GROUP BY EXTRACT (MONTH FROM hire_date)
HAVING EXTRACT (MONTH FROM hire_Date)=7;

SELECT COUNT(employee_id)
FROM employees
WHERE EXTRACT(MONTH FROM hire_date)=7;

--find total salary per department, average, min, 

SELECT department_id, SUM(SALARY), round(AVG(SALARY)), MIN(SALARY)
FROM employees
GROUP BY department_id;


-- find max salary of departments 50,90,100
SELECT department_id, max(salary)
from employees
WHERE department_id IN (50,90,100)
group by department_id; 


--CASE STATEMENTS

SELECT employee_id, salary,
 CASE 
            WHEN salary<5000 THEN 'low'
              WHEN salary BETWEEN 5000 AND 10000 THEN'medium'
                 ELSE 'High'
END AS salary_level 
FROM Employees;


SELECT employee_id, salary, 

CASE
        WHEN Salary <2000 THEN 'Junior LEvel'
            WHEN (salary >=2000 and salary <5000) THEN 'Middle level'
                WHEN (salary >=5000 and salary <10000) THEN 'Senior Level'
                   WHEN salary >=10000 then 'Manager'
                    ELSE 'unknown'
END AS Employee_id

FROM employees
WHERE salary IS NOT NULL
ORDER BY salary, first_name;
    
    
    --AGGREGATING 
    
    SELECT department_id
    ,COUNT(CASE WHEN Salary<5000 THEN 'UNDER MIN WAGE' END) AS COUNT_UNDER_MIN_WAGE
    ,COUNT(CASE WHEN Salary>=5000 THEN 'HIGHER MIN WAGE' END) AS COUNT_HIGHER_MIN_WAGE
    FROM employees
    GROUP BY department_id;
    
    
    /*Write a sql query which returns how many employees have salaries more than $3,000 
    and how many have less than equal to $3,000 for each job id in the employees table*/
    
    SELECT job_id 
    , COUNT (CASE WHEN Salary<3000 THEN 'LESS THAN 3000'END) AS LESS_THAN_3000
    , COUNT (CASE WHEN Salary>=3000 THEN 'MORE THAN 3000' END) AS MORE_THAN_300    
    from employees
    GROUP BY job_id; 
    
    SELECT employee_id, salary 
    FROM employees
    WHERE salary<3000
    UNION 
    
    SELECT employee_id,salary 
    from employees
    WHERE salary>3000;
    
    /*Write a sql query which returns how many employees started the job before June
    and how many started after June for each department id in the employees table. (Hint: EXTRACT(MONTH FROM E.hire_date))*/
    
    SELECT employee_id 
    ,COUNT( 
    CASE 
    WHEN EXTRACT(MONTH FROM hire_date)<6 THEN 'before june'
    END ) AS BEFORE_JUNE
    ,COUNT( 
    CASE 
    WHEN EXTRACT(MONTH FROM hire_date)>6 THEN 'after june'
    END) AS AFTER_JUNE
    FROM employees
    GROUP BY employee_id;

--SUBQUERIES 

--WRITE A SQL QUERY WHICH RETURNS ALL EMPLOYEES WHOSE DEPARTMENT IS LOCATED IN THE LOCATION WITH THE ID 1700


SELECT *
FROM departments 
WHERE location_id=1700;

SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id IN (    
                        SELECT department_id 
                        FROM departments 
                        WHERE location_id=1700);  
                        
-- Wrie a QSL query to find all those employees who earn mre than an employee who last name is ozer
-- order by last name 
--return name, last name and salary 


--11500
Select salary 
FROM employees
WHERE last_name ='Ozer';

SELECT last_name, salary 
FROM employees
WHERE salary>11500; 

--SUBQUERY 
SELECT last_name, salary 
FROM employees
WHERE salary>
            (Select salary 
            FROM employees
            WHERE last_name ='Ozer')
ORDER BY salary ;
            
   -- qrite a sql to find those departments, located in the city ´munich
   --return department id, and depart_name 
   
   SELECT department_id, department_name
   FROM departments
   WHERE location_id IN 
                    (SELECT location_id
                    from locations 
                    WHERE city IN ('Munich'));
                    
                    
-- Munich has location munich 2700
    SELECT department_id, department_name, location_id
   FROM departments;
   
   
   -- write a sql query to find those who earn more than average salary 
   -- and who work in any of the IT departments return first_name and last name
   
   
   SELECT first_name, last_name 
   from employees;

   
   Select ROUND(AVG (SALARY),2) 
   FROM employees;
   
   SELECT department_id
   from departments
   WHERE department_name LIKE '%IT%';
   
    SELECT first_name, last_name 
   from employees
   WHERE salary > (Select ROUND(AVG (SALARY),2) 
                   FROM employees)
                   AND 
                   department_id IN ( 
                   SELECT department_id
                   from departments
                   WHERE department_name LIKE '%IT%') ;
                   
            
    --WRITE A SQL QUERY TO FIND THOSE EMPLOYEES WHO WORK IN A DEPARTMENT WHERE THE EMPLOYEES
    --CONTAINS A LETTER R 
    -- RETURNS Employe_id, firt_name and last name
    
    SELECT first_name, last_name, employee_id 
    FROM employees
    WHERE department_id IN 
                    (SELECT Department_id
                    FROM departments
                    WHERE Department_name LIKE '%R%');
                    
                    --example with WHERE and ANY 
    
    -- WRITE A SQL QUERY TO FIND THOSE EMPLOYEES WHO SALARY IS LOWER THAN ANY SLARY
    -- OF THOSE EMPLOYEES WHO JOB TITLE IS 'IT_PROG'. RETURN EMPLOYEE ID, FIRST NAME 
    --LAST NAME, JOB ID
    
  
    
   /*
Write a SQL query to find those employees who get a higher salary than the employee whose ID is 163. Return first name, last name.

Write a SQL query to find those employees whose designation is the same as the employee whose ID is 169. Return first name, last name, department ID and job ID.

Write a SQL query to find those employees whose salary matches the smallest salary of any of the departments. Return first name, last name and department ID. (Hint: you need to use group by)

Write a SQL query to find those employees who earn more than the average salary. Return employee ID, first name, last name. 

Write a SQL query to find those employees who report that manager whose first name is ‘Payam’. Return first name, last name, employee ID and salary.

Write a SQL query to find those employees whose salary is in the range of smallest salary, and 2500. Return all the fields.

Write a SQL query to find those employees whose salary is lower than any salary of those employees whose job title is 'MK_MAN'. Return employee ID, first name, last name, job ID.
 
Write a SQL query to find those employees whose department is located at 'Toronto'. Return first name, last name, employee ID, job ID.

Write a SQL query to find those employees who earn more than the average salary and work in a department with any employee whose first name contains a character a 'J'. Return employee ID, first name and salary.

Write a SQL query to find those employees who work in a department where the employee’s first name contains a letter 'T'. Return employee ID, first name and last name.

Write a SQL query to find those employees who work in the same department where 'Clara' works. Exclude all those records where the first name is 'Clara'. Return first name, last name and hire date.

Write a SQL query to find those employees who get the second-highest salary. Return all the fields of the employees.

Write a SQL query to find those employees who do not work in those departments where manager ids are in between 100 and 200. Return all the fields of the employees.

Write a SQL query to find those employees whose salary is more than the average salary of any department. Return employee ID, first name, last name, job ID.

Write a SQL query to find those employees who work in the department 'Marketing'. Return first name, last name and department ID.

Write a SQL query to find those employees whose salary matches to the salary of the employee who works in that department of ID 40. Return first name, last name, salary, and department ID.

Write a SQL query to find those employees who work in the department  where the employee with employee_id=201 works. Return first name, last name, salary, and department ID.

Write a SQL query to find those employees who earn more than the maximum salary of a department of ID 40. Return first name, last name and department ID.

Write a SQL query to find those employees who earn more than the average salary. Sort the result-set in descending order by salary. Return first name, last name, salary, and department ID.

Write a SQL query to find those employees who work in departments located at 'United Kingdom’. Return first name.

Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

Write a query to display the employee id, name ( first name and last name ), Salary, AvgCompare (salary - the average salary of all employees) and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

*/

---WINDOWS

SELECT first_name, last_name,department_id, salary 
, MIN(salary) OVER ( PARTITION BY department_id ORDER BY salary) AS min_salary 
FROM Employees; 
 
 SELECT first_name, last_name, department_id, salary 
 , AVG (Salary) OVER (PARTITION BY department_id ORDER by Salary Desc) AS AVERAGE
 from employees;
 
 SELECT first_name, last_name, department_id, salary 
 ,ROUND (AVG (SALARY),2) OVER (PARTITION BY department_id ORDER by Salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS MIN_SALARY
 from employees;
 
 SELECT first_name, last_name, department_id
 , MIN(SALARY) OVER (PARTITION BY department_id ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS MIN_SALARY
 , MAX (SALARY) OVER (PARTITION BY department_id ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS MAX_SALARY
 , SUM (SALARY) OVER (PARTITION BY department_id ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS SUM_SALARY
 ,ROUND( AVG (SALARY) OVER (PARTITION BY department_id ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2) AS MAX_SALARY
 , COUNT (*) OVER ( PARTITION BY department_id) AS HEAD_COUNT
 FROM Employees;
  
---SQL LECTURE 12 


--CALCULATE THE ROW NUMBER, RANK, DENSE RANK OF EMPLOYEES IN THE EMPLOYEE TABLE ACCORDING TO SALARY DEPARTMENT 

SELECT first_name, last_name, department_id, salary 
, RANK () OVER(PARTITION BY department_id ORDER BY salary DESC)AS emp_rank
, DENSE_RANK () OVER(PARTITION BY department_id ORDER BY salary DESC)AS DENSE_RANK
, ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC)AS ROW_NUMBER
FROM Employees

--WINDOW FIRST_VALUE 
--- lowest salary in each department 

SELECT first_name, last_name, department_id, salary 
, FIRST_VALUE(FIRST_name) OVER ( PARTITION BY department_id ORDER BY  salary ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as lowest_value
, FIRST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY  salary ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as salary_value
FROM employees;

--highest salary in each department 

SELECT first_name, last_name, department_id, salary 
, FIRST_VALUE(FIRST_name) OVER ( PARTITION BY department_id ORDER BY  salary DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as lowest_value
, FIRST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY  salary DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as salary_value
FROM employees;

SELECT first_name, last_name, department_id, salary 
, LAST_VALUE(FIRST_name) OVER ( PARTITION BY department_id ORDER BY  salary ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as lowest_value
, LAST_VALUE(salary) OVER ( PARTITION BY department_id ORDER BY  salary ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as salary_value
FROM employees;

---THE HIRE DATE OF THE EMPLOYEE HIRED JUST AFTER IN THE COMPANY 

SELECT first_name, last_name, department_id, hire_date 
FROM Employees
ORDER BY hire_date;

SELECT first_name, last_name, department_id, hire_date
, LEAD (hire_date, 1) OVER (ORDER BY hire_date ASC) AS NEXT_HIRE_DATE
FROM Employees;

--hire date of the mployee just after in the same department 

SELECT first_name, last_name, department_id, hire_date
, LEAD (hire_date,1) OVER ( PARTITION BY department_id ORDER BY hire_date ASC) AS Next_hire_date
, LEAD (first_name,1) OVER (PARTITION BY department_id ORDER BY hire_date ASC) AS NEXT_HIRED
FROM employees; 

--NOTE YOUSHOULD NOT USE "RANGE BETWEEN UNBOUND PRECEDING AND UNBOUNDED FOLLOWING WHILE 
--USING LEAD 


--LAG 
SELECT first_name, last_name, department_id, hire_date
, LAG (hire_date, 1) OVER ( ORDER BY hire_date ASC) AS previous_hire_date
, LAG (first_name,1) OVER ( ORDER By hire_date ASC) AS previous_hire
FROM employees;

--COMMON TABLES EXPRESSION (CTES) 
-- it does not work because emp rank is not in employee table
SELECT first_name, last_name, department_id, salary 
, RANK () OVER (PARTITION BY department_id ORDER BY Salary DESC) AS Emp_rank
FROM employees 
WHERE emp_rank=1

-- IT CREATES A TEMPORARY TABLE 
WITH Salary_ranking as
(
SELECT first_name, last_name, department_id, salary 
, RANK () OVER (PARTITION BY department_id ORDER BY Salary DESC) AS Emp_rank
FROM employees 
)

SELECT first_name,last_name, Emp_rank
FROM Salary_ranking

--EXAMPLE 2 
--WRITE A SQL QUERY THAT RETURNS THE EMPLOYEES WHO GET THE HIGHEST SALARY IN THEIR
--DEPARTMENT 

WITH Salary_rank AS
(
SELECT first_name, last_name, department_id, salary
, RANK () OVER ( PARTITION BY department_id ORDER BY Salary DESC)AS Emp_rank 
FROM employees
)
SELECT first_name, department_id, salary, emp_rank
FROM Salary_rank
WHERE Emp_rank=1; 

--- with department  name from another table -- INER JOIN

WITH Salary_rank AS
(
SELECT first_name, last_name, department_id, salary
, RANK () OVER ( PARTITION BY department_id ORDER BY Salary DESC)AS Emp_rank 
FROM employees
)
SELECT R.first_name, R.department_id, R.salary, R.emp_rank, D.department_name
FROM Salary_rank R
INNER JOIN Departments D
ON R.department_id= D.department_id;

