DROP DATABASE IF EXISTS gestion_universidad;
CREATE DATABASE gestion_universidad;
USE gestion_universidad;

CREATE TABLE facultades(
	id_facultad SMALLINT UNSIGNED AUTO_INCREMENT,
    codigo CHAR(4) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    id_decano INT UNSIGNED DEFAULT NULL,
    CONSTRAINT pk_facultades PRIMARY KEY(id_facultad),
    CONSTRAINT uq_codigo UNIQUE (codigo),
    CONSTRAINT uq_nombre UNIQUE (nombre)
);

CREATE TABLE profesores(
	id_profesor INT UNSIGNED AUTO_INCREMENT,
    nif CHAR(9) NOT NULL,
    nombre_completo VARCHAR(60) NOT NULL,
    salario DECIMAL(10,2) DEFAULT 2000.00,
    id_facultad SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT pk_profesores PRIMARY KEY(id_profesor),
    CONSTRAINT fk_profesores_facultades FOREIGN KEY (id_facultad)
		REFERENCES facultades (id_facultad)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_nif UNIQUE(nif),
    CONSTRAINT chk_nif_comprobacion CHECK(REGEXP_LIKE(nif, '^([0-9]{8}|[XYZ][0-9]{7})[A-Z]$')),
    CONSTRAINT chk_salario_pos CHECK(salario>0)
    
);

ALTER TABLE facultades
	ADD CONSTRAINT fk_facultades_profesores FOREIGN KEY(id_decano)
		REFERENCES profesores(id_profesor)
        ON DELETE SET NULL ON UPDATE CASCADE;
        
CREATE TABLE grados(
	id_grado INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    id_facultad SMALLINT UNSIGNED NOT NULL,
	CONSTRAINT pk_grados PRIMARY KEY (id_grado),
    CONSTRAINT fk_grados_facultades FOREIGN KEY (id_facultad)
		REFERENCES facultades(id_facultad)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_nombre UNIQUE(nombre)
);

CREATE TABLE asignaturas(
	id_asignatura INT UNSIGNED AUTO_INCREMENT,
    codigo_asig VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    creditos SMALLINT UNSIGNED DEFAULT 6,
    CONSTRAINT pk_asignaturas PRIMARY KEY(id_asignatura),
    CONSTRAINT uq_codigo_asig UNIQUE(codigo_asig),
    CONSTRAINT chk_creditos CHECK(creditos >= 3)
);
CREATE TABLE imparten(
	id_profesor INT UNSIGNED,
    id_asignatura INT UNSIGNED,
    tipo_grupo ENUM('TEORIA','PRACTICA') DEFAULT 'TEORIA',
    CONSTRAINT pk_imparten PRIMARY KEY (id_profesor, id_asignatura),
    CONSTRAINT fk_imparten_profesores FOREIGN KEY(id_profesor)
		REFERENCES profesores(id_profesor)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_imparten_asignaturas FOREIGN KEY(id_asignatura)
		REFERENCES asignaturas(id_asignatura)
        ON DELETE CASCADE ON UPDATE CASCADE
        
);

CREATE VIEW v_cuadro_docente AS
    SELECT 
        profesores.nombre_completo AS profesor,
        profesores.nif AS nif_profesor,
        asignaturas.nombre AS asignatura,
        imparten.tipo_grupo AS modalidad,
        facultades.nombre AS facultad_origen
    FROM
        profesores
            JOIN
        imparten USING (id_profesor)
            JOIN
        asignaturas USING (id_asignatura)
            JOIN
        facultades USING (id_facultad);

CREATE VIEW v_resumen_facultades AS
	SELECT
		facultades.nombre AS facultad,
        facultades.codigo AS codigo_facultad,
        COUNT(profesores.id_profesor) as num_profesores,
        SUM(profesores.salario) as masa_salarial,
        ROUND(AVG(profesores.salario), 2) as salario_medio
        from
			facultades
		JOIN 
			profesores USING (id_facultad)
		GROUP BY id_facultad;
        

