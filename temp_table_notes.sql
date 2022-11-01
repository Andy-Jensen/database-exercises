DROP TABLE IF EXISTS my_numbers;

CREATE TEMPORARY TABLE my_numbers(
     n INT UNSIGNED NOT NULL,
     `name` VARCHAR(10) NOT NULL
     );
     
SELECT *
FROM my_numbers;

# Insert data into my_numbers
INSERT INTO my_numbers(n, `name`)
VALUES (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e');

# delete from my_numbers
DELETE FROM my_numbers WHERE n > 4;

# transform our existing data
UPDATE my_numbers SET n = n + 1;

# transform our existing data with a condition
UPDATE my_numbers SET n = n + 10
WHERE `name` = 'a';

#--------------------------------------------------------

USE employees;

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS e 
JOIN dept_emp de USING (emp_no)
JOIN salaries s USING (emp_no)
JOIN departments d USING (dept_no)
JOIN titles t USING (emp_no)
WHERE de.to_date > NOW()
     AND s.to_date > NOW()
     AND t.to_date > NOW()
     AND dept_name = 'Customer Service';
     
CREATE TEMPORARY TABLE noether_2035.salary_info AS (
     SELECT emp_no, dept_no, first_name, last_name, salary, title
     FROM employees AS e 
     JOIN dept_emp de USING (emp_no)
     JOIN salaries s USING (emp_no)
     JOIN departments d USING (dept_no)
     JOIN titles t USING (emp_no)
     WHERE de.to_date > NOW()
          AND s.to_date > NOW()
          AND t.to_date > NOW()
          AND dept_name = 'Customer Service'
          );
          
SELECT *
FROM noether_2035.salary_info;

# what is the average salary for employees in customer service
SELECT AVG(salary)
FROM noether_2035.salary_info;

# add new columns to temp table
ALTER TABLE noether_2035.salary_info ADD avg_salary FLOAT;
ALTER TABLE noether_2035.salary_info ADD std_salary FLOAT;
ALTER TABLE noether_2035.salary_info ADD greater_than_avg INT;

# update new columns with new info
UPDATE noether_2035.salary_info SET avg_salary = (
     SELECT ROUND(AVG(salary), 2)
     FROM salaries
     );

UPDATE noether_2035.salary_info SET std_salary = (
     SELECT ROUND(STDDEV(salary), 2)
     FROM salaries
     );

UPDATE noether_2035.salary_info SET greater_than_avg = (
     SELECT (ROUND(AVG(salary), 2)) - (ROUND(STDDEV(salary), 2))
     FROM salaries
     );