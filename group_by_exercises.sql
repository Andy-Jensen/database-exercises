USE employees;
SELECT * FROM employees;
/*
In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
*/
SELECT DISTINCT title
FROM titles;
-- 7 titles

/*
Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
*/
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- Erde, Eldridge, Etalle, Erie, Erbe

/*
Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
*/
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;
-- 846 rows returned

/*
Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
*/
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- Chleq, Lindqvist, Qiwen

/*
Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
*/
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- Chleq, 189; Lindqvist, 190; Qiwen, 168

/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
*/

SELECT first_name, gender, COUNT(*) AS number_of_people
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
HAVING gender = 'M';
-- Vidya, M, 151; Irena, M, 144; Maya, M, 146
SELECT first_name, gender, COUNT(*) AS number_of_people
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
HAVING gender = 'F';
-- Vidya, F, 81; Irena, F, 97; Maya, F, 90

/*
Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
*/
SELECT CONCAT(first_name, '.', last_name) AS username, COUNT(*) AS number_of_usernames
FROM employees
GROUP BY username;
-- Yes there are duplicates
SELECT CONCAT(first_name, '.', last_name) AS username, COUNT(*) AS number_of_usernames
FROM employees
GROUP BY username
HAVING number_of_usernames > 1;
-- there are 19683 usernames that have duplicates

/*
Bonus: More practice with aggregate functions:

Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
*/
SELECT emp_no, AVG(salary) AS avg_salary
FROM salaries
GROUP BY emp_no;

/*
Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
*/
SELECT * FROM dept_emp;

SELECT dept_no, COUNT(*) AS number_of_employees
FROM dept_emp
GROUP BY dept_no;
/*
d001: 20211
d002: 17346
d003: 17786
d004: 73485
d005: 85707
d006: 20117
d007: 52245
d008: 21126
d009: 23580
*/

/*
Determine how many different salaries each employee has had. This includes both historic and current.
*/
SELECT * FROM salaries;

SELECT emp_no, COUNT(salary) AS number_of_salaries
FROM salaries
GROUP BY emp_no;

/*
Find the maximum salary for each employee.
*/
SELECT emp_no, MAX(salary) AS max_salary
FROM salaries
GROUP BY emp_no;

/*
Find the minimum salary for each employee.
*/
SELECT emp_no, MIN(salary) AS min_salary
FROM salaries
GROUP BY emp_no;

/*
Find the standard deviation of salaries for each employee.
*/
SELECT emp_no, ROUND(STDDEV(salary), 2) AS rounded_salary_stddev
FROM salaries
GROUP BY emp_no;

/*
Now find the max salary for each employee where that max salary is greater than $150,000.
*/
SELECT emp_no, MAX(salary) AS max_salary
FROM salaries
GROUP BY emp_no
HAVING max_salary > 150000;

/*
Find the average salary for each employee where that average salary is between $80k and $90k.
*/
SELECT emp_no, AVG(salary) AS avg_salary
FROM salaries
GROUP BY emp_no
HAVING avg_salary BETWEEN 80000 AND 90000;
