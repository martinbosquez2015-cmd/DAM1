with open("quijote.txt","r", encoding="UTF-8") as quijote:
    contador=0;
    for linea in quijote:
        contador += len(linea.strip().split(" "))

    print (contador)