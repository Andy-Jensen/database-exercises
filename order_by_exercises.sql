USE employees;

SELECT *
FROM employees;

/* 
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
*/

SELECT *
FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY first_name;
-- Irena Reutenauer is first and Vidya Simmen is last

/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
*/
SELECT *
FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY first_name, last_name;
-- Irena Acton is first and Vidya Zweizig is last

/*
Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
*/
SELECT *
FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY last_name, first_name;
-- Irena Acton is first
SELECT *
FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY last_name DESC, first_name DESC;
-- Maya Zyda is last

/*
Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
*/
SELECT *
FROM employees
	WHERE last_name LIKE 'E%E'
	ORDER BY emp_no;
-- Ramzi Erde is first
SELECT *
FROM employees
	WHERE last_name LIKE 'E%E'
	ORDER BY emp_no DESC;
-- Tadahiro Erde is last

/*
Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
*/
SELECT *
FROM employees
	WHERE last_name LIKE 'E%E'
	ORDER BY hire_date DESC;
-- 899 rows returned, Teiji Eldridge is newest
SELECT *
FROM employees
	WHERE last_name LIKE 'E%E'
	ORDER BY hire_date ASC;
-- Sergi Erde is the "oldest" employee

/*
Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
*/
SELECT *
FROM employees
	WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
	ORDER BY birth_date, hire_date DESC;
-- 362 rows returned, Kuhn Bernini is the oldest
SELECT *
FROM employees
	WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
	ORDER BY birth_date DESC, hire_date;
-- Douadi Pettis is the youngest