use erp_logistica;

/* Estudiamos la BD*/
show tables;
select * from categorias;
select * from clientes;
explain clientes;
select * from pedidos;

/* 1) Limpia los espacios en blanco*/
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET nombre_completo = TRIM(nombre_completo);
select * from clientes;
SET SQL_SAFE_UPDATES = 1;

/* ERROR:*/
/*en la parte del trim, poner nombre completo entre comillas, esto hace que te cargues la base de datos*/


/* 2)
 2.1) Miro a ver que está mal*/
 select * from clientes;
/* 2.2) Corrijo*/
/* UPDATE clientes SET email = REPLACE (email, '.con','.com');*/
/*gomez.conrado@gmail.con -> gomez.comrado@gmail.com  ¡ERROR!*/
/*UPDATE clientes SET email = REPLACE (email, '.con','.com') WHERE email LIKE '%.con';
  Esta opción de aquí también está mal, porque sucede lo mismo que antes
  SOLUCIONES
  1) Parto el email en el 0 y luego concateno de vuelta. [Solucion muy buena y muy general]alter
  2) Solucionválida para el ejemplo 2 de clase que tiene pocos datos. */
select email from clientes where email like '%.con';
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET email = REPLACE (email, 'email.con','email.com') WHERE email LIKE '%.con';
UPDATE clientes SET email = REPLACE (email, 'outlook.con','outlook.com') WHERE email LIKE '%.con';
SET SQL_SAFE_UPDATES = 1;
/*3) Comprobamos:*/
select * from clientes;


SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET email = REPLACE (email, ',','.');
SET SQL_SAFE_UPDATES = 1;

-- 2.3) Compruebo
select * from clientes;

/* Arreglar los telefonos*/
/* 3.1) Comprobamos que está fatal
   3.2) VAmos poco a poco.*/
   SELECT telefono FROM clientes WHERE telefono LIKE '0034%';
   /*PLAN A:*/
   UPDATE clientes SET telefono = REPLACE(telefono, ' ','');
   UPDATE clientes SET telefono = REPLACE(telefono,'-','');
   /*PLAN B:*/
   UPDATE clientes SET telefono = 
		REPLACE(
			REPLACE(
				REPLACE(
					REPLACE(
						REPLACE(telefono,'-','')
					,' ','')
				,'+34','')
			,'0034','')
		,'0034','') WHERE telefono LIKE '0034%';/*Tambien puede haber un problema con este último replace, que puede que cone l 0034 te haga un match donde el nuemero tiene un 0034 en otra parte del
        número, lo cual generaría un problema gordo, pero habiendo observado los valores del teléfono que tienen esa característica del 0034 solo hay un teléfono así
		y que no tiene otro 0034 en el mismo, por lo que hacer este update en este caso no generaría problemas. Sin embargo es mejor este que se escribirá a continuación*/
        select SUBSTRING('003465003457',5,9);
        UPDATE clientes SET telefono = SUBSTRING(telefono,5,9) WHERE telefono LIKE '0034%';
        /*A priori el plan B es el mejor, por rapidez y por evitar que en medio hacer la segunda orden de la primera se aya la luz*/
   
   /*PROTECCION ANTE DESASTRES: (se va la luz, he puesto el mismo nombre en todos los clientes)*/
   /* 2 formas de protección Stagin y transacciones.
		1. Stagging: crear una tabla o columnta temporal, rellenarla con los datos limpios y luego sustituir la columna inicial.*/
	SELECT * from clientes;
    explain clientes;
    ALTER TABLE clientes
		ADD COLUMN telefono_en_proceso VARCHAR(20);
	/*Voy actualizando*/
    SET SQL_SAFE_UPDATES=0;
    UPDATE clientes set telefono_en_proceso = REPLACE(telefono,' ','');
    UPDATE clientes set telefono_en_proceso = REPLACE(telefono,'-','');
    UPDATE clientes set telefono_en_proceso = REPLACE(telefono,'0034','');
	SELECT telefono_en_proceso from clientes where telefono_en_proceso like'0034%';
	UPDATE clientes SET telefono_en_proceso = SUBSTRING(telefono_en_proceso,5,9) WHERE telefono_en_proceso like '0034%';
		/*Ahora quue tengo todos los cambios en sucio, comprobamos y pasamos a limpio*/
        select  * from clientes;
        /*Paso a limpio:*/
        UPDATE clientes SET telefono = telefono_en_proceso;
        
        ALTER TABLE clientes
			DROP COLUMN telefono_en_proceso; /*Eliminamos la tabla en sucio*/
            
		SET SQL_Safe_updates = 1;
        Select * from clientes;
	/*2. PROTECCION2: transacciones*/
	START TRANSACTION;/*A partir de ahora, todos los cambios son TEMPORALES hasta que se deshagan(rollback) o se confirmen(commit)*/
    /*vuelvo a cargar los telefonos*/
    select * from clientes;
    /*Empiezo a corregir cosas.*/
    SET SQL_sAFE_UPDATES = 0;
    UPDATE clientes SET teledono = REPLACE(telefono, ' ', '');
    select * from clientes;
    SET SQL_SAFE_UPDATES = 1;
    SELECT * from clientes;
    /*Cierra y vuelve a abrir*/
    /*EJEMPLO 2
    */
    SET SQL_SET_UPDATES = 0;
    UPDATE clientes SET telefono = REPLACE(telefono,'-','');/*cambio DEFINITIVO*/
    select * from clientes;
    START TRANSACTION;/*A partir de ahora todos los cambios son TEMPORALES y blah blah blah*/
    UPDATE clientes SET telefono = REPLACE(telefono,'-','');/*TEMPORAL*/
    UPDATE clientes SET telefono = REPLACE(telefono,'+34','');/*TEMPORAL*/
    UPDATE clientes SET telefono = REPLACE(telefono,'0034','?');/*TEMPORAL*/
    select * from clientes;
    SET SQL_SET_UPDATES = 1;
    ROLLBACK;
    select * FROM clientes; /*NO HAY ESPACIOS, PERO SI GUIONES*/
    
    /*EJEMPLO 3:  tenemos guiones, pero no espacios.*/
    START TRANSACTION;
    SET SQL_SET_UPDATES = 0;
    UPDATE clientes SET telefono = REPLACE(telefono,'-','');/*TEMPORAL*/
    UPDATE clientes SET telefono = REPLACE(telefono,'+34','');/*TEMPORAL*/
    UPDATE clientes SET telefono = SUBSTRING(telefono,5,9) WHERE telefono like '0034%';/*TEMPORAL*/
    select * from clientes;
    COMMIT; /*LO MARCAMOS COMO CAMBIOS DEFINITIVOS*/
    SET SQL_SET_UPDATES = 1;