USE employees;

SHOW TABLES;

/* Which table(s) do you think show a numeric type column?
I think all of them have a numeric type column. There could be an id column as the primary key and/or another column. Departments may have a number of employees column, employees may have number of years employed or a boolean value if they are still working at the company, and salaries are decimal values.*/

/* Which table(s) do you think show a string type column?
Again, I think all of them have string type columns. All of the tables could include a name or position column.*/

/* Which table(s) do you think show a date type column?
dept_emp, dept_manager, employees, salaries, and titles. They could have start dates or end dates of employees joining or leaving the department/company. Salaries could have dates of pay increases, decreases, or bonuses. Employees may have a birthday column.*/

/* What is the relationship between the employees and the departments tables?
The name of the employee, the date of the employee joining the company, and the name of the department they joined.*/

SHOW CREATE TABLE dept_manager;

/*
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
