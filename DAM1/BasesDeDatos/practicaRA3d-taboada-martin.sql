use sakila;
-- Consulta 1: Clientes con al menos un alquiler
SELECT distinct(customer_id), concat(first_name,' ',last_name) as customers_name FROM customer left join rental using(customer_id)
where rental_id is not null;

-- Consulta 2: Todos los clientes y sus alquileres
select customer_id, concat(first_name,' ', last_name) as customers_name, count(rental_id) as number_rentals
from rental
right join customer using(customer_id)
group by customer_id;

-- Consulta 3: Actores y sus películas
select actor_id, concat from actor 
left join film_actor using(actor_id;

-- Consulta 4: Categorías y películas


-- Consulta 5: Películas y sus actores

