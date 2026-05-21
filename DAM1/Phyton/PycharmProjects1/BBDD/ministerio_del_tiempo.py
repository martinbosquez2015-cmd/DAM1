'''No se ha concluido con funciones de mostrar en pantalla'''

import sqlite3

def setup(cursor):
    cursor.executescript('''
        CREATE TABLE IF NOT EXISTS nave (
            id_nave INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre VARCHAR(50) NOT NULL,
            tipo VARCHAR(30),
            año_construccion SMALLINT,
            epoca VARCHAR(40)
        );

        CREATE TABLE IF NOT EXISTS agente (
            id_agente INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre VARCHAR(50) NOT NULL,
            año_nacimiento SMALLINT,
            especialidad VARCHAR(40),
            activo BOOLEAN DEFAULT TRUE
        );

        CREATE TABLE IF NOT EXISTS mision (
            id_mision INTEGER PRIMARY KEY AUTOINCREMENT,
            id_agente INTEGER,
            id_nave INTEGER,
            fecha_partida DATE,
            fecha_regreso DATE, 
            exito BOOLEAN DEFAULT FALSE, 
            incidencias TEXT, 
            FOREIGN KEY (id_agente) REFERENCES agente(id_agente),
            FOREIGN KEY (id_nave) REFERENCES nave(id_nave)
        );
    ''')

def insercion(cursor):
    cursor.execute("SELECT count(*) FROM nave")
    if cursor.fetchone()[0] == 0:
        cursor.executescript('''
            INSERT INTO nave(nombre, tipo, año_construccion, epoca)
VALUES
("XL-01", "Nave de patrulla", 3001, "Era Galáctica"),
("Nova Cruiser", "Fragata espacial", 2998, "Era Galáctica"),
("Star Comet", "Explorador interestelar", 3005, "Conflicto Zurg"),
("Ranger One", "Nave táctica", 3003, "Era Galáctica"),
("Hyperion", "Crucero pesado", 2995, "Guerra Estelar");



-- AGENTES


INSERT INTO agente(nombre, año_nacimiento, especialidad, activo)
VALUES
("Buzz Lightyear", 2975, "combate", 1),
("Mira Nova", 2980, "diplomacia", 1),
("XR", 3008, "infiltración", 1),
("Booster Sinclair", 2968, "pilotaje", 1);



-- MISIONES


INSERT INTO mision(
    id_agente,
    id_nave,
    fecha_partida,
    fecha_regreso,
    exito,
    incidencias
)
VALUES

-- Buzz defendiendo el sector Gamma
(1, 1, "3021-03-10", "3021-03-15", 1,
"Interceptados drones de Zurg cerca de la base Gamma"),

-- Mira Nova en misión diplomática
(2, 2, "3021-04-02", "3021-04-12", 1,
"Negociaciones tensas con comerciantes de T'Kani"),

-- XR infiltrándose en una estación enemiga
(3, 3, "3021-05-01", "3021-05-04", 0,
"Descubierto por robots centinela del emperador Zurg"),

-- Booster transportando suministros
(4, 4, "3021-05-20", "3021-05-30", 1,
"Problemas menores con motores hiperespaciales"),

-- Buzz explorando un planeta desconocido
(1, 5, "3021-06-11", "3021-06-20", 0,
"Tormenta electromagnética destruyó parte del radar"),

-- XR en misión actualmente activa
(3, 1, "3021-07-01", NULL, 0,
"Operación secreta en curso contra bases de Zurg");
        ''')

def registrar_nave(cursor, nombre, tipo, año, epoca):
    cursor.execute('''INSERT INTO nave(nombre, tipo, año_construccion, epoca) VALUES(?,?,?,?)''', 
                   (nombre, tipo, año, epoca))
    print("Nave registrada correctamente")

def enviar_agente(cursor, id_agente, id_nave, fecha_partida):
    cursor.execute('SELECT * FROM mision WHERE id_agente=? AND fecha_regreso IS NULL', (id_agente,))
    if cursor.fetchone():
        print("ERROR: El agente ya está en una misión activa, ¿Paradoja temporal detectada?")
    else:
        cursor.execute('INSERT INTO mision(id_agente, id_nave, fecha_partida) VALUES(?,?,?)', 
                       (id_agente, id_nave, fecha_partida))
        print("Misión iniciada correctamente")

def cerrar_mision(cursor, id_mision, exito, incidencias):
    cursor.execute('''UPDATE mision SET exito=?, incidencias=?, fecha_regreso=DATE('now') 
                      WHERE id_mision=?''', (exito, incidencias, id_mision))
    print("Misión cerrada correctamente")

def naves_sin_capitan(cursor):
    cursor.execute('''SELECT nombre, tipo FROM nave WHERE id_nave NOT IN 
                      (SELECT id_nave FROM mision WHERE fecha_regreso IS NULL)''')
    print("NAVES SIN AGENTES ASIGNADOS:", [row[0] for row in cursor.fetchall()])





def main():

    try:
        with sqlite3.connect("misiones_navales.db") as conexion:
            cursor = conexion.cursor()
            setup(cursor)
            insercion(cursor)
            registrar_nave(cursor, "Santa María", "Carabela", 1492, "Edad Moderna")
            enviar_agente(cursor, 1, 1, "2026-05-21")
            cerrar_mision(cursor, 1, 1, "Sin incidencias")
            naves_sin_capitan(cursor)
            conexion.commit()
    except sqlite3.Error as e:
        print(f"Error en la base de datos: {e}")




if __name__== "__main__":
    main()
else:
    print("Soy un módulo cargado")
