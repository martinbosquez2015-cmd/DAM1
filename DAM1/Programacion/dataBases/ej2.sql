CREATE DATABASE IF NOT EXISTS registros;
USE registros;
CREATE TABLE IF NOT exists usuario(
	id SMALLINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    salt VARCHAR(24),
    hach VARCHAR(88),
    email VARCHAR(60),
    privilegios TINYINT,
    CONSTRAINT pk_id_usuario PRIMARY KEY(id)
	);
select * from usuario;
INSERT INTO registros.usuario(nombre,salt,hach,email)VALUES("juan", "palitos", "a", "a");
drop database registros;