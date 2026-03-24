use erp_logistica;
show tables;
select * from clientes;

-- 2.1. BLOQUE 1: Lmpieza de Cadenas
-- 2.1.1. Espacios residuales
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET nombre_completo = TRIM(nombre_completo);
SET SQL_SAFE_UPDATES=1;
SELECT * FROM clientes;

-- 2.2.2. Corrección de dominios: 
SELECT email from clientes where email like '%.con';
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET email = REPLACE(email, '%email.con','email.com');
UPDATE clientes SET email = REPLACE(email, '%outlook.con','outlook.com');
SET SQL_SAFE_UPDATES = 1;
SELECT email FROM clientes;

-- 2.2.3. Estandarizacion de teléfonos:
SELECT * from clientes;
START TRANSACTION;
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET telefono = REPLACE(telefono, ' ','');
UPDATE clientes SET telefono = REPLACE(telefono,'-','');
UPDATE

