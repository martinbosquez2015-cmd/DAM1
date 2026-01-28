 -- Examen Martín Taboada
 
 use sakila;
 
-- 1. Obtener para cada idioma, cuántas películas tienen rating 'R'.

SELECT 
    l.language_id,
    l.name,
    (SELECT 
            COUNT(1)
        FROM
            film AS f
        WHERE
            f.language_id = l.language_id
                AND f.rating = 'R'
        GROUP BY (f.language_id)) AS fims_per_language
FROM
    language AS l;

-- 2. El **encargado de atención al cliente** quiere un listado de *todos* los clientes registrados en el almacén 1 y el número de alquileres que han hecho, incluyendo clientes sin alquileres

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) as name,
    (SELECT 
            COUNT(1)
        FROM
            rental AS r
        WHERE
            r.customer_id = c.customer_id
        GROUP BY r.customer_id) AS rentals_per_customer
FROM
    customer AS c
WHERE
    c.store_id = 1;

-- 3. El **gerente de la tienda** desea conocer qué clientes han realizado alquileres de películas, sin incluir a aquellos que no han alquilado nada.

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS name
FROM
    customer AS c
WHERE
    EXISTS( SELECT 
            1
        FROM
            rental AS r
        WHERE
            c.customer_id = r.customer_id)
        AND c.store_id = 1;
    
-- 4. Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).

SELECT 
    c.category_id, c.name, AVG(f_length.fl) AS average_length
FROM
    (SELECT 
        f.length AS fl, f.film_id AS id
    FROM
        film AS f
    JOIN inventory AS i ON f.film_id = i.film_id
    JOIN rental USING (inventory_id)) AS f_length
        JOIN
    film_category AS fc ON f_length.id = fc.film_id
        JOIN
    category AS c USING (category_id)
GROUP BY category_id;
    
-- 5. Obtener para cada país la suma de los pagos (amount) realizados en 2005.
    
SELECT 
    c.country_id,
    c.country,
    (SELECT 
            SUM(amount)
        FROM
            payment AS p
                JOIN
            staff AS s USING (staff_id)
                JOIN
            address AS a USING (address_id)
                JOIN
            city AS cy USING (city_id)
        WHERE
            cy.country_id = c.country_id
                AND YEAR(p.payment_date) = 2005) AS amount_per_country
FROM
    country AS c; 
    