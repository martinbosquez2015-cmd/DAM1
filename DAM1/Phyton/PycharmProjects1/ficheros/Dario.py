import json
import datetime


RUTA_DIARIO = "diario.json"


def cargar_diario(ruta=RUTA_DIARIO):

    try:
        with open(ruta, "r", encoding="utf-8") as fichero:
            return json.load(fichero)
    except FileNotFoundError:
        return []
    except json.JSONDecodeError:
        print("Error: el archivo JSON está dañado.")
        return []


def guardar_diario(entradas, ruta=RUTA_DIARIO):
    """
    Guarda la lista de entradas en el fichero JSON.
    """
    with open(ruta, "w", encoding="utf-8") as fichero:
        json.dump(entradas, fichero, ensure_ascii=False, indent=4)


def añadir_entrada():
    """
    Pide al usuario un título y un texto y crea una nueva entrada.
    La fecha se añade automáticamente.
    """
    titulo = input("Título: ").strip()
    texto = input("Texto: ").strip()

    entrada = {
        "fecha": str(datetime.date.today()),
        "titulo": titulo,
        "texto": texto
    }

    entradas = cargar_diario()
    entradas.append(entrada)
    guardar_diario(entradas)

    print("Entrada guardada correctamente.\n")


def listar_ultimas_entradas():
    """
    Muestra las últimas N entradas del diario.
    """
    entradas = cargar_diario()

    if not entradas:
        print("El diario está vacío.\n")
        return

    try:
        cantidad = int(input("¿Cuántas entradas quieres ver?: "))
    except ValueError:
        print("Debes introducir un número.\n")
        return

    ultimas = entradas[-cantidad:]

    print("\n--- Últimas entradas ---")
    for entrada in reversed(ultimas):
        print(f"Fecha : {entrada['fecha']}")
        print(f"Título: {entrada['titulo']}")
        print(f"Texto : {entrada['texto']}")
        print("-" * 30)

    print()


def buscar_entradas():
    """
    Busca entradas que contengan una palabra clave.
    """
    palabra = input("Palabra clave: ").strip().lower()

    entradas = cargar_diario()
    resultados = []

    for entrada in entradas:
        titulo = entrada["titulo"].lower()
        texto = entrada["texto"].lower()

        if palabra in titulo or palabra in texto:
            resultados.append(entrada)

    if not resultados:
        print("No se encontraron entradas.\n")
        return

    print("\n--- Resultados de búsqueda ---")
    for entrada in resultados:
        print(f"Fecha : {entrada['fecha']}")
        print(f"Título: {entrada['titulo']}")
        print(f"Texto : {entrada['texto']}")
        print("-" * 30)

    print()


def mostrar_menu():
    """
    Muestra el menú principal del programa.
    """
    while True:
        print("=== DIARIO PERSONAL ===")
        print("1. Añadir entrada")
        print("2. Listar últimas entradas")
        print("3. Buscar entradas")
        print("4. Salir")

        opcion = input("Elige una opción: ").strip()

        if opcion == "1":
            añadir_entrada()

        elif opcion == "2":
            listar_ultimas_entradas()

        elif opcion == "3":
            buscar_entradas()

        elif opcion == "4":
            print("Hasta pronto.")
            break

        else:
            print("Opción no válida.\n")


if __name__ == "__main__":
    mostrar_menu()