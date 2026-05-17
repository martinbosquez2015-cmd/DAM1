-- PROGRAMACIÓN CON BASES DE DATOS ALV
-- BLOQUE 1 PROCEDIMIENTOS ALMACENADOS
-- Alquiler rápido
use sakila;
explain rental;
DELIMITER //
CREATE PROCEDURE rental_inserts(IN p_customer_id INT, p_inventory_id INT, p_staff_id INT)
BEGIN
	INSERT INTO rental(rental_date, inventory_id, customer_id, staff_id) 
    VALUES (NOW(), p_inventory_id, p_customer_id, p_staff_id);
END //
DELIMITER ;

select * from rental where customer_id=1;

CALL rental_inserts(1,2,2);
-- 2. Cierre de tienda
-- Mi procedimietno no sirve si es que en la base de datos existe una tienda más
Select * from store;
SELECT * FROM staff;

DELIMITER //
CREATE PROCEDURE cierre_tienda(IN p_store_id INT)
BEGIN
	UPDATE staff
    SET store_id = (SELECT store_id from store where store_id not in(p_store_id))
    where store_id = p_store_id;
END //
DELIMITER ;
CALL cierre_tienda(1);

-- 3. Estadísticas de actor
Select * from film ;
Select * from film 
JOIN film_actor USING(film_id)
JOIN actor USING(actor_id);
Select actor_id, CONCAT(first_name, last_name), COUNT(film_id) as cant_pelis, ROUND(AVG(length),2) as dur_media from actor 
JOIN film_actor USING(actor_id)
JOIN film USING(film_id)
WHERE actor_id=1
GROUP BY actor_id;
-- having actor_id=1;

DELIMITER // 
CREATE PROCEDURE actor_stats(IN p_actor_id INT, OUT n_peliculas INT , OUT avg_length DECIMAL(10,2))
BEGIN
	SELECT COUNT(film_id), ROUND(AVG(length),2) INTO n_peliculas,   avg_length
    FROM actor
    JOIN film_actor USING(actor_id)
    JOIN film USING(film_id)
    WHERE actor_id=p_actor_id
    GROUP BY actor_id;
END //
DELIMITER ;
CALL actor_stats(2, @si,@no);
-- SELECT actor_id, concat(first_name,' ',last_name) as name, @si, @no from actor where actor_id=2
-- Esa consulta fue pro probar, en la realidad el select ultimo que hice no tiene mucha lógica si no va de la mano con el id que mando al procedimiento


-- BLOQUE 2: FUNCIONES DE USUARIO
-- 1. Cálculo de multas
explain rental;
-- FAlta acabar esta funcion para que te borre las rentas devueltas
DROP FUNCTION if exists calcular_multa;
DELIMITER //
CREATE FUNCTION calcular_multa(f_rental_id INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE dias_multa INT;
    DECLARE multa DECIMAL(10,2) DEFAULT 1.50;
    DECLARE dia_devuelto DATETIME DEFAULT NULL;
    DECLARE multa_total DECIMAL(10,2) DEFAULT 0;
    SELECT DATEDIFF(NOW(), rental_date), return_date INTO dias_multa, dia_devuelto
    FROM rental 
    WHERE rental_id=f_rental_id;
    IF (dia_devuelto IS NOT NULL) THEN
		SET multa_total = dias_multa*multa;
	END IF;
    RETURN multa_total;
END //
DELIMITER ;
select * from rental where return_date is null;
SELECT rental_id, calcular_multa(rental_id) as multa FROM rental;
-- mejora de la funcion 
DROP FUNCTION IF EXISTS calcular_multa_mejorado;
DELIMITER //
CREATE FUNCTION calcular_multa_mejorado(f_rental_id INT)
RETURNS DECIMAL(10,2) 
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE dias_permitidos INT DEFAULT 5;
    DECLARE dias_totales INT;
    DECLARE dias_contados INT;
	DECLARE multa_total DECIMAL(10,2) DEFAULT 0;
    DECLARE fecha_devolucion DATETIME DEFAULT NULL;
    SELECT return_date INTO fecha_devolucion FROM rental where rental_id=f_rental_id;
    IF fecha_devolucion IS NOT NULL THEN
		SELECT DATEDIFF(fecha_devolucion, rental_date) INTO dias_totales FROM rental where rental_id=f_rental_id;
	else
		SELECT DATEDIFF(NOW(), rental_date) INTO dias_totales fROM rental where rental_id=f_rental_id;
	END IF;
    IF dias_totales>dias_permitidos THEN
		SET dias_contados = dias_totales - dias_permitidos;
        SET multa_total = dias_contados*1.50;
	END IF;
    RETURN multa_total;
END //
DELIMITER ;

SELECT rental_id, calcular_multa_mejorado(rental_id) as multa FROM rental having multa !=0;
Select *

