# Cosillas sobre la base de datos de logìstica global a corregir.
## Datos malos generales:
- todos los tipos de datos son varchar y no tienen comprobaciones
- Sin integridad referencial, nunguno apunta a otro 
## A donde apunta cada cosa
>vehiculos-->mantenimientos_flota
>envios-->incidencias
>clientes-->envios
>vehiculos-->envios
>empleados-->envios
>almacen-->envios
## Tabbla almacenes
- __cod_almacen:__ hay espacios y guines bajos en ciertos registros, ademàs los ùltimos 7 registros estàn hecho mierda, posibilidad de codigos repetidos 
- __nombre_sucursal:__  ultimos 7 registros
- __ciudad_ubicacion:__ Hay ciudades null y VLC
- __capacidad_m3:__ es reduntante la unidad de medida, y los ultimos tienen sus cosillas
- __tel_contacto:__ todos tienen el prefijo+34, no hay logica en que todos los tengan si la empresa es una empresa nacional
- __tipo_gestion:__ las ultimas y el formato no es igual en la opciones
- __Ubicacion_geogràfica:__ atributos multivaluados


