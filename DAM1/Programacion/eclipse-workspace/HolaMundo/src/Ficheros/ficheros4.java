package Ficheros;

import java.io.RandomAccessFile;
import java.util.HashMap;

public class ficheros4 {

	static final int TAMANYO_NOMBRE = 20;
	static final int TAMANYO_REGISTRO = TAMANYO_NOMBRE * 2 + 4;

	public static void main(String[] args) {
		String fichero = "/home/alumno/ficherosJava/bases/agenda.dat";
		HashMap<String, Integer> agenda = new HashMap<>();
		agenda.put("Alejandro", 33);
		agenda.put("Luis", 24);
		agenda.put("Ana", 32);
		agenda.put("Elvira", 41);
		try {
			crearAgenda(fichero, agenda);
			leerRegistro(fichero, 2);
			leerRegistro(fichero, 5);
			modificarRegistro(fichero, 2, "Ana María", 33);
			leerRegistro(fichero, 2);
			leerRegistro(fichero, 5);
			//anyadirRegistro(fichero, "Juan Carlos", 46);
			listarAgenda(fichero);

		} catch (Exception e) {
			System.out.println("Error: " + e.getMessage());
		}

	}

	public static void crearAgenda(String fichero, HashMap<String, Integer> agenda) throws Exception {
		try (RandomAccessFile raf = new RandomAccessFile(fichero, "rw")) {

			for (String nombre : agenda.keySet()) {
				int edad = agenda.get(nombre);
				escribirNombre(raf, nombre);
				raf.writeInt(edad);
			}
			System.out.println("Agenda creada. Tamaño: " + raf.length() + " bytes");

		}
	}

	public static void escribirNombre(RandomAccessFile raf, String nombre) throws Exception {
		char[] chars = new char[TAMANYO_NOMBRE];
		for (int i = 0; i < TAMANYO_NOMBRE; i++) {
			if (i < nombre.length())
				chars[i] = nombre.charAt(i);
			else
				chars[i] = ' ';
		}
		for (char c : chars) {
			raf.writeChar(c);
		}
	}

	public static void leerRegistro(String fichero, int registro) throws Exception {
		try (RandomAccessFile raf = new RandomAccessFile(fichero, "r")) {
			long posicion = TAMANYO_REGISTRO * (registro - 1);
			if (posicion >= raf.length()) {
				System.out.printf("El registro %d no existe\n", registro);
				System.out.printf("El registro más alto es el %d\n", raf.length() / TAMANYO_REGISTRO);
			} else {
				raf.seek(posicion);
				String nombre = leerNombre(raf);
				int edad = raf.readInt();
				System.out.printf("Registro: %d - Nombre: %s. Edad: %d\n", registro, nombre, edad);
			}
		}
	}
	public static void listarAgenda(String fichero) throws Exception{
		try (RandomAccessFile raf = new RandomAccessFile(fichero, "r")){
			long numRegistros = raf.length()/TAMANYO_REGISTRO;
			System.out.println("Lista de todos los registros:");
			for(int i=0; i<numRegistros; i++) {
				raf.seek(i*TAMANYO_REGISTRO);
				String nombre = leerNombre(raf);
				int edad = raf.readInt();
				System.out.printf(" - Registro: %d  |  Nombre: %20s  |  Edad: %d\n", i+1, nombre, edad);
			}
		}
	}

	public static String leerNombre(RandomAccessFile raf) throws Exception {
		String nombre = "";
		for (int i = 0; i < TAMANYO_NOMBRE; i++) {
			char c = raf.readChar();
			nombre += c;
		}
		return nombre.trim();
	}

	public static void modificarRegistro(String fichero, int registro, String nombre, int edad) throws Exception {
		try (RandomAccessFile raf = new RandomAccessFile(fichero, "rw")) {
			long posicion = TAMANYO_REGISTRO * (registro - 1);
			if (posicion >= raf.length()) {
				System.out.printf("El registro %d no existe\n", registro);
				System.out.printf("El registro más alto es el %d\n", raf.length() / TAMANYO_REGISTRO);
			} else {
				raf.seek(posicion);
				escribirNombre(raf, nombre);
				raf.writeInt(edad);
				System.out.println("Registro: " + registro + " modificado correctamente");

			}
		}
	}
	
	public static void anyadirRegistro(String fichero, String nombre, int edad) throws Exception {
		try (RandomAccessFile raf = new RandomAccessFile(fichero, "rw")) {
			raf.seek(raf.length());
			escribirNombre(raf, nombre);
			raf.writeInt(edad);
			System.out.println("Registro grabado correctamente");
		}
	}
}
