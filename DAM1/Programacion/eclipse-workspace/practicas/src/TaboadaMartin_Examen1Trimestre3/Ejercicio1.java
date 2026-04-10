package TaboadaMartin_Examen1Trimestre3;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;

public class Ejercicio1 {

	public static void main(String[] args) {
		String animes = "animes.txt";
		String personajes = "personajes.txt";
		System.out.println("libreríaDeAnimesinador versión 1.0");
		HashMap<String, String> libAnimes = crearDic(animes);
		ArrayList<String> libPersonajes = lectura(personajes);
		categorizacion(libAnimes, libPersonajes);

	}

	public static void categorizacion(HashMap<String, String> libAnimes, ArrayList<String> libPersonajes) {
		for (String id : libAnimes.keySet()) {
			ArrayList<String> personajesAnime = new ArrayList<>();
			for (String s : libPersonajes) {
				int posicion = s.indexOf(":");
				String idM = s.substring(0, posicion);
				String personaje = s.substring(posicion + 1);
				if (id.equals(idM))
					personajesAnime.add(personaje);
			}
			System.out.printf("%S", libAnimes.get(id));
			if (libAnimes.get(id).equals("El una pieza"))
				System.out.println("(THE ONE PIECE, THE ONE PIECE IS REAL!!!!)");
			else
				System.out.println();
			if (personajesAnime.size() == 0) {
				System.out.println(" - No hay personajes(Todos se murieron :c)\n");
			} else {
				for (String s : personajesAnime) {
					System.out.printf(" - %s\n", s);
				}
				System.out.println();
			}
		}
		ArrayList<String> personajesSinAnime = new ArrayList<>();
		for (String s : libPersonajes) {
			boolean si = false;
			int posicion = s.indexOf(":");
			String idM = s.substring(0, posicion);
			String personaje = s.substring(posicion + 1);
			for (String id : libAnimes.keySet()) {
				if (id.equals(idM))
					si = true;
			}
			if (si == false) {
				personajesSinAnime.add(personaje);
			}
		}
		if (personajesSinAnime.size() != 0) {
			System.out.println("PERSONAJES SIN ANIME");
			for (String s : personajesSinAnime) {
				System.out.printf(" - %s", s);
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
