 /*                           __
                            |  |
.__.__.__.__.__._____._____.|  |
|        |  |  |__ --|  _  ||  |
|__|__|__|___  |_____|__   ||__|
        __| |        |  |_
        '____|        |____'
e x e r c i s e s
*/

USE sakila;
/*
SELECT statements

Select all columns from the actor table.
*/
SELECT * FROM actor;
/*
Select only the last_name column from the actor table.
*/
SELECT last_update FROM actor;
/*
Select only the film_id, title, and release_year columns from the film table.
*/
SELECT film_id, title, release_year FROM film;

/*
DISTINCT operator

Select all distinct (different) last names from the actor table.
*/
SELECT DISTINCT last_name FROM actor;
/*
Select all distinct (different) postal codes from the address table.
*/
SELECT DISTINCT postal_code FROM address;
/*
Select all distinct (different) ratings from the film table.
*/
SELECT DISTINCT rating FROM film_list;

/*
WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
*/
SELECT * FROM payment;
SELECT title, description, rating, length
FROM film
WHERE length >= 180;
/*
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
*/
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27'
ORDER BY payment_date;
/*
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
*/
DESCRIBE payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '2005-05-27%';
/*
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
*/
SELECT * FROM customer;
SELECT *
FROM customer
WHERE first_name LIKE '%n' AND last_name LIKE 'S%';
/*
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
*/
SELECT *
FROM customer
WHERE active = '0' OR last_name LIKE 'M%';
/*
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
*/
DESCRIBE category;
SELECT * FROM category;
SELECT *
FROM category
WHERE category_id > 4 AND `name` LIKE 'C%' OR `name` LIKE 'S%' OR `name` LIKE 'T%';
/*
Select all columns minus the password column from the staff table for rows that contain a password.
*/

/*
Select all columns minus the password column from the staff table for rows that do not contain a password.
*/