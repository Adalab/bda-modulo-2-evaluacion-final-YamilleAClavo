
-- Usamos el Schema Sakila --
USE sakila;



-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. --
-- Necesitamos el titulo (title) de todas las películas, como pide que no estén duplicados usamos DISTINCT, la tabla que usamos en este caso es film--

SELECT DISTINCT title
FROM film;


-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13" --
-- Necesitamos los nombres de todas las películas, title, de la tabla film, en la cual su clasficiación (rating) tenga una condicion que es que sea igual a PG-13, por lo que usamos WHERE--

SELECT title
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción --
-- En este caso nos pide el titulo (title) y la descripción (description) de la tabla film, con la condición de que en la descripcion aparezca la palabra "amazing", por lo que usamos WHERE...LIKE, y al decir que aparezca usamos %amazing%. --

SELECT title, description
FROM film
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. --
-- Estamos buscando el titulo de todas las peliculas y en este caso la condición es que tengan una duración mayor a 120 minutos, para lo que usamos WHERE con la colulmna longitud(length) y el comparativo > mayor que.--

SELECT title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores. --
-- En este caso pide el nombre de todos los actores para lo que usamos first_name, en este caso uso DISTINCT para que no se repitan los nombres y usamos la tabla actor.--

SELECT DISTINCT first_name
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.--
-- Estamos buscando el nombre, first_name, y el apellido, last_name, de la tabla actor, y la condición es que tenga la palabra "Gibson" en su apellido.--
-- En la primera opción para la condición uso WHERE ... = "Gibson", ya que entiendo que el apellido es Gibson.--

SELECT first_name, last_name
FROM actor
WHERE last_name = "Gibson";

-- Por si acaso se refiere a que contenga "Gibson" en el apellido uso WHERE... LIKE y para que contenga %Gibson%. Aunque el resultado final es el mismo.--
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%Gibson%";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. --
-- Estamos buscando el nombre, first_name, de la tabla actor, donde el actor_id tenga una condición, WHERE , que es que esté entre 10 y 20 para ello usamos BETWEEN.--

SELECT first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación --
-- Buscamos el titulo, title, de la tabla film, en la que la condición sea que su clasificación, rating, no sea ni R ni PG-13, para lo que usamos WHERE...NOT IN.--

SELECT title
FROM film
WHERE rating NOT IN ( "R" , "PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.--
-- Tenemos que encontrar y mostrar la cantidad total de películas , COUNT(film_id),en cada clasificación, GROUP BY rating, dentro de la tabla film.--

SELECT COUNT(film_id) AS Count_by_rating, rating
FROM film
GROUP BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. --
-- Para este ejercicio necesitamos usar dos tablas, customer y rental, por lo que hago uso del INNER JOIN, estas dos tablas están relacionadas por customer_id.--
-- Nos están pidiendo mostrar el customer_id, first_name, last_name y encontrar y mostrar la cantidad de peliculas alquiladas, COUNT(rental_id), por cada cliente, GROUP BY customer_id.--

SELECT customer_id, first_name, last_name, COUNT(rental_id) AS total_movies_rented
FROM customer
INNER JOIN rental
USING (customer_id)
GROUP BY customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. --
-- En este caso nos pide mostar el nombre, name, de la categoria, junto con el recuento de alquileres, COUNT(rental_id), por categoria por que uso GROUP BY category_id.--
-- He optado por usar INNER JOIN para acceder a las diferentes tablas, ya que se necesita acceder al rental_id de la tabla rental, a category_id y name de la tabla category que no están comunicadas directamente.--


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
-- Para encontrar el promedio de duración accedemos a la tabla film y usamos AVG(length) y los agrupamos GROUP BY rating, y mostramos el promedio junto con la clasificación, rating.--

SELECT rating, AVG(length) AS average_length_films
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". -- 
-- Buscamos el nombre, first_name, y apellido, last_name, que aparecen en la tabla actor, de los actores que aparecen en la pelicula Indian Love, es decir que el title de la tabla film sea Indian Love, para lo que usamos WHERE.--
-- Para esto uso INNER JOIN ya que la tabla actor y la tabla film se unen a través de la tabla film_actor y el actor_id y el film_id.--

SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
INNER JOIN film
USING (film_id)
WHERE title = "Indian Love";

--  14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.--
-- Necesitamos el title de la tabla film donde la condición, WHERE, es que aparezcan las palabras dog o cat en su descripcion, description, para lo que uso LIKE %dog% OR LIKE %cat%.--

SELECT title 
FROM film
WHERE description LIKE "%dog%" OR description LIKE "%cat%";

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor --
-- En este caso nos hace una pregunta y no pide que mostremos nada concreto, por lo que elijo mostrar el actor_id ya que es único para cada actor, de la tabla film_actor, y el film_id que es único para cada pelicula, y aparece en las tablas film_actor y film.--
-- Como pide que no aparezca en ninguna pelicula usaré LEFT JOIN que no elimina cuando los registros son NULL.--
-- La condición que usaré será WHERE...IS NULL.--
-- En este caso no hay ningún actor o actriz que no aparezca en ninguna película.--

SELECT actor_id, fac.film_id 
FROM film_actor fac
LEFT JOIN film f
ON fac.film_id = f.film_id
WHERE fac.film_id IS NULL;


-- Para comprobar que lo estoy haciendo bien, hago lo mismo pero con la condición WHERE... IS NOT NULL.--

SELECT actor_id, fac.film_id 
FROM film_actor fac
LEFT JOIN film f
ON fac.film_id = f.film_id
WHERE fac.film_id IS NOT NULL;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. --
-- Estamos buscando el title de la tabla film donde la condición WHERE, es que fueran lanzadas, release_year, entre los años 2005 y 2010 para lo que uso BETWEEN.--

SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".--
-- Mostramos el title de la tabla film, de todas las películas que son de la categoría, name, Family de la tabla category_id, para lo que usamos WHERE.--
-- Estamos usando INNER JOIN ya que necesitamos información tanto de la tabla film como de la tabla category y como no están unidas directamente usamos la tabla film_category que las une.--

SELECT title 
FROM film
INNER JOIN film_category
USING(film_id)
INNER JOIN category
USING(category_id)
WHERE name = "Family";
-- Convierto el primer INNER JOIN en una subquery.--
SELECT title 
 FROM film
 WHERE film_id IN (
	 SELECT film_id
     FROM film_category
     INNER JOIN category
     USING (category_id)
     WHERE name = 'family');
-- Convierto el segundo INNER JOIN también en una subquery.--
-- Esta sería la query final.--     
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
-- Necesitamos first_name y last_name de la tabla actor--
-- Como pide que aparezcan en más de 10 películas usamos INNER JOIN con el actor_id de la tabla film_actor, para unir ambas tablas.--
-- Agrupamos por GROUP BY actor_id para saber qué actores aparecen en más de 10 películas, usando para esto HAVING(ya que es un filtro de grupo y se usa para funciones agragadas como COUNT) COUNT del film_id, y que sea mayor (>) a 10.--
SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING (actor_id)
GROUP BY actor_id
HAVING COUNT(film_id) > 10;

 -- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film. --
 -- Aquí necesitamos el title de la tabla film, y las condiciones son que las películas pertenecen a la clasificación R y que duren más de 2 horas (120 minutos), para lo que usamos WHERE...AND.--
 
 
 SELECT title
 FROM film
 WHERE rating = "R" AND length > 120;
 
 -- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. --
 -- Necestiamos mostrar el name de la categoria y el promedio de la duración, para esto usamos AVG(length).--
 -- La duración la tenemos en la tabla film, mientras que la categoría está en la tabla category, para lo que usamos INNER JOIN para unir estas tablas, pero necesitamos un INNER JOIN intermedio ya que estas dos tablas no se comunican directamente, y lo hacen por medio de la tabla film_category.--
 -- Agrupamos con GROUP BY por la categoría, name, para poder mostrar solo las películas que tienen un promedio superior a 120 minutos, usando HAVING.--
 
 SELECT name, AVG(length) AS average_length
 FROM film
 INNER JOIN film_category
 USING (film_id)
 INNER JOIN category
 USING (category_id)
 GROUP BY name
 HAVING average_length > 120;
 
 -- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado. --
 -- Necesitamos mostar el first_name de la tabla actor, y la cantidad COUNT(film_id) de películas en las que han actuado estos actores de la tabla film_actor.--
 -- Para ello usamos INNER JOIN, para unir la tabla actor y film_actor y agrupamos, GROUP BY, por el actor_id para saber que actores han participado en 5 o más peliculas (>=), usando HAVING.--
 
 
 SELECT first_name, COUNT(film_id) AS count_film
 FROM actor
 INNER JOIN film_actor
 USING (actor_id)
 GROUP BY actor_id
 HAVING COUNT(film_id) >= 5;
 
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. --
-- En este caso nos piden usar una subquery.--
-- Primero veo como saber la diferencia entre dos fechas, para eso uso DATEDIFF, y además quiero ver el rental_id, todo de la tabla rental, donde la condición WHERE es que hayan sido alquiladas por más de 5 días.--
SELECT rental_id, DATEDIFF(return_date, rental_date) AS days
FROM rental 
WHERE DATEDIFF(return_date, rental_date) > 5;

-- Despues usando un INNER JOIN relaciono las tablas inventory y rental.-- 
 
 SELECT film_id, rental_id
 FROM inventory
 INNER JOIN rental
 USING (inventory_id)
 WHERE DATEDIFF(return_date, rental_date) >5;
 
 -- Más tarde hago la primera subquery, añadiendole a está el INNER JOIN anterior.--
 SELECT title
 FROM film
 WHERE film_id IN (
       SELECT film_id
       FROM inventory
       INNER JOIN rental
	   USING (inventory_id)
	   WHERE DATEDIFF(return_date, rental_date) >5);

-- Por último realizo una segunda subquery con el segundo INNER JOIN, siendo este el resultado final.--       
SELECT title
FROM film
WHERE film_id IN (
      SELECT film_id
      FROM inventory
      WHERE inventory_id IN (
           SELECT inventory_id
           FROM rental
           WHERE DATEDIFf(return_date, rental_date) > 5));
       
       
-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores --
       


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
    
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
      SELECT actor_id
      FROM film_actor
      WHERE film_id IN (
            SELECT film_id
			FROM film_category
            INNER JOIN category
			USING (category_id)
            WHERE name = "Horror"));
      
SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
      SELECT actor_id
      FROM film_actor
      WHERE film_id IN(
            SELECT film_id
            FROM film_category
            WHERE category_id IN (
                  SELECT category_id
                  FROM category
                  WHERE name = "Horror")));
    





