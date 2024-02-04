-- 1. 
SELECT first_name, last_name FROM actor;

-- 2. 
SELECT CONCAT(first_name||' '||last_name) AS "Actor's name" FROM actor;

-- 3. 
SELECT actor_id, first_name, last_name FROM actor WHERE first_name LIKE 'JOE';

-- 4. 
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';
SELECT first_name, last_name FROM actor WHERE LOWER(last_name) LIKE LOWER('%GEN%'); --Esto te muestra los valores aunque esten en amyusucla o minuscula

-- 5. 
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name;

-- 6. 
SELECT first_name, last_name FROM customer WHERE first_name IN ('TERRY', 'JESSIE', 'ALICE');

-- 7. 
SELECT last_name, count(last_name) FROM actor GROUP BY last_name;

-- 8. 
SELECT last_name, count(last_name) FROM actor GROUP BY last_name HAVING count(last_name)>1;

-- 9. 
SELECT s.first_name, s.last_name, a.address FROM staff AS s  INNER JOIN address AS a  ON a.address_id = s.address_id;

SELECT s.first_name, s.last_name, a.address FROM staff AS s  NATURAL JOIN address AS a; --No se puede usar porque las dos tablas tienen dos atributos iguales(addres_id y last_update), tendria que ser solo uno.

-- 10. 
SELECT s.first_name,s.last_name, sum(p.amount) FROM payment AS p INNER JOIN staff AS s ON p.staff_id = s.staff_id WHERE payment_date BETWEEN '01-05-2022' AND '31-05-2022' GROUP BY first_name, last_name;

-- 11. 
SELECT f.title, count(fa.actor_id) FROM film AS f INNER JOIN film_actor AS fa ON f.film_id = fa.film_id GROUP BY f.title;

-- 12. 
SELECT f.title, count(i.inventory_id) FROM film AS f INNER JOIN inventory AS i ON f.film_id = i.film_id WHERE LOWER(f.title) = LOWER('Hunchback Impossible') GROUP BY f.title;

SELECT count(inventory_id) FROM inventory WHERE film_id IN (SELECT film_id FROM film WHERE LOWER(title) = LOWER('Hunchback Impossible')) GROUP BY film_id

-- 13. 
SELECT c.first_name, c.last_name, sum(p.amount), COUNT(payment_id) FROM payment AS p INNER JOIN customer AS c  ON p.customer_id = c.customer_id GROUP BY c.customer_id ORDER BY last_name ASC;

-- 14. 
SELECT c.first_name,c.last_name, c.email FROM customer AS c INNER JOIN address AS a ON c.address_id = a.address_id INNER JOIN city AS cy ON a.city_id = cy.city_id INNER JOIN country AS ct ON ct.country_id = cy.country_id WHERE LOWER(ct.country) = LOWER('Canada');

-- 15.
SELECT f.title FROM film AS f JOIN film_category AS fc ON fc.film_id = f.film_id INNER JOIN category AS c ON c.category_id = fc.category_id WHERE LOWER(c.name) = LOWER('Family');

-- 16. 
SELECT f.title, count(r.rental_id) AS numVeces FROM film AS f INNER JOIN inventory AS i ON i.film_id = f.film_id INNER JOIN rental AS r ON r.inventory_id = i.inventory_id GROUP BY f.title ORDER BY numVeces DESC;

-- 17.
SELECT s.store_id, SUM(amount) AS ganancias FROM store AS s INNER JOIN staff AS st ON s.store_id = st.staff_id INNER JOIN payment AS p ON st.staff_id = p.staff_id GROUP BY s.store_id;

-- 18. 
SELECT first_name, last_name FROM actor WHERE (first_name LIKE'%X%') OR (last_name LIKE '%X%');

-- 19. 
SELECT * FROM address AS a WHERE (a.district LIKE 'California') AND (a.phone LIKE'%274%');

-- 20. 
SELECT title FROM film WHERE (LOWER(description) LIKE LOWER('%brilliant%')) OR (LOWER(description) LIKE LOWER('%epic%')) AND length > 180;

-- 21. 
SELECT title, length FROM film  WHERE length BETWEEN 100 AND 120 OR length BETWEEN 50 AND 70;

-- 22. 
SELECT title FROM film  WHERE (rating = 'G' OR rating = 'R') AND (rental_rate = 0.99 OR rental_rate = 2.99) AND LOWER(description) LIKE LOWER('crocodiles');

-- 23. 
SELECT * FROM actor WHERE first_name LIKE 'SCARLETT';

-- 24.
SELECT first_name,last_name FROM actor WHERE LOWER(last_name) = LOWER('Johansson');

-- 25.
SELECT COUNT(DISTINCT last_name) FROM actor;

-- 26.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) = 1;

-- 27.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1;

-- 28.
SELECT COUNT(actor.actor_id) AS total, first_name, last_name FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id GROUP BY first_name, last_name ORDER BY total DESC LIMIT 1;
SELECT COUNT(actor.actor_id) AS total, first_name, last_name FROM actor left JOIN film_actor ON actor.actor_id = film_actor.actor_id GROUP BY first_name, last_name ORDER BY total DESC LIMIT 1; -- Ponemos LEFT JOIN para ver si hay actores en caso ed que hayan que no aparezcan en niguna película.

-- 29.
SELECT inventory.inventory_id, rental.return_date FROM film INNER JOIN inventory ON film.film_id=inventory.film_id INNER JOIN rental ON inventory.inventory_id = rental.inventory_id WHERE title = 'ACADEMY DINOSAUR' AND store_id = 1;
SELECT inventory.inventory_id FROM film INNER JOIN inventory ON film.film_id=inventory.film_id WHERE title = 'ACADEMY DINOSAUR' AND store_id = 1 AND EXISTS (SELECT rental_id FROM rental WHERE inventory.inventory_id = rental.inventory_id AND rental_duration IS NOT NULL);

-- 30.
INSERT INTO rental (rental_date,inventory_id,customer_id,return_date,staff_id) VALUES (now(), (SELECT inventory_id FROM inventory WHERE inventory.film_id IN (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR')LIMIT 1),(SELECT customer_id FROM customer WHERE first_name = 'MARY' AND last_name = 'SMITH'), NULL,(SELECT staff_id FROM staff WHERE first_name = 'Mike' AND last_name = 'Hillyer'));

-- 31.
SELECT rental_date, rental_duration, rental_date + interval '1' day * rental_duration AS due_date FROM rental INNER JOIN inventory ON (rental.inventory_id = inventory.inventory_id) INNER JOIN film ON (inventory.film_id = film.film_id) WHERE UPPER(title) = 'ACADEMY DINOSAUR';

-- 32.
SELECT AVG(length) FROM film;

-- 33.
SELECT category.name, trunc(AVG(film.length),5) FROM film INNER JOIN film_category ON film.film_id = film_category.film_id INNER JOIN category ON film_category.category_id = category.category_id GROUP BY category.name;

-- 34.
----- Porque el campo last_update de dos tablas al llamarse igual lo echa todo en el mismo contenedor por eso no podemos realizar esta consulta.
----- select * from film natural join inventory;

-- 35.
SELECT name FROM language ORDER BY name;

-- 36.
SELECT CONCAT(first_name,' ',last_name) AS "full name" FROM actor WHERE LOWER(last_name) LIKE LOWER('%SON%') ORDER BY first_name;

-- 37.
SELECT address, address2 FROM address WHERE (address2 IS NOT NULL) ORDER BY address2;
SELECT address, address2 FROM address WHERE (address2 != NULL) ORDER BY address2;

-- 38.
SELECT actor.first_name, actor.last_name, film.title, film.release_year FROM actor INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id INNER JOIN film ON film.film_id = film_actor.film_id WHERE( LOWER(film.description) LIKE LOWER('%SHARK%') AND LOWER(film.description) LIKE LOWER('%CROCODILE%')) ORDER BY last_name;
SELECT  title,description FROM film WHERE( LOWER(description) LIKE LOWER('%SHARK%') AND LOWER(description) LIKE LOWER('%CROCODILE%'));

-- 39.
SELECT category.name, COUNT(film_category.film_id) FROM category INNER JOIN film_category ON film_category.category_id = category.category_id GROUP BY category.name HAVING (COUNT(film_category.film_id) BETWEEN 55 AND 65);

-- 40.
SELECT COUNT(*) FROM (SELECT category.name, AVG(film.replacement_cost-film.rental_rate) FROM category INNER JOIN film_category ON film_category.category_id=category.category_id INNER JOIN film ON film.film_id=film_category.film_id GROUP BY category.name HAVING (AVG(film.replacement_cost-film.rental_rate)) >=17) AS "Results";
 
-- 41.


-- 42.
SELECT a1.first_name, a1.last_name FROM actor AS a1 INNER JOIN customer AS a2 ON (a1.first_name=a2.first_name) WHERE (a1.first_name=a2.first_name) AND (a2.last_name!=8);

SELECT first_name, last_name FROM actor WHERE first_name = (SELECT first_name FROM actor WHERE actor_id = 8) AND actor_id <> 8 UNION SELECT first_name, last_name FROM customer WHERE first_name = (SELECT first_name FROM actor WHERE actor_id = 8);
SELECT acto.first_name, actor.last_name, customer.last_name FROM actor INNER JOIN customer ON (actor.first_name = customer.first_name) WHERE actor.first_name = (SELECT first_name FROM actor WHERE actor_id = 8) AND actor_id <> 8;







-- OTHER EXCERCISES --

-- 1. SELECT statements

-- 1a. 
SELECT * FROM actor;
-- 1b. 
SELECT last_name FROM actor;
-- 1c. 
SELECT title, description, rental_duration, rental_rate, rental_duration * rental_rate AS total_rental_cost FROM film;     


-- 2. DISTINCT operator

-- 2a. 
SELECT DISTINCT last_name FROM actor;
-- 2b. 
SELECT DISTINCT postal_code FROM address;
-- 2c. 
SELECT DISTINCT rating FROM film;


-- 3. WHERE clause

-- 3a. 
SELECT title, description, rating, length FROM film WHERE length >= 180;
-- 3b. 
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date BETWEEN  '2005-05-27 00:00:00' AND '2005-05-27 23:59:59'; DUDA
-- 3c. 
SELECT primary key, amount, payment_date FROM payment; DUDA
-- 3d. 
SELECT * FROM customer WHERE (last_name LIKE 'S%') AND (first_name LIKE '%N');
-- 3e. 
SELECT * FROM customer WHERE active = 0 OR (last_name LIKE '%M');
-- 3f. 
SELECT * FROM category WHERE category_id > 4 AND name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%';
--     SELECT * FROM category WHERE category_id > 4 AND name SIMILAR TO ('(C|S|T)%';
-- 3g. 
SELECT staff_id, first_name, last_name, email, store_id, active, username, last_update, picture FROM staff WHERE password IS NOT NULL;
-- 3h. 
SELECT staff_id, first_name, last_name, email, store_id, active, username, last_update, picture FROM staff WHERE password IS NULL;


-- 4. IN operator

-- 4a. 
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');
-- 4b. 
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date IN ('2005-05-25','2005-05-27','2005-05-29')
-- 4c. 
SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17');


-- 5. BETWEEN operator

-- SELECT NOW() - interval '1 second';
-- 5a. 
SELECT * FROM payment WHERE payment_date BETWEEN '2022-05-25 23:59:59.9' AND '2022-05-26 00:00:00.0';
-- 5b. 
SELECT title, description, release_year, rental_duration * rental_rate AS total_rental_cost FROM film WHERE length(description) BETWEEN 100 AND 120;


-- 6. LIKE operator

-- 6a. 
SELECT title, description, release_year FROM film WHERE description LIKE 'A Thoughtful%';
-- 6b. 
SELECT title, description, rental_duration FROM film WHERE description LIKE '%Boat';
-- 6c. 
SELECT title,length, description, rental_rate FROM film WHERE description LIKE '%Database%' AND length >= 180;


-- 7. LIMIT operator

-- 7a. 
SELECT * FROM payment LIMIT 20;
-- 7b. 
SELECT payment_id, payment_date, amount FROM payment WHERE amount > 5 ORDER BY amount DESC LIMIT 50 OFFSET 50;
-- 7c. 
SELECT * FROM customer LIMIT 100 OFFSET 100;


-- 8. ORDER BY statement

-- 8a. 
SELECT * FROM film ORDER BY length ASC;
-- 8b. 
SELECT DISTINCT rating FROM film ORDER BY rating DESC;
-- 8c. 
SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20; 
-- 8d. 
SELECT title, description, special_features , length, rental_duration FROM film WHERE 'Behind the Scenes' = ANY (special_features) AND length < 120 AND rental_duration BETWEEN 5 AND 7 ORDER BY length DESC LIMIT 10;
-- SELECT title, description, special_features , length, rental_duration FROM film WHERE 'Behind the Scenes' = ALL (special_features) AND CARDINALITY(special_features) = 1;;


-- 9. JOINS

-- 9a. 
SELECT customer.first_name,customer.last_name,actor.first_name, actor.last_name FROM customer LEFT JOIN actor ON customer.last_name = actor.last_name;
-- 9b. 
SELECT actor.first_name, actor.last_name,customer.first_name,customer.last_name FROM customer RIGHT JOIN actor ON customer.last_name = actor.last_name; 
-- 9c. 
SELECT actor.first_name, actor.last_name,customer.first_name,customer.last_name FROM customer INNER JOIN actor ON customer.last_name = actor.last_name; 
-- 9d. 
SELECT city.country.country FROM city LEFT JOIN country ON city.country_id = country.country_id;
-- 9e.
SELECT title,description,release_year,language.name FROM film LEFT JOIN language ON film.language_id = language.language_id;
-- 9f. 
SELECT first_name,last_name, address.address,address2,city.city,district,postal_code FROM staff LEFT JOIN address ON staff.address_id = address.address_id LEFT JOIN city ON address.city_id = city.city_id;