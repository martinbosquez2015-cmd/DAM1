# TEMARIO SISTEMAS 
|TEMA|PUNTOS|
|---|-------|
|CMDLET|1.5|
|Tuberias 1|1|
|Tuberias 2|1|
|Scripts|1.5|
|Màscara fija|1.5|
|Màscara variable|1.5|
|Enrutamiento|2|
------
## Estudio
1. Crear un script en windows en el que usemos los cmdlets y los pipes
----
## Tablas 
- naves

|Campo 	|Tipo 	|Restricciones|
|-------|-------|----------|
|id 	|INTEGER |PRIMARY KEY, AUTOINCREMENT|
|nombre 	|TEXT 	|NOT NULL|
|tipo 	|TEXT 	|(galeón, fragata, bergantín…)|
|año_construccion 	|INTEGER 	| |
|epoca 	|TEXT 	|(Edad Media, Siglo de Oro, etc.)|

- Tabla agentes

|Campo 	|Tipo 	|Restricciones|
|-------|-------|----------|
|id 	|INTEGER 	|PRIMARY KEY, AUTOINCREMENT|
|nombre 	|TEXT 	|NOT NULL|
|año_nacimiento 	|INTEGER 	| |
|especialidad 	|TEXT 	|(combate, infiltración, diplomacia…)|
|activo 	|INTEGER 	|DEFAULT 1|

- Tabla misiones

|Campo 	|Tipo 	|Restricciones|
|-------|-------|----------|
|id 	|NTEGER 	|PRIMARY KEY, AUTOINCREMENT|
|id_agente 	|INTEGER 	|FOREIGN KEY → agentes|
|id_nave 	|INTEGER 	|FOREIGN KEY → naves|
|fecha_partida 	|TEXT 	|
|fecha_regreso 	|TEXT 	|NULL si aún no ha vuelto|
|exito 	|INTEGER 	|DEFAULT 0 (1 = sí, 0 = no)|
|incidencias 	|TEXT 	|Descripción de problemas temporales|
