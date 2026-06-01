-- Apuntes y trabajo sobre la base de datos de logìstica global alv
use logistica_global;
-- vamos a sanear toda esta pinche tabla alv
-- primero vamos a por la tabal de almacendes:
	SELECT * FROM almacenes;
    SELECT cod_almacen, COUNT(*) FROM almacenes GROUP BY cod_almacen having count(*)>1;
    SELECT * FROM almacenes where cod_almacen IN(SELECT cod_almacen FROM almacenes GROUP BY cod_almacen HAVING COUNT(*)>1);
		-- codigos de prueba 
        SELECT * from almacenes a1 join almacenes a2 on a1.cod_almacen = a2.cod_almacen and a1.id=a2.id;
    -- vamos a por codigos de almacén:
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
    UPDATE almacenes SET cod_almacen =TRIM(REPLACE(cod_almacen, '_',''));