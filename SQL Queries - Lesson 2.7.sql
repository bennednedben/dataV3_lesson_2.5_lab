Use sakila;
-- Lab | 2.7 SQL Join (Part I)
-- How many films are there for each of the categories in the category table. Use appropriate join to write this query.
USE sakila;
SELECT category.name, COUNT(film_category.film_id) AS num_films
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

-- Display the total amount rung up by each staff member in August of 2005.
USE sakila;
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS total_amount
FROM staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY staff.staff_id;

-- Which actor has appeared in the most films?
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS times
FROM actor 
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id 
ORDER BY times DESC
LIMIT 1;
-- Gine Degneres

-- Most active customer (the customer that has rented the most number of films)
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(payment.rental_id) AS rented
FROM customer JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY rented DESC
LIMIT 1;
-- Eleanor Hunt

-- Display the first and last names, as well as the address, of each staff member.
SELECT staff.first_name, staff.last_name, address.address
FROM staff JOIN address
ON staff.address_id = address.address_id;
-- 2 rows

-- List each film and the number of actors who are listed for that film.
SELECT DISTINCT film.film_id, film.title, COUNT(film_actor.actor_id) AS times
FROM film JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY times;
-- 997 rows

-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT DISTINCT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) as total_paid
FROM customer JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_paid DESC;

-- List number of films per category.
SELECT film.title, category.name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
ORDER BY category.name;

SELECT film.title, SUM(category.name) AS count
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY film.title
ORDER BY count;
-- don't work