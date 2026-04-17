fichero = open("archivochachi.txt", "a", encoding="utf-8")
fichero.write("12 Cervezas\n")
fichero.writelines(["127 uvas\n", "23 cucharillas\n"])
fichero.close()


with open("quijote.txt", "r") as quijote:
    print(quijote)
    '''Este te printea una mierda xd, solo te printea un objeto'''
    print(quijote.read())
    quijote.seek(0)
    print(quijote)
    print(quijote.readlines())
