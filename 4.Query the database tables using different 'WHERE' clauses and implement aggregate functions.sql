-- Select employees from Sales department
SELECT * FROM employees WHERE department = 'Sales';

-- Select employees from Sales department with salary greater than 50,000
SELECT * FROM employees WHERE department = 'Sales' AND salary > 50000;

-- Select employees whose name starts with 'A'
SELECT * FROM employees WHERE name LIKE 'A%';

-- Count how many employees are in Sales department
SELECT COUNT(*) AS sales_count FROM employees WHERE department = 'Sales';

-- Sum of salaries of employees earning more than 50,000
SELECT SUM(salary) AS high_salary_sum FROM employees WHERE salary > 50000;

-- Average salary of Engineering department employees
SELECT AVG(salary) AS avg_engineering_salary FROM employees WHERE department = 'Engineering';

-- Maximum salary in the company
SELECT MAX(salary) AS max_salary FROM employees;

-- Minimum salary among employees who have a manager
SELECT MIN(salary) AS min_salary_with_manager FROM employees WHERE manager_id IS NOT NULL;
