package EGP23_09;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

public class Alumno {
	private String alumno;
	private double[]ras;
	private static String nombreModulo;
	private static ArrayList<Alumno> listaAlumnos = new ArrayList<>();;
	
	public Alumno(String nombre, double[] ras) {
		this.alumno = nombre;
		this.ras = ras;
	}
	public static void leerAlumnos(String fichero) {
		try(BufferedReader  lector = new BufferedReader(new FileReader(fichero))){
			String linea;
			while((linea = lector.readLine())!=null) {
				String[] elementos = linea.split(": ");
				String nombre = elementos[0];
				String[] ras = elementos[1].split(", ");
				double[] notas = new double[5];
				for(int i=0; i<5; i++) {
					notas[i] = Double.parseDouble(ras[i]);
					Alumno alumno = new Alumno(nombre,notas);
					Alumno.listaAlumnos.add(alumno);
				}
			}
		}catch(Exception e) {
			System.out.println("Error: " + e.getMessage());
		}
	}
	public boolean todoAprobado() {
		boolean aprobado = true;
		for(double nota: this.ras)
			if(nota<5)
				aprobado=false;
		return aprobado;
	}
	public static void procesarNotasAlumnos() {
		System.out.printf("Módulo: %s\nAlumnos con tofo aprobado\n", Alumno.nombreModulo);
		int contador = 0;
		for(Alumno alumno: Alumno.listaAlumnos) {
			if(alumno.todoAprobado()==true) {
				System.out.println(alumno.alumno);
				contador++;
			}
		}
		if(contador==0)
			System.out.println("Ninguno aprobó xd");
		System.out.println("Resultados de aprendizaje y alumnos suspensos:");
		for(int i=1; i<=5; i++) {
			System.out.printf("RA%d: \n", i);
			Alumno.suspensosPorRA(i-1);
		}
	}
	public static void suspensosPorRA(int n) {
		int contador=0;
		for(Alumno alumno:Alumno.listaAlumnos)
			if(alumno.ras[n]<5) {
				if(contador!=0) {
					System.out.print(", ");
				}
				System.out.printf("%s",alumno.alumno);
				contador++;
			}
		if (contador==0)
			System.out.println("Todos aprobados");
	}
	public static void salvarAlumnosBinario(String ficheroBinario) {
		try(ObjectOutputStream binario = new ObjectOutputStream(new FileOutputStream(ficheroBinario))){
			binario.writeObject(Alumno.listaAlumnos);
		}catch(Exception e) {
			System.out.println("Error: "+ e.getMessage());
		}
	}

}
