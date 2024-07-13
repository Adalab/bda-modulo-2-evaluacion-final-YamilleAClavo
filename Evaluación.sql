USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. --
SELECT DISTINCT title
FROM film;


-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13" --
SELECT title
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción --
SELECT title, description
FROM film
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. --
SELECT title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores. --
SELECT DISTINCT first_name
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.--
SELECT first_name, last_name
FROM actor
WHERE last_name = "Gibson";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%Gibson%";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. --
SELECT first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación --
SELECT title
FROM film
WHERE rating NOT IN ( "R" , "PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.--


SELECT COUNT(film_id) AS Count_by_rating, rating
FROM film
GROUP BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. --

SELECT customer_id, first_name, last_name, COUNT(rental_id) AS total_movies_rented
FROM customer
INNER JOIN rental
USING (customer_id)
GROUP BY customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. --

SELECT name , COUNT(rental_id) AS total_movies_rented_by_rating
FROM rental
INNER JOIN inventory
USING (inventory_id)
INNER JOIN film_category
USING (film_id)
INNER JOIN category
USING (category_id)
GROUP BY category_id;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.--

SELECT rating, AVG(length) AS average_length_films
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". -- 
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
INNER JOIN film
USING (film_id)
WHERE title = "Indian Love";

--  14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.--
SELECT title 
FROM film
WHERE description LIKE "%dog%" OR description LIKE "%cat%";

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor --

SELECT actor_id, fac.film_id 
FROM film_actor fac
LEFT JOIN film f
ON fac.film_id = f.film_id
WHERE fac.film_id IS NULL;



SELECT actor_id, fac.film_id 
FROM film_actor fac
LEFT JOIN film f
ON fac.film_id = f.film_id
WHERE fac.film_id IS NOT NULL;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. --
SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".--
SELECT title 
FROM film
INNER JOIN film_category
USING(film_id)
INNER JOIN category
USING(category_id)
WHERE name = "Family";

SELECT title 
 FROM film
 WHERE film_id IN (
	 SELECT film_id
     FROM film_category
     INNER JOIN category
     USING (category_id)
     WHERE name = 'family');
     
SELECT title 
 FROM film
 WHERE film_id IN (
	 SELECT film_id
     FROM film_category
	      WHERE category_id IN(
          SELECT category_id
          FROM category
          WHERE name = "Family"));
         
     
-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas --
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
GROUP BY actor_id
HAVING COUNT(film_id) > 10;

 -- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film. --
 SELECT title
 FROM film
 WHERE rating = "R" AND length > 120;
 
 -- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. --
 SELECT name, AVG(length) AS average_length
 FROM film
 INNER JOIN film_category
 USING (film_id)
 INNER JOIN category
 USING (category_id)
 GROUP BY name
 HAVING average_length > 120;
 
 -- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado. --
 
 SELECT first_name, COUNT(film_id) AS count_film
 FROM actor
 INNER JOIN film_actor
 USING (actor_id)
 GROUP BY actor_id
 HAVING COUNT(film_id) >= 5;
 
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. --
SELECT rental_id, DATEDIFF(return_date, rental_date) AS days
FROM rental 
WHERE DATEDIFF(return_date, rental_date) > 5;
 
 
 SELECT film_id, rental_id
 FROM inventory
 INNER JOIN rental
 USING (inventory_id)
 WHERE DATEDIFF(return_date, rental_date) >5;
 
 
 SELECT title
 FROM film
 WHERE film_id IN (
       SELECT film_id
       FROM inventory
       INNER JOIN rental
	   USING (inventory_id)
	   WHERE DATEDIFF(return_date, rental_date) >5);
       
       
-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores --
       
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
INNER JOIN film
USING (film_id)
INNER JOIN film_category
USING (film_id)
INNER JOIN category
USING (category_id)
WHERE name = "Horror";

SELECT first_name, last_name 
FROM actor
WHERE actor_id NOT IN (
	SELECT actor_id
    FROM film_actor
    INNER JOIN film_category
    USING (film_id)
    INNER JOIN category
    USING(category_id)
    WHERE name = 'Horror');
    





