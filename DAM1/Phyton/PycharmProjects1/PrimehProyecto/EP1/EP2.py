


def ejercicio1 ():
    print('ejercicio 1\nnumerosdelunoal10inador versión 1.0')
    n1 = int(input('Por favor, introduce tres números\nPrimer número: '))
    n2 = int(input('Segundo número: '))
    n3 = int(input('Tercer número: '))
    if n1>n2:
        temp=n1
        n1=n2
        n2=temp
    if n1>n3:
        temp=n1
        n1=n3
        n3=temp
    if n2>n3:
        temp=n2
        n2=n3
        n3=temp
    print('El orden de los números de menor a mayor es:\n', n1,', ',n2,', ',n3,'.')
    input('Fin del programa, presione ENTER para terminar: ')


def ejercicio8():
    print("Comprobadordeclavesinador versión 1.0")
    coincidencia = False
    while coincidencia==False:
        pasw1= input("Por favor, introduce la contraseña: ")
        pasw2= input("Repite la contraseña: ")
        if pasw1 in pasw2:
            print("Las contraseñas coinciden.")
            coincidencia=True
        else:
            print("Las contraseñas no coinciden\nVuelve a intentarlo...")
    input("Presione ENTER para terminar: ")





if __name__=='__main__':
    ejercicio1()
    ejercicio8()
