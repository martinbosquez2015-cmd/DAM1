package defecto;
import java.util.*;
public class EGP2_15 {

	public static void main(String[] args) {
		boolean nuevoIntento = true;
		Scanner teclado;
		do {
			int azar = (int) (Math.random() * 50) + 1;
			System.out.println(azar);
			teclado = new Scanner(System.in);
			boolean acertado = false;
			for (int intentos = 1; acertado == false; intentos++) {
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
