USE employees;

/*
Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
*/
CREATE TEMPORARY TABLE noether_2035.employees_with_departments AS (
     SELECT first_name, last_name, dept_name
     FROM employees
     JOIN dept_emp USING(emp_no)
     JOIN departments USING(dept_no)
     );

/*
Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
*/
ALTER TABLE noether_2035.employees_with_departments ADD full_name VARCHAR(100);

/*
Update the table so that full name column contains the correct data
*/
UPDATE noether_2035.employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

/*
Remove the first_name and last_name columns from the table.
*/
ALTER TABLE noether_2035.employees_with_departments DROP COLUMN first_name;
ALTER TABLE noether_2035.employees_with_departments DROP COLUMN last_name;

/*
What is another way you could have ended up with this same table?
*/
SELECT CONCAT(first_name, ' ', last_name) as full_name, dept_name
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no);

/*
Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/
CREATE TEMPORARY TABLE noether_2035.payment AS (
     SELECT amount
     FROM payment
     );
     
SELECT * FROM noether_2035.payment;

SELECT CAST(amount * 100 as unsigned) AS cents
FROM noether_2035.payment;


USE employees;
/*
Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
*/

# created temp table with the average salary of each dept and the dept name
CREATE TEMPORARY TABLE noether_2035.avg_salary_and_department AS(
     SELECT ROUND(AVG(salary), 2) as avg_salary, dept_name
     FROM salaries
     JOIN dept_emp USING(emp_no)
     JOIN departments USING(dept_no)
     WHERE salaries.to_date > CURDATE()
     GROUP BY dept_name
     );

# added average salary of all current employees
ALTER TABLE noether_2035.avg_salary_and_department ADD overall_average_salary VARCHAR(100);
UPDATE noether_2035.avg_salary_and_department
     SET overall_average_salary = (
          SELECT ROUND(AVG(salary), 2)
          FROM salaries
          WHERE to_date > CURDATE());

# added the standard deviation of salaries for all current employees
ALTER TABLE noether_2035.avg_salary_and_department ADD standard_deviation VARCHAR(100);
UPDATE noether_2035.avg_salary_and_department
     SET standard_deviation = (
          SELECT ROUND(STDDEV(salary), 2)
          FROM salaries
          WHERE to_date > CURDATE());

# added the z-score for all departments
ALTER TABLE noether_2035.avg_salary_and_department ADD zscore VARCHAR (100);
UPDATE noether_2035.avg_salary_and_department
     SET zscore = (
          (avg_salary - overall_average_salary)
          /
          standard_deviation);
          
# final table with results
SELECT * FROM noether_2035.avg_salary_and_department;
# the best department to work for is sales. the worst department to work for is research.

/*
BONUS- To your work with current salary zscores, determine the overall historic average departement average salary, the historic overall average, and the historic zscores for salary. Do the zscores for current department average salaries tell a similar or a different story than the historic department salary zscores?
*/

CREATE TEMPORARY TABLE noether_2035.historical_info AS (
     SELECT ROUND(AVG(salary), 2) as historical_avg_salary, dept_name
     FROM salaries
     JOIN dept_emp USING(emp_no)
     JOIN departments USING(dept_no)
     WHERE salaries.to_date < CURDATE()
     GROUP BY dept_name
     );
     
ALTER TABLE noether_2035.historical_info ADD historical_overall_average_salary VARCHAR(100);
UPDATE noether_2035.historical_info
     SET historical_overall_average_salary = (
          SELECT ROUND(AVG(salary), 2)
          FROM salaries
          WHERE to_date < CURDATE());
          
ALTER TABLE noether_2035.historical_info ADD historical_standard_deviation VARCHAR(100);
UPDATE noether_2035.historical_info
     SET historical_standard_deviation = (
          SELECT ROUND(STDDEV(salary), 2)
          FROM salaries
          WHERE to_date < CURDATE());
          
ALTER TABLE noether_2035.historical_info ADD historical_zscore VARCHAR (100);
UPDATE noether_2035.historical_info
     SET historical_zscore = (
          (historical_avg_salary - historical_overall_average_salary)
          /
          historical_standard_deviation);

# combined information for z-score and other comparison
SELECT * FROM noether_2035.historical_info
     JOIN noether_2035.avg_salary_and_department USING(dept_name);
     
/* 
The historical data shows a similar trend with current z-scores. Best department to work for was sales, 
and worst was research.