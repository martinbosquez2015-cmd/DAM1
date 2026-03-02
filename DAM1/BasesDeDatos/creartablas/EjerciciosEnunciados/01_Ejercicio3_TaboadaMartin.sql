
DROP DATABASE IF EXISTS gestion_proyectos;
CREATE DATABASE gestion_proyectos;
USE gestion_proyectos;

CREATE TABLE empleados ( 
	id_empleado INT AUTO_INCREMENT,
    dni VARCHAR(9) NOT NULL,
    salario DECIMAL(10,2),
    estado ENUM('ACTIVO', 'INACTIVO'),
    CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
    CONSTRAINT uq_dni UNIQUE (dni),
    CONSTRAINT chk_dni_comprobacion CHECK(REGEXP_LIKE(dni, "^[0-9]{8}[A-Z]{1}$"))
    
);

ALTER TABLE empleados 
	ALTER COLUMN estado SET DEFAULT 'ACTIVO',
    ALTER COLUMN salario SET DEFAULT 1200.00;
    
    
CREATE TABLE proyectos (
	id_proyecto INT AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
    id_departemento INT UNSIGNED NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    CONSTRAINT pk_proyectos PRIMARY KEY (id_proyecto),
    CONSTRAINT fk_proyectos_departamentos 
    FOREIGN KEY (id_departamento)
    REFERENCES departamentos(id_departamentos) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_fecha_fin CHECK (fecha_fin>fecha_inicio)
);
