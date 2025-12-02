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
    
    
    
    
    
Select category_id, count(film_id) as film_counts from film_category group by category_id;

select name, category_counts.film_counts from (select category_id, count(film_id) as film_counts from film_category group by category_id) as category_counts
join category using(category_id);