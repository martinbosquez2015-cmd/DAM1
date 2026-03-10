package Ficheros;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

///Escritura de ficheros

public class EscrituraFicherosD {

	public static void main(String[] args) {
		
		//escribir1();
		//escribir2();
		//escribir3();
		//escribir4();
		escribir5();
		
	}
	
	public static void escribir1() {
		try {
			//FileWriter pluma = new FileWriter("/home/alumno/ficheroEscritura1.txt");		//Sobreescribe el fichero
			FileWriter pluma = new FileWriter("/home/alumno/ficheroEscritura1.txt", true);	//Añade al fichero
			pluma.write("Hola mundo escrito en un fichero\n");
			pluma.write("Segunda línea\n");
			pluma.close();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static void escribir2() {
		//try(BufferedWriter pluma = new BufferedWriter(new FileWriter("/home/alumno/ficheroEscritura1.txt", true))) {	//Añade al fichero
		try(BufferedWriter pluma = new BufferedWriter(new FileWriter("/home/alumno/ficheroEscritura1.txt"))) {			//Sobreescribe el fichero
			pluma.write("Hola mundo escrito en un fichero\n");
			pluma.newLine();
			pluma.write("Segunda línea\n");
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static void escribir3() {
		try(PrintWriter pluma = new PrintWriter(new FileWriter("/home/alumno/ficheroEscritura1.txt", StandardCharsets.UTF_8, true))) {
			pluma.print("Primera línea. ");
			pluma.println("Sigo en la segunda línea y salto.");
			pluma.print("SEgunda línea. ");
			String nombre = "Ana";
			String apellidos = "Campos Moro";
			int edad = 37;
			double salario = 2345.67;
			pluma.printf("Nombre: %s, %s. Edad: %d. Sueldo: %.2f", apellidos, nombre, edad, salario);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static void escribir4() {
		Path ruta = Paths.get("/home/alumno/ficheroEscritura1.txt");
		ArrayList<String> lineas = new ArrayList<>(List.of("Primera línea","Segunda línea","Tercera línea"));
		try {
			//Files.write(ruta, lineas, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.APPEND);	//Añade al fichero
			Files.write(ruta, lineas, StandardCharsets.UTF_8);	//Sobreescribe el fichero
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static void escribir5() {
		Path ruta = Paths.get("/home/alumno/ficheroEscritura1.txt");
		String contenido = "Hola mundo. Último método de escritura!";
		try {
			//Files.writeString(ruta, contenido, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.APPEND);	//Añade al fichero
			Files.writeString(ruta, contenido, StandardCharsets.UTF_8);	//Sobreescribe el fichero
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
