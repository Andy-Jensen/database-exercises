USE employees;
SELECT * FROM employees;
USE join_example_db;

/*
Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
*/
SELECT * FROM roles;
-- 4 id's
SELECT * FROM users;
-- 6 id's
/*
With inner join, I predict 4 results. With left join (users LEFT JOIN roles) I predict 6 results. With right join 
(users RIGHT JOIN roles) I predict 4 results.
*/
SELECT *
FROM users
JOIN roles ON users.id = roles.id;

SELECT *
FROM users
LEFT JOIN roles USING (id);

SELECT *
FROM users
RIGHT JOIN roles USING (id);

/*
Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
*/
SELECT *, COUNT(*) AS number_of_people
FROM roles
LEFT JOIN users USING (id)
GROUP BY id;
----------------------------------------------------------

USE employees;
SELECT * FROM employees;
/*
Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
*/
SELECT dept_name, first_name, last_name
FROM departments
LEFT JOIN dept_manager USING (dept_no)
LEFT JOIN employees USING (emp_no)
WHERE dept_manager.to_date > CURDATE();

/*
Find the name of all departments currently managed by women.
*/
SELECT dept_name, first_name, last_name
FROM departments
LEFT JOIN dept_manager USING (dept_no)
LEFT JOIN employees USING (emp_no)
WHERE dept_manager.to_date > CURDATE() AND employees.gender = 'F';

/*
Find the current titles of employees currently working in the Customer Service department.
*/
SELECT title, dept_name, COUNT(*) AS number_of_employees
FROM titles
LEFT JOIN dept_emp USING (emp_no)
LEFT JOIN departments USING (dept_no)
WHERE titles.to_date > CURDATE() AND departments.dept_name = 'Customer Service'
GROUP BY title;

/*
Find the current salary of all current managers.
*/
SELECT MAX(salary) AS current_pay, CONCAT(first_name, ' ', last_name) AS fullname, dept_name
FROM salaries
LEFT JOIN employees USING (emp_no)
LEFT JOIN dept_manager USING (emp_no)
LEFT JOIN departments USING (dept_no)
WHERE dept_manager.to_date > CURDATE() AND salaries.to_date > CURDATE()
GROUP BY CONCAT(first_name, ' ', last_name), dept_name
ORDER BY current_pay DESC;

/*
Find the number of current employees in each department.
*/
SELECT dept_no, dept_name, COUNT(*) AS number_of_employees
FROM departments
LEFT JOIN dept_emp USING (dept_no)
WHERE dept_emp.to_date > CURDATE()
GROUP BY dept_no
ORDER BY dept_no;

/*
Which department has the highest average salary? Hint: Use current not historic information.
*/ 
SELECT dept_name, ROUND(AVG(salary), 2) AS dept_average_salary
FROM salaries
LEFT JOIN dept_emp USING (emp_no)
LEFT JOIN departments USING (dept_no)
WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_average_salary DESC
LIMIT 1;

/*
Who is the highest paid employee in the Marketing department?
*/
SELECT CONCAT(first_name, ' ', last_name) AS full_name, MAX(salary) AS highest_salary
FROM employees
LEFT JOIN salaries USING (emp_no)
LEFT JOIN dept_emp USING (emp_no)
LEFT JOIN departments USING (dept_no)
WHERE dept_emp.to_date > CURDATE() AND departments.dept_name = 'Marketing'
GROUP BY first_name, last_name
ORDER BY highest_salary DESC
LIMIT 1;

/*
Which current department manager has the highest salary?
*/
SELECT CONCAT(first_name, ' ', last_name) AS fullname, MAX(salary) AS salary, dept_name
FROM salaries
RIGHT JOIN employees USING (emp_no)
LEFT JOIN dept_manager USING (emp_no)
LEFT JOIN departments USING (dept_no)
WHERE dept_manager.to_date > CURDATE()
GROUP BY fullname, dept_name
ORDER BY salary DESC
LIMIT 1;

/*
Determine the average salary for each department. Use all salary information and round your results.
*/
SELECT dept_name, ROUND(AVG(salary)) AS avg_salary
FROM departments
RIGHT JOIN dept_emp USING (dept_no)
LEFT JOIN salaries USING (emp_no)
GROUP BY dept_name
ORDER BY avg_salary DESC;

/*
Find the names of all current employees, their department name, and their current manager's name.
*/
SELECT first_name, last_name, dept_name, emp_no
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE dept_emp.to_date > CURDATE();

SELECT CONCAT(first_name, last_name) AS department_manager, emp_no
FROM employees
JOIN dept_manager USING(emp_no)
WHERE dept_manager.to_date > CURDATE();

SELECT CONCAT(g.first_name, ' ', g.last_name) AS 'Employee Name', g.dept_name AS 'Department Name', e.department_manager AS 'Department Manager'
FROM 
	(
	SELECT first_name, last_name, dept_name, emp_no
	FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	WHERE dept_emp.to_date > CURDATE()
	) AS g
LEFT JOIN
	(
	SELECT CONCAT(first_name, ' ', last_name) AS department_manager, dept_name
	FROM employees
	JOIN dept_manager USING(emp_no)
	JOIN departments USING(dept_no)
	WHERE dept_manager.to_date > CURDATE()
	) AS e ON g.dept_name = e.dept_name;