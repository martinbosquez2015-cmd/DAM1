package defecto;

import java.util.Scanner;

public class EGP2_14 {

	public static void main(String[] args) {
		boolean nuevoIntento = true;
		Scanner teclado;
		System.out.println("Juegodeadivinarnumerosinador versión 1.0");
		do {
			teclado = new Scanner(System.in);
			System.out.println("Selecciona la dificultad...");
			System.out.println("Por favor, selecciona el rango de numeros");
			System.out.println("Selecciona el número menor: ");
			int numIn = teclado.nextInt();
			System.out.println("Selecciona el numero mayor: ");
			int numFin = teclado.nextInt();
			System.out.println("Selecciona el número de intentos permitidos: ");
			int intentosPermitidos = teclado.nextInt();
			int azar = (int) ((Math.random() * (numFin-numIn+1)) + numIn);
			System.out.println(azar);
			
			boolean acertado = false;
			for (int intentos = 1; acertado == false|| intentos==intentosPermitidos; intentos++) {
				// int intentos = 1;
				System.out.println("Intento número " + intentos + " ¿En qué número estoy pensando?: ");
				int eleccion = teclado.nextInt(); // intentos++;
				if (eleccion == azar) {
					System.out.println("¡¡Bravo!! ¡¡Has acertado!!");
					acertado = true;
				} else if (eleccion > azar)
					System.out.println("Te pasaste cabrón");
				else
					System.out.println("uyva, muy corto");
				if(intentos==intentosPermitidos && eleccion != azar) {
					System.out.println("Lo siento, has agotado el número de intentos, el número era " + azar);
					acertado = true;
				}
			}
			if (acertado == true) {
				System.out.println("El juego ha acabado, pero si introduces 's' puedes volver a jugar: ");
				String opcion = teclado.next();
				if (opcion.equals("s"))
					System.out.println("Volviendo a intentar.");
				else
					nuevoIntento = false;

			}

		} while (nuevoIntento == true);
		teclado.close();
		// if(acertado == false)
		// System.out.println("Lo siento, has agotado el número de intentos, el número
		// era " + azar);
		System.out.println("Programa finalizado.");

	}

}
