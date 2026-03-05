package EGP23;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.regex.*;

public class EGP23_06 {

	public static void main(String[] args) {
		ArrayList<String> contenido = crearArray();
		Pattern patronS = Pattern.compile("^[0-9]+$");
		Pattern patronN = Pattern.compile("\\d+");
		boolean si = true;
		if (contenido != null) {
			if (contenido.size() % 3 == 0) {
				for (int i = 0; i < contenido.size(); i += 3) {
					if (patronS.matcher(contenido.get(i))==false)
				}
				for (int i = 1; i < contenido.size(); i += 3) {
					
				}
				for (int i = 2; i < contenido.size(); i += 3) {
					
				}
			}
		} else {
			System.out.println("Fichero está vacío");
		}

	}

	public static ArrayList<String> crearArray() {
		ArrayList<String> lineas = new ArrayList();

		try {
			Path fichero = Path.of("/home/alumno/agenda");
			lineas = (ArrayList) File.readAllLines(fichero);
		} catch (Exception e) {
			System.out.println("Error en el fichero:");
			System.out.println(e);
		}
		return lineas;
	}

}
