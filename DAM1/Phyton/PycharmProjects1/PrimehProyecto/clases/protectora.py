class Protectora:

    def __init__(self):
        self.animales = []

    def agregar_animal(self, animal):
        self.animales.append(animal)

    def listar_disponibles(self):
        print("Animales disponibles:")
        if len(self.animales) == 0:
            print("No hay animales disponibles")
        else:
            for a in self.animales:
                a.mostrar()

    def adoptar_animal(self, cliente, animal):

        if animal in self.animales:
            cliente.adoptar(animal)

            # si se adopta, se elimina de la protectora
            if animal in cliente.animales:
                self.animales.remove(animal)
        else:
            print("Ese animal no está disponible")