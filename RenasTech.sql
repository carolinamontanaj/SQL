
-- join lecture 2-- 
SELECT *
FROM employees;

SELECT *
FROM job_history;

SELECT employees.first_name,employees.employee_id, job_history.start_date, job_history.end_date
FROM employees
INNER JOIN job_history
ON employees.employee_id=job_history.employee_id;

SELECT E.first_name,E.employee_id, J.start_date, J.end_date
FROM employees E
INNER JOIN job_history J
ON E.employee_id=J.employee_id;

SELECT E.first_name ,E.employee_iD, E.salary, J.start_date,J.end_date
FROM employees E
INNER JOIN job_history J
ON E.employee_id=J.employee_id
WHERE E.salary > 8000; 

SELECT E.first_name ,E.employee_iD, E.salary, J.start_date,J.end_date
FROM employees E
INNER JOIN job_history J
ON E.employee_id=J.employee_id
WHERE E.salary > 8000
ORDER BY e.salary; 

SELECT E.first_name ,E.employee_iD, E.salary, J.start_date,J.end_date
FROM employees E
INNER JOIN job_history J
ON E.employee_id=J.employee_id
WHERE E.salary > 8000
ORDER BY j.end_date ASC ; 

SELECT employees.first_name, employees.employee_id, job_history.start_date,job_history.end_date
from employees
left join job_history
on employees.employee_id = job_history.employee_id;

SELECT first_name, last_name, E.department_id, department_name
FROM employees E
JOIN departments D
ON E.department_id= D.department_id;

SELECT E.first_name, E.last_name, D.*
FROM employees E
JOIN departments D
ON E.department_id= D.department_id;

-- lecture 3 

SELECT D.department_name,L.city, L.state_province, L.location_id
FROM departments D
JOIN locations L
ON D.location_id = L.location_id
ORDER BY d.department_name, city;

SELECT D.department_name,L.city, L.state_province, L.location_id
FROM departments D
left JOIN locations L
ON D.location_id = L.location_id
ORDER BY d.department_name, city;

SELECT E.first_name, E.last_name,D.department_id,D.department_name
FROM employees E
left JOIN departments D
ON E.department_id=D.department_id; 

SELECT first_name, last_name, start_date,end_Date
from employees E
left JOIN job_history J
ON E.employee_id=J.employee_id;

SELECT first_name, last_name, start_date,end_Date
from employees E
left JOIN job_history J
USING (employee_id);

SELECT E.first_name, E.last_name, D.department_id, department_name
FROM departments D
RIGHT JOIN employees E
ON D.department_id = E.department_id;

select employee_id, reference_id
from basic_pays;

select *
from basic_pays;

select employee_id, fiscal_year
from basic_pays;

SELECT E.first_name, E.salary,E.employee_id,B.reference_id,B.fiscal_year
FROM employees E
FULL OUTER JOIN basic_pays B
ON E.employee_id=B.employee_id; 

SELECT first_name, last_name, start_date,end_Date
from employees E
FULL OUTER JOIN job_history J
USING (employee_id);

