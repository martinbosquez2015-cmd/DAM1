import random

def ejercicio1():
    list= []
    for i in range(0,10):
        num = random.randint(1,500)
        list.append(num)
    no = False
    print (list)
    list.sort();
    num_introducido=int(input("Escribe un número: "))
    for i in range(0,10):
        if list[i]==num_introducido:
            print("Adivinaste uno de los números de la lista!")
            a = i

        elif list[i]>num_introducido:
            no= True
            a=i
    if no ==True:
        print("No es el número elegido")
    print("Hay", a ,"números mayores al que has elegido")


def ejercicio2():
    lista = []
    num=0
    while num>=0:
        num =int(input('Introduce un numero: '))
        lista.append(num)
    lista.sort()
    print(lista)
    lista.sort(reverse=True)
    print(lista)

if __name__ == '__main__':
    #ejercicio1()#corrige mrd
    ejercicio2()
    #ejercicio3()
    #ejercicio4()
    #ejercicio7()
    #ejercicio12()
    #ejercicio16()