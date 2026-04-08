package tareas;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class EGP24_01 {

	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);
		System.out.println("TablasDeMultiplicarinador versión 1.0");
		String fichero = "c:/Users/HP/Desktop/ARCHIVOS/escritorio/1DAM/DAM1/DAM1/Programacion/ficheros/ficherosCasa/EGP24_01.txt";
		int numero = validarNumero(teclado);
		escribirEnFichero1(fichero, numero);
		escribirEnFichero2(fichero,numero);
		//escribirEnficheroBinario(fichero,numero);
		
	}
	public static void escribirEnFichero1(String fichero, int numero) {
		int resultado = 0;
		/*En este caso ponemos el true para sobreescribir en el caso de que haya algo escrito
		 * antes en el programa
		 */
		try(BufferedWriter escritor = new BufferedWriter(new FileWriter(fichero,true))){
			for(int i=1; i<=10; i++) {
				resultado = numero*i;
				escritor.write(" "+numero+" x "+ i+ " = " + resultado);
				escritor.newLine();
			}
			escritor.newLine();
			System.out.println("Escritura realizada correctamente");
			
		}catch(Exception e) {
			System.out.println("Error: " + e.getMessage());
		}
	}
	public static void escribirEnFichero2(String fichero, int numero) {
		int resultado = 0;
		//Nuevamente aquí se opta por añadir contenido al fichero y no eliminar lo que había antes por si las dudas
		//aquí en realidad, para poder añadir cosas a un fichero se debe hacer de esta manera
		//try(PrintWriter escritor = new PrintWriter(new FileWriter(fichero, StandardCharsets.UTF_8, true))){
		try(PrintWriter escritor = new PrintWriter(fichero, StandardCharsets.UTF_8)){
			for(int i = 1; i<=10; i++) {
				resultado = numero*i;
				escritor.printf("%3d x%4d =%4d\n", numero, i, resultado);
			}
			if (escritor.checkError()) {
				System.err.println("Ocurrió un error durante la escritura.");
			}
			escritor.println();
			System.out.println("Escritura realizada correctamente");
		}catch(Exception e) {
			System.out.println("Error: " + e.getMessage());
		}
	}
	public static int validarNumero(Scanner teclado){
		boolean si = false;
		int numero = 0;
		while (si == false) {
			try {
				System.out.println("Por favor, introduce el número deseado entre el 1 y el 10: ");
				numero = teclado.nextInt();
				si = true;
				
			} catch (Exception e) {
				System.out.println("Te pedí un número we");
				teclado.nextLine();
				si = false;
			}
			if(numero<=0 || numero>10) {
				si=false;
				System.out.println("El n{umero tiene que estar entre el 1 y el 10");
			}
		}
		return numero;
	}

}
