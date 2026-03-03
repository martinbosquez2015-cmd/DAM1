package EGP23;

import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

public class EGP23_01 {

	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);
		/*System.out.println("Escribe el nombre del fichero:");
		String nombreFichero = teclado.nextLine();
		while(existeElFichero(nombreFichero)==false) {
			System.out.printf("El fichero %s no existe, vuelce a escribir el nombre del fichero:", nombreFichero);
			nombreFichero = teclado.nextLine();*/
		boolean existe = false;
		String nombreFichero;
		while(existe==false) {
			System.out.println("Escribe el nombre del fichero: ");
			nombreFichero = teclado.nextLine();
			existe= existeElFichero(nombreFichero);
			if(existe == false)
				System.out.println("Error: fichero no encontrado");
		}
		//Primero pedimos por teclado el nombre del fichero
		//HAcemos un método que nos diga sie l fichero existe o no
		//Si no existe, volvemos a pedir un nombre de fichero
		// Una vezz que tenemos un fichero válido, hacemos otra función que nos devuelva
		// un ArrayList con su contenido
		// HAcemos una funcion que nos devuelva cuantas veces aparece una palabra en una liena de texto
		// y la ejecutamos para cada línea del ArrayList
		// no olvidar ir acumulando resultados en un contador

	}
	
	public static boolean existeElFichero(String fichero) {
		File f = new File(fichero);
		return (f.exists());
	}
	public static ArrayList<String> devuelveContenido(String fichero){
		ArrayList<String> aja = new ArrayList<>();
		return aja;
	}
	
	public static int contador(){
		return 1;
	}

}
