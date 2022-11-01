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
