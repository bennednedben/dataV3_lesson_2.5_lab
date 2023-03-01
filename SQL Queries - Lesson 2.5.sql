-- Lab | SQL Queries - Lesson 2.5
USE sakila;

-- 1 Select all the actors with the first name ‘Scarlett’
SELECT * FROM sakila.actor WHERE first_name = 'Scarlett';

-- 2 How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(DISTINCT film_id)
FROM sakila.inventory; -- 958 films an inventory
SELECT COUNT(DISTINCT film_id)
FROM sakila.film; -- 1000 film titles

-- 3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(Length) AS max_movie_duration, MIN(Length) AS min_movie_duration
FROM sakila.film; -- max=185/min=46

-- 4 What's the average movie duration expressed in format (hours, minutes)?
SELECT SEC_TO_TIME(AVG(length*60)) 
FROM sakila.film; -- '01:55:16.3200'

SELECT SEC_TO_TIME(round(AVG(length*60),0)) AS average_movie_duration
FROM sakila.film; -- '01:55:16'

SELECT DATE_FORMAT(SEC_TO_TIME(round(AVG(length*60),0)), '%H:%i') AS average_movie_duration
FROM sakila.film; -- '01:55'

-- 5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT (last_name))
FROM sakila.actor; -- 121

-- 6 Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(max(last_update),min(rental_date)) AS 'operating days' 
FROM sakila.address, sakila.rental; -- Error Code: 1052. Column 'last_update' in field list is ambiguous

SELECT DATEDIFF(max(return_date),min(rental_date)) AS 'operating days' 
FROM sakila.rental; -- 101

SELECT DATEDIFF(max(payment_date),min(payment_date)) AS 'operating days' 
FROM sakila.payment; -- 206


-- 7 Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, DATE_FORMAT(rental_date, '%M') AS 'Month', DATE_FORMAT(rental_date, '%W') AS 'Weekday'
FROM sakila.rental;

-- 8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, DATE_FORMAT(rental_date, '%M') AS 'Month', DATE_FORMAT(rental_date, '%W') AS 'Weekday'
FROM sakila.rental
LIMIT 20;

-- 9 Get release years.
SELECT release_year , title
FROM sakila.film; -- 2006 ??? Not possible

-- 10 Get all films with ARMAGEDDON in the title.
SELECT title
FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11 Get all films which title ends with APOLLO.
SELECT title
FROM sakila.film
WHERE title LIKE '%APOLLO';

-- 12 Get 10 the longest films.
SELECT title, length AS 'max duration'
FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13 How many films include Behind the Scenes content?
SELECT COUNT(DISTINCT(title))
FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';  -- 538 films