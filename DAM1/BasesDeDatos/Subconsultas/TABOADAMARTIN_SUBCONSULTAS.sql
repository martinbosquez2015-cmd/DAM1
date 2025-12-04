use sakila;

SELECT 
    title
FROM
    film
WHERE
    language_id = (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'English');

SELECT 
    title
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);
            
		
        
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'ALONE TRIP'));
                    
                    


SELECT 
    title, length
FROM
    film
WHERE
    length > ANY (SELECT 
            length
        FROM
            film
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film_category
                WHERE
                    category_id = (SELECT 
                            category_id
                        FROM
                            category
                        WHERE
                            name = 'sports')));
                            
                            
                            


SELECT 
    title, length
FROM
    film
WHERE
    length > ALL (SELECT 
            length
        FROM
            film
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film_category
                WHERE
                    category_id = (SELECT 
                            category_id
                        FROM
                            category
                        WHERE
                            name = 'sports')));
                            
                            
					
SELECT 
    first_name, last_name
FROM
    customer AS c
WHERE
    EXISTS( SELECT 
            1
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id);
            
            
            

SELECT 
    title
FROM
    film
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            inventory
                JOIN
            rental USING (inventory_id)
        WHERE
            inventory.film_id = film.film_id);
            
            
            
		

SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'children'));
                    
                    



-- Select
SELECT 
    title,
    (SELECT 
            COUNT(*)
        FROM
            rental
                JOIN
            inventory USING (inventory_id)
        WHERE
            inventory.film_id = film.film_id) AS total_rentals
FROM
    film;
    
    
SELECT 
    first_name,
    last_name,
    (SELECT 
            SUM(amount)
        FROM
            payment
        WHERE
            customer.customer_id = payment.customer_id) AS total_amount
FROM
    customer;



SELECT 
    name, film_counts
FROM
    (SELECT 
        category_id, COUNT(film_id) AS film_counts
    FROM
        film_category
    GROUP BY category_id) AS category_counts
        JOIN
    category USING (category_id)
WHERE
    category_counts.film_counts > (SELECT 
            AVG(film_counts)
        FROM
            (SELECT 
                category_id, COUNT(film_id) AS film_counts
            FROM
                film_category
            GROUP BY category_id) as category_counts2);
            
            
-- 2.1 
	-- Peliculas de la categoría "Children"
SELECT 
    film_id, title
FROM
    film
        JOIN
    film_category USING (film_id)
WHERE
    category_id = (SELECT 
            category_id
        FROM
            category
        WHERE
            name = 'Children');

	-- Películas nunca alquiladas
Select film_id, title from film as f1;


SELECT 
    f.film_id, f.title
FROM
    film AS f
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            inventory AS i
                JOIN
            rental USING (inventory_id)
        WHERE
            f.film_id = i.film_id);



SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    EXISTS( SELECT 
            1
        FROM
            film_actor
                JOIN
            film USING (film_id)
        WHERE
            length > 120
                AND film_actor.actor_id = actor.actor_id);

-- 4 
	-- Ejercicio 1
    SELECT 
    film_id, title, length
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film);
	-- Ejercicio 2
    SELECT 
    actor_id, CONCAT(first_name,' ',  last_name) AS actor
FROM
    actor
WHERE
    EXISTS( SELECT 
            1
        FROM
            film_actor
                JOIN
            film USING (film_id)
                JOIN
            film_category USING (film_id)
        WHERE
            category_id = (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Action')
                AND film_actor.actor_id = actor.actor_id)
        AND EXISTS( SELECT 
            1
        FROM
            film_actor
                JOIN
            film_category USING (film_id)
                JOIN
            category USING (category_id)
        WHERE
            name = 'Comedy'
                AND film_actor.actor_id = actor.actor_id)
ORDER BY actor.last_name , actor.first_name;