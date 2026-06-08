# Apuntes para saneamiento en bases de datos
## Fugatech y blah blah blah...
- Tabla clientes
	- el nombre de "Juan  gomez" tiene un espacio de más entremedias
	- los teléfonos tienen un formato distinto
	- los correos están mal hechos, tienen comas y el primero termina en .local
- Tabla import_raw
	- La columna raw_data_str tiene un formato difetente en sus dos campos y une dos datos que estarían mejor separados
	- raw_phone tiene el froamto de los numeros de movil mal puestos
- importacion_tarifas
	- es una tabla que no se para que está: tipo, son cambios en la tabla de productos que se deben de hacer o esos datos se dejan ahí?