


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






if __name__=='__main__':
    ejercicio1()