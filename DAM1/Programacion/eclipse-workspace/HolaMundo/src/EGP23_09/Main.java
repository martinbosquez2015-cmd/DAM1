package EGP23_09;

public class Main {

	public static void main(String[] args) {
		String fichero = "/home/alumno/redes.txt";
		String ficheroBinario = "/home/alumno/redes.bin";
		Alumno.leerAlumnos(fichero);
		Alumno.procesarNotasAlumnos();
		Alumno.salvarAlumnosBinario(ficheroBinario);
	}

}
