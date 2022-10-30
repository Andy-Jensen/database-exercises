USE employees;

/*
Find all the current employees with the same hire date as employee 101010 using a sub-query.
*/
SELECT CONCAT(first_name, ' ', last_name) AS fullname, hire_date
FROM employees
JOIN dept_emp USING(emp_no)
WHERE dept_emp.to_date > CURDATE() AND hire_date = (
													SELECT hire_date
												FROM employees
												JOIN dept_emp USING(emp_no)
												WHERE emp_no = '101010'
												);
						
/*
Find all the titles ever held by all current employees with the first name Aamod.
*/
SELECT CONCAT(first_name, ' ', last_name) AS fullname, title
FROM employees
JOIN titles USING (emp_no)
WHERE first_name IN (
					SELECT first_name
					FROM titles
					JOIN employees USING(emp_no)
					WHERE titles.to_date > CURDATE() AND first_name = 'Aamod'
						);

/*
How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
*/
SELECT COUNT(*) AS churn
FROM employees
JOIN dept_emp USING(emp_no)
WHERE to_date IN (
				SELECT to_date
					FROM dept_emp
					JOIN employees USING (emp_no)
					WHERE to_date < CURDATE()
					);
					-- 91,479 employees churned
					
/*
Find all the current department managers that are female. List their names in a comment in your code.
*/
SELECT first_name, last_name
FROM employees
JOIN dept_manager USING(emp_no)
WHERE employees.gender = 'F' AND first_name IN (
															SELECT first_name
												FROM employees
												JOIN dept_manager USING(emp_no)
												WHERE dept_manager.to_date > CURDATE()
												);
												-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
												
/*
Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/
SELECT emp_no, first_name, last_name
FROM employees
JOIN salaries USING(emp_no)
WHERE salaries.to_date > CURDATE() AND salary > (
				SELECT AVG(salary)
					FROM salaries
					#add this line to get average salary not including current employees salaries
					#WHERE to_date < CURDATE()
					)
					GROUP BY emp_no, first_name, last_name;
					
/*
How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
*/
