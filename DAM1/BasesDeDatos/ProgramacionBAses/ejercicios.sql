-- bloque 1(solo tengo hecho el primer ejercicio, disculpe las molestias por solo presentar uno)
DROP PROCEDURE ej1_alquiler_rapido;
DELIMITER //
CREATE PROCEDURE ej1_alquiler_rapido(
	IN p_customer_id INT,
    in p_inventory_id INT,
    IN p_staff_id INT)
BEGIN
	INSERT INTO `sakila`.`rental`
		(`rental_date`,
        `inventory_id`,
        `customer_id`,
        `staff_id`
        )
	VAlues
		(NOW(),
        p_inventory_id,
        p_customer_id,
        p_staff_id
        );
END //

DELIMITER ;

SELECT * FROM inventory;
call `ej1_alquiler_rapido`(
	-- customer_id, inventory_id, staff_id
    67,46,1
	);
Select * FROM rental where customer_id = 67 and inventory_id = 46 and staff_id = 1;
	
explain customer;
call `ej1_alquiler_rapido`(
	-- customer_id, inventory_id, staff_id
    (SELECT customer_id from customer where first_name like 'A%' limit 1),
    46,
    1
	);

select * from rental where customer_id = (Select customer_id from customer where first_name like 'A%' limit 1) and inventory_id = 46 and staff_id = 1;
-- ejercicio 2
explain store;
DELIMITER //

CREATE PROCEDURE ej2_cambio_staff(

)