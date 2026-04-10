package TaboadaMartin_Examen1Trimestre3;

import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;

public class Ejercicio2 {

	public static void main(String[] args) {
		String animes = "animes.txt";
		String personajes = "personajes.txt";
		String fichero = "personajes.dat";
		System.out.println("libreríaDeAnimesinador versión 2.0");
		constructorConLista(animes, personajes);
		guardarFichero(fichero, Personaje.getLista());
		leerYMostrarFichero(fichero);
		
	}
	public static void leerYMostrarFichero(String fichero) {
		ArrayList <Personaje> lista = null;
        try (ObjectInputStream binario = new ObjectInputStream(new FileInputStream(fichero))) {        
            lista = (ArrayList<Personaje>) binario.readObject();
            System.out.println("La lista de Personajes ha sido recuperada correctamente.");
        }catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        System.out.println("\n=================================\nLibrería de personajes:\n=================================");
        for(Personaje p: lista) {
        	p.mostrar();
        }
	}
	public static void guardarFichero(String fichero, ArrayList<Personaje>listaP) { 
		try (ObjectOutputStream binario = new ObjectOutputStream(new FileOutputStream(fichero))) {
			binario.writeObject(listaP);
			System.out.println("Lista de personajes guardada correctamente");
		}catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
		}
	}
	public static void constructorConLista(String animes, String personajes) {
		HashMap <String, String>libAnimes = crearDic(animes);
		ArrayList <String>libPersonajes = lectura(personajes);
		for(String s: libPersonajes) {
			int posicion = s.indexOf(":");
			String idM = s.substring(0, posicion);
			String personaje = s.substring(posicion + 1);
			for (String id : libAnimes.keySet()) {
				if (id.equals(idM)) {
					Personaje p = new Personaje(personaje, libAnimes.get(id));
				}
			}
		}
	}
	public static HashMap<String, String> crearDic(String animes) {
		ArrayList<String> animesList = lectura(animes);
		HashMap<String, String> libAnimes = new HashMap<>();
		for (String s : animesList) {
			String[] elementos = s.split(":");
			String id = elementos[0];
			String valor = elementos[1];
			libAnimes.put(id, valor);
		}
		return libAnimes;
	}

	public static ArrayList<String> lectura(String fichero) {
		Path ruta = Path.of(fichero);
		ArrayList<String> lineas = null;
		try {
			lineas = (ArrayList<String>) Files.readAllLines(ruta);

		} catch (Exception e) {
			System.out.println("Error: " + e.getMessage());
		}
		return lineas;
	}

	

}
