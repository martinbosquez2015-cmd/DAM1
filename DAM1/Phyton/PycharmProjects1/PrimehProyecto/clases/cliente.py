class Cliente:

    def __init__(self, nombre, apellido, edad, telefono):
        self.nombre = nombre
        self.apellido = apellido
        self.edad = edad
        self.telefono = telefono

        self.animales = []

    def adoptar(self, animal):

        perros = 0
        gatos = 0
        tortugas = 0

        for a in self.animales:
            if a.tipo == "perro":
                perros += 1
            elif a.tipo == "gato":
                gatos += 1
            elif a.tipo == "tortuga":
                tortugas += 1


        if len(self.animales) >= 4:
            print("No puedes adoptar más de 4 animales")
            return

        if animal.tipo == "perro" and perros >= 2:
            print("No puedes adoptar más perros")
            return

        if animal.tipo == "gato" and gatos >= 3:
            print("No puedes adoptar más gatos")
            return

        if animal.tipo == "tortuga" and tortugas >= 1:
            print("No puedes adoptar más tortugas")
            return

        self.animales.append(animal)
        print("Animal adoptado correctamente")
    
    
    def mostrar_animales(self):
        print("Animales de", self.nombre)
        if len(self.animales) == 0:
            print("No ha adoptado ningún animal")
        else:
            for a in self.animales:
              a.mostrar()