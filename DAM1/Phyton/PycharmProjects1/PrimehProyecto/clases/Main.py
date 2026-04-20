from animal import Animal, Perro, Gato, Tortuga
from cliente import Cliente
from protectora import Protectora

import cliente
if __name__ == "__main__":

   
    p1 = Perro(2020, True, "Rex")
    p2 = Perro(2019, False)
    g1 = Gato(2021, True, "Misu")
    t1 = Tortuga(2015, "Lenta")

    
    protectora = Protectora()
    protectora.agregar_animal(p1)
    protectora.agregar_animal(p2)
    protectora.agregar_animal(g1)
    protectora.agregar_animal(t1)

   
    cliente = Cliente("Juan", "Perez", 25, "123456789")

    protectora.listar_disponibles()

    protectora.adoptar_animal(cliente, p1)
    protectora.adoptar_animal(cliente, g1)

    print("\n--- Animales del cliente ---")
    cliente.mostrar_animales()

    print("\n--- Disponibles tras adopción ---")
    protectora.listar_disponibles()