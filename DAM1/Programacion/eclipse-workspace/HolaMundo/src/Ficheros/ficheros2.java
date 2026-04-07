package Ficheros;

import java.io.FileWriter;

public class ficheros2 {

	public static void main(String[] args) {
		escritura1();

	}

	public static void escritura1() {
		/*try {
			// si el fichero no existe se crea. Si existe se borra su contenido antes de
			// escribir
			FileWriter escritor = new FileWriter("/home/alumno/DAM1/DAM1/Programacion/ficheros/fichero2/ficho1.txt");
			escritor.write("Hola, mundo con FileWriter!\n");
			escritor.write("Escribiendo una segunda línea.");
			System.out.println("Archivo escrito correctamente.");
			escritor.close();
		} catch (Exception e) {
			System.err.println("Error al escribir el archivo: " + e.getMessage());
		}*/
		try {
			// el segundo parámetro, true, indica que se añade al final (append) si el
			// fichero ya existe
			// si el fichero no existe se crea
			FileWriter escritor = new FileWriter("/home/alumno/DAM1/DAM1/Programacion/ficheros/fichero2/ficho1.txt", true);
			escritor.write("\nEsta línea se añade al final.");
			escritor.close();
		} catch (Exception e) {
			System.err.println("Error al añadir al archivo: " + e.getMessage());
		}
	}
}
