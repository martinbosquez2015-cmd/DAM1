class Contacto:
    def __init__(self, nombre, telefono, email):
        self.nombre = nombre
        self.telefono = telefono
        self.email = email
    def __str__(self):
        return f"{self.nombre}, {self.telefono}, {self.email}"


def contactoToCSV(contacto):
    return  f"{contacto.nombre};{contacto.telefono};{contacto.email}\n";
def guardarContacto(contacto):
    with open("contactos.csv","a",encoding="utf-8") as contactos:
        contactos.write(contactoToCSV(contacto))

def csvToContacto(lineCSV):
    nombre, telefono, email = lineCSV.strip().split(";")
    return Contacto(nombre, telefono, email)


contacto = Contacto("Nuevo", "604888888", "prueba@prueba.com")
guardarContacto(contacto)
listaContactos = []
with open("contactos.csv","r",encoding="utf-8") as contactos:
    for linea in contactos:
        if linea.startswith("nombre"):
            continue
        print(linea)
        '''
        linea = linea.strip().split(";")
        contactoLeido = Contacto(linea[0], linea[1], linea[2])
        '''
        listaContactos.append(csvToContacto(linea))
        nombre, telefono, email = linea.strip().split(";")
        contactoLeido = Contacto(nombre, telefono, email)
        print(contactoLeido)

