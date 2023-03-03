-- Lab | 2.8 SQL Join (Part II)

-- Write a query to display for each store its store ID, city, and country.
Use sakila;
SELECT store.store_id, city.city, country.country
FROM store
JOIN address
ON store.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id AS store2, CONCAT('$', FORMAT(sum(payment.amount),2)) AS amount 
FROM store
JOIN customer 
ON store.store_id = customer.store_id
JOIN payment 
ON customer.customer_id = payment.customer_id
GROUP BY store2;

-- Which film categories are longest?
SELECT DISTINCT category.name, SEC_TO_TIME(AVG(length*60)) as time
FROM film_category
JOIN category
ON category.category_id = film_category.category_id
JOIN film
ON film.film_id = film_category.film_id
GROUP BY category.name
ORDER BY time DESC
LIMIT 5;

-- Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(rental.rental_date) as rented
FROM film
JOIN inventory 
USING (film_id)
JOIN rental 
USING (inventory_id)
GROUP BY film.title
ORDER BY rented DESC
LIMIT 3;

-- List the top five genres in gross revenue (Bruttoeinnahmen) in descending order.
SELECT category.name, SUM(payment.amount) as revenue
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY revenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
CASE WHEN COUNT(*) > 0 
THEN 'Yes' 
ELSE 'No' 
END AS available
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur';

-- Get all pairs of actors that worked together.
SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1, CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id != fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY actor1, actor2;

-- Bonus: Get all pairs of customers that have rented the same film more than 3 times.


-- Bonus: For each film, list actor that has acted in more films.

