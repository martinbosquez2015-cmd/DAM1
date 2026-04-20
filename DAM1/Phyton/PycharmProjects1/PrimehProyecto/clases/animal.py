class Animal:

    def __init__(self, anio_nacimiento:int, tipo:str, nombre:str=None):
        self.anio_nacimiento = anio_nacimiento
        self.nombre = nombre
        self.tipo = tipo

    def mostrar(self):
        print("Tipo:", self.tipo)
        print("Año nacimiento:", self.anio_nacimiento)
        if self.nombre != None:
            print("Nombre:", self.nombre)


            
class Perro(Animal):

    def __init__(self, anio_nacimiento, vacunado:bool, nombre=None):
        super().__init__(anio_nacimiento, "perro", nombre)
        self.vacunado = vacunado

    def mostrar(self):
        print("PERRO")
        super().mostrar()
        print("Vacunado:", self.vacunado)
        print("--------------")


class Gato(Animal):

    def __init__(self, anio_nacimiento, vacunado:bool, nombre=None):
        super().__init__(anio_nacimiento, "gato", nombre)
        self.vacunado = vacunado

    def mostrar(self):
        print("GATO")
        super().mostrar()
        print("Vacunado:", self.vacunado)
        print("--------------")


class Tortuga(Animal):

    def __init__(self, anio_nacimiento, nombre=None):
        super().__init__(anio_nacimiento, "tortuga", nombre)

    def mostrar(self):
        print("TORTUGA")
        super().mostrar()
        print("--------------")
