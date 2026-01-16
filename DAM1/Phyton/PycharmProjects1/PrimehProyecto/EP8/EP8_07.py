from random import randint
def main():
    dic_cif=cifrado()
    mensaje= input("Escribe el mensaje a encriptar: ")
    print(menscifrado(dic_cif, mensaje))




def cifrado():
    dick={}
    abc= "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
    for i in abc:
        random= randint(10,99)
        while random not in abc:
            random= randint(10,99)
        dick.update({abc[i]:random})
    return dick

def menscifrado(dic, mens):
    for i in mens:
        #mens[i]
        return "si"
    print(dic.items())
    print(dic.keys())
    print(dic.values())




if __name__== "__main__":
    main()
else:
    print("Soy un módulo cargado")

