use sakila;
DELIMITER //
CREATE PROCEDURE saludo()
BEGIN
	SELECT 'Hola clase de DAM' AS mesaje;
END //
DELIMITER ;

-- call saludo();
DROP PROCEDURE buscar_actor;
DELIMITER //
CREATE PROCEDURE buscar_actor(IN p_apellido VARCHAR(45))
BEGIN
	SELECT first_name, last_name FROM actor
	WHERE last_name LIKE CONCAT(p_apellido, '%');
END //
DELIMITER ;

CALL buscar_actor('jackman');
DELIMITER //
CREATE PROCEDURE contar_peliculas(OUT p_total INT)
BEGIN
	SELECT COUNT(*) INTO p_total FROM film;
END //
DELIMITER ;

CALL contar_peliculas(@resultado);

select @resultado;




DELIMITER $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);

	-- Para asignar a una variable un valor, se utiliza select into
     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END$$
DELIMITER ;


CALL `sakila`.`film_in_stock`(15, 2, @resultado);



DELIMITER //
CREATE FUNCTION calcular_iva(p_precio DECIMAL(10,2)) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN p_precio * 1.21;
END  //
DELIMITER ;

select calcular_iva(10);


call `sakila`.`film_in_stock`(15,2, @resultado);
select @resultado;
select calcular_iva(@resultado);


Select calcular_iva(amount) from payment;


DELIMITER $$
CREATE DEFINER=`admin`@`localhost` FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;

    
    

    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END$$
DELIMITER ;




select `sakila`.`inventory_in_stock`(5);



SElect store_id, count(inventory_id) as num_stock
from
inventory
join store using(store_id)
where
inventory_in_stock (inventory_id)
GROUP BY store_id;


select inventory_in_stock(select inventory_id from inventory);

