USE employees;
/*
Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
*/
SELECT CONCAT(first_name, ' ', last_name) as full_name, dept_no, hire_date, to_date, 
          IF(to_date > CURDATE(), TRUE, FALSE) AS is_current_employee
FROM departments
JOIN dept_emp USING(dept_no)
JOIN employees USING(emp_no);

/*
Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
*/
SELECT first_name, last_name,
     CASE 
          WHEN last_name LIKE 'A%' OR last_name LIKE 'B%' OR last_name LIKE 'C%' OR last_name LIKE 'D%' OR last_name LIKE 'E%' OR last_name LIKE 'F%' OR last_name LIKE 'G%' OR last_name LIKE 'H%' THEN 'A-H'
          WHEN last_name LIKE 'I%' OR last_name LIKE 'J%' OR last_name LIKE 'K%' OR last_name LIKE 'L%' OR last_name LIKE 'M%' OR last_name LIKE 'N%' OR last_name LIKE 'O%' OR last_name LIKE 'P%' OR last_name LIKE 'Q%' THEN 'I-Q'
          WHEN last_name LIKE 'R%' OR last_name LIKE 'S%' OR last_name LIKE 'T%' OR last_name LIKE 'U%' OR last_name LIKE 'V%' OR last_name LIKE 'W%' OR last_name LIKE 'X%' OR last_name LIKE 'Y%' OR last_name LIKE 'Z%' THEN 'R-Z'
          ELSE 'other'
     END AS alpha_group
FROM employees;
#or use BETWEEN

/*
How many employees (current or previous) were born in each decade?
*/
SELECT birth_date
FROM employees
order by birth_date desc;

SELECT COUNT(*) as employees_old, decade
FROM(
     SELECT birth_date,
     CASE
          WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN '50s'
          WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN '60s'
     END as decade
FROM employees) as d
GROUP BY decade;

/*
What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/
SELECT ROUND(AVG(salary), 2) as department_average_salary, department_catagories
FROM(
     SELECT salary, dept_name,
          CASE 
               WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
               WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
               WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
               WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
               ELSE 'Customer Service'
          END AS department_catagories
     FROM salaries
     JOIN dept_emp USING (emp_no)
     JOIN departments USING (dept_no)
     WHERE dept_emp.to_date > CURDATE()
     ) as e
GROUP BY department_catagories;
