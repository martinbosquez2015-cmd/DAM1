# Apuntes para Bases De Datos
## 1. Cosas importantísimas we
>1. __```import sqlite3```/```psycopg2```:__ Trae el driver/conector específico del motor.
>1. __```conexion = sqlite3.connect()```:__ Abre el canal de comunicación (el "cable" hacia la BD).
>1. __```cursor = conexion.cursor()```:__ Crea el Cursor. Es el cartero: el que lleva el SQL y trae los datos.
>1. __```cursor.execute("SQL")```:__ Envía la consulta a la base de datos.
>1. __```conexion.commit()```:__ ¡CRÍTICO! Guarda los cambios en el disco (solo para CRUD de escritura).
>1. __```cursor.close()``` y ```conexion.close()```:__ Cierra los recursos para no saturar la memoria.
>- __PD:__ Si usás el Context Manager (```with```), los pasos 5 y 6 se gestionan solos al salir del bloque indentado. Si el profesor te pide código tradicional, no te olvides de cerrar la conexión manualmente.

## 2. Glosario de Métodos y Palabras Clave en Python
Para que no te confundas qué comando usar en el código:

- ```.cursor()```: Crea la estructura que te permite ejecutar sentencias SQL y recorrer los resultados. Sin cursor, no podés interactuar.

- ```.execute(query, parámetros)```: Envía el SQL. Los parámetros siempre deben ir separados para evitar inyecciones.

- ```.executemany(query, lista_de_tuplas)```: Ideal para insertar muchos registros de golpe de forma eficiente.

- ```.commit()```: Aplica los cambios pendientes. Si hacés un ```INSERT``` y no tirás ```.commit()```, los datos se desvanecen al cerrar el script.

- ```.row_factory = sqlite3.Row```: Cambia el formato en que Python lee las filas. Por defecto te las da como tuplas ```(1, 'Juan')```. Con esto, te las da como diccionarios simulados, permitiéndote hacer ```fila['nombre']```.

- ```cursor.rowcount```: Propiedad que te dice cuántas filas fueron afectadas (afectadas por un ```UPDATE```, ```DELETE``` o ```INSERT```). No la uses para contar cuántas filas devolvió un ```SELECT```.

### Métodos de Extracción (Fetchers)
- ```.fetchone()```: Devuelve una sola fila como tupla. Si no hay más registros, devuelve ```None```.

- ```.fetchall()```: Devuelve una lista de tuplas con todos los registros. Cuidado: si la BD es gigante, te puede reventar la memoria RAM.

- ```.fetchmany(n)```: Devuelve una lista con la cantidad exacta ```n``` de filas que le pidas.