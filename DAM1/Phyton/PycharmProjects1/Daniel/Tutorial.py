def SlicingStrings():
    b = "Hello, World"
    print(b[2:5])

def ModifyStrings():
    a = " Hello, World "
    #A maysculas
    print(a.upper())
    #A minusculas
    print(a.lower())
    #Quita los espacios en blanco que este al principio y al final
    print(a.strip())

def ConcatenateStrings():
    a = "Hello"
    b = " "
    c = "World"
    d = a + b + c
    print(d)

def FormatStrings():
    name = "Daniel"
    age = 36
    txt = "My name is "+ name + ". I am " + str(age) + " years old."
    print(txt)

def MethodsStrings():
    txt = "Hola mundo"
    #El primer caracter a mayscula.
    print(txt.capitalize())
    #Lo transforma a minusculas.
    print(txt.casefold())
    #Devuelve el texto centrado entre 20 caracteres y relleno con -.
    print(txt.center(20, "-"))
    #Cuenta cuantas veces se encuentra un caracter.
    print(txt.count("o"))
    #Te devuelve la primera poscición en la que se encuentre el caracter.
    print(txt.find("a"))
    #Inserta el formato en el lugar del formato
    txtFormat = "For only {price:.2f} dollars!"
    print(txtFormat.format(price = 49))
    #Devuelve la posición en la lista en la que se encuentra
    txtIndex = ["texto1", "texto2", "texto3"]
    print(txtIndex.index("texto3"))
    #Devuelve true si todos los caracteres son alfanumericos
    print(txt.isnumeric())
    #Devuelve true si todos los caracteres son alfabeticos
    print(txt.isalpha())
    #Devuelve true si todos los caracteres estan en minuscula
    print(txt.islower())
    #Devuelve true si todos los caracteres estan en mayuscula
    print(txt.isupper())
    #Devuelve true si todos los caracteres son numericos
    print(txt.isnumeric())
    #Devuelve true si todos los caracteres son espacios en blanco
    print(txt.isspace())
    #Reemplaza un valor por otro
    print(txt.replace("Hola","Adios"))
    #Te devuelve la ultima poscición en la que se encuentre el caracter.
    print(txt.rfind("a"))
    #Te devuelve true si la cadena empieza por ese caracter
    print(txt.startswith("H"))
    # Te devuelve true si la cadena termina por ese caracter
    print(txt.endswith("o"))
    #Cambia el primer caracter de cada palabra a mayuscula
    print(txt.title())
    #Rellena la cadena con ceros hasta que llegue a 20 caracteres en total
    print(txt.zfill(20))
    #
    x = ["apple", "banana"]
    y = ["apple", "banana"]
    print(x is not y)
    #
    lista = ["apple", "banana", "cherry"]
    print(len(lista))
    #Te devuelve el valor de la posición del valor especificado
    print(lista[-1])
    #Devuelve los valores de los que se encuentran entre esas posiciones sin incluirlas
    listaAccess = ["apple", "banana", "cherry", "orange", "kiwi", "melon", "mango"]
    print(listaAccess[2:5])
    #Sustituir una o varias posiciones de la lista por otras
    thislist = ["apple", "banana", "cherry", "orange", "kiwi", "mango"]
    thislist[1:3] = ["blackcurrant", "watermelon"]
    print(thislist)
    #Añade un valor al final de la lista
    listaAppend = ["apple", "banana", "cherry"]
    listaAppend.append("orange")
    print(listaAppend)
    #Añade el elemento en la lista en la posición dada
    listaInsert = ["apple", "banana", "cherry"]
    listaInsert.insert(1, "orange")
    print(listaInsert)
    #Elimina el elemento de la lista
    listaRemove = ["apple", "banana", "cherry"]
    listaRemove.remove("banana")
    print(listaRemove)
    #Elimina el elemento de la lista en la posición dada
    listaPop = ["apple", "banana", "cherry"]
    listaPop.pop(1)
    print(listaPop)
    #Elimina el elemento de la lista en la posición dada
    delLista = ["apple", "banana", "cherry"]
    del delLista[0]
    print(delLista)
    #Imprimir la lista uno a uno
    forLista = ["apple", "banana", "cherry"]
    for io in forLista:
        print(io, end=" ")
    #Imprimir la lista uno a uno utilizando la longitud de la lista
    listaRange = ["apple", "banana", "cherry"]
    for i in range(len(listaRange)):
        print(listaRange[i])
    #Ordena la lista de forma numerica o alfabetica de menor a mayor
    listaSort = ["orange", "mango", "kiwi", "pineapple", "banana"]
    listaSort.sort()
    print(listaSort)
    # Ordena la lista de forma numerica o alfabetica de mayor a menor
    listaSortR = [1,2,3,4,5,6,7]
    listaSortR.sort(reverse=True)
    print(listaSortR)
    #Copiar una lista dentro de otra lista
    listaCopy = ["apple", "banana", "cherry"]
    nListaCopy = listaCopy.copy()
    print(nListaCopy)
    #Une dos o mas listas en una nueva lista
    list1 = ["a", "b", "c"]
    list2 = [1,2,3]
    list3 = list1 + list2
    print(list3)
    #Otra forma para unir dos o mas listas
    list1 = ["a", "b", "c"]
    list2 = [1, 2, 3]
    for oio in list2:
        list1.append(oio)
    print(list1)
    #Elimina todos los elementos de la lista
    listaClear = ["apple", "banana", "cherry"]
    listaClear.clear()
    print(listaClear)
    #Añade los elementos de cars al final de la lista fruits
    fruits = ['apple', 'banana', 'cherry']
    cars = ['Ford', 'BMW', 'Volvo']
    fruits.extend(cars)
    print(fruits)
    #Le da la vuelta a la lista
    listaReverse = ["apple", "banana", "cherry"]
    listaReverse.reverse()
    print(listaReverse)
    #Crear una tupla
    tupla = ("apple", "banana", "cherry")
    print(tupla)
    #Cambiar una tupla a una lista (Funciona tambien al reves con .tuple)
    tuplaNormal = ("apple", "banana", "cherry")
    listaNormal = list(tuplaNormal)
    print(listaNormal)
    #Crear otra tupla para añadir un nuevo elemento al final de la otra
    tuplaZ = ("apple", "banana", "cherry")
    Z = ("orange",)
    tuplaZ += Z
    print(tuplaZ)
    #Empacar y desempacar tuplas
    fruits = ("apple", "banana", "cherry")
    (green, yellow, red) = fruits
    print(green,yellow,red)
    #Recorrer una tupla
    tuplaFor = ("apple", "banana", "cherry")
    for ioio in tuplaFor:
        print(ioio, end=" ")
    print()
    #Unir dos o mas tuplas
    tupla1 = ("a", "b", "c")
    tupla2 = (1, 2, 3)
    tupla3 = tupla1 + tupla2
    print(tupla3)
    #Cuenta cuantas veces se encuentra ese valor en la tupla
    tuplaCount = (1,2,3,4,5,5,5,6,7,8)
    print(tuplaCount.count(5))
    #Devuelve la primera posición en la que se encuentra ese valor
    thistuple = (1, 3, 7, 8, 7, 5, 4, 6, 8, 5)
    print(thistuple.index(8))
    #Crear un set
    set = {"apple", "banana", "cherry"}
    #Comprobar si un elemeneto esta en el set
    setIn = {"apple", "banana", "cherry"}
    print("banana" in setIn)
    # Comprobar si un elemeneto no esta en el set
    setNotIn = {"apple", "banana", "cherry"}
    print("banana" not in setNotIn)
    #Añade un elemento al set
    setAdd = {"apple", "banana", "cherry"}
    setAdd.add("orange")
    print(setAdd)
    #Añade los elementos de un set a otro   (Tambien funciona para añadir a un set los elementos de una lista)
    set1 = {"apple", "banana", "cherry"}
    set2 = {"pineapple", "mango", "papaya"}
    set1.update(set2)
    print(set1)
    #Elimina un elemento del set
    setRemove = {"apple", "banana", "cherry"}
    setRemove.remove("banana")
    print(setRemove)
    #Elimina un elemento del set
    setDiscard = {"apple", "banana", "cherry"}
    setDiscard.discard("banana")
    print(setDiscard)
    #Elimina un elemento al azar del set
    setPop = {"apple", "banana", "cherry"}
    x = setPop.pop()
    print(setPop)
    #
    # Python - Loop Sets
    #

MethodsStrings()