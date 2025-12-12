package EGP13_01;

public class Grupo {
	private String nombre;
	private Ciclo ciclo;
	private String tutor;
	private int curso;
	private int numAlumn;
	private Alumno[] listaAlumnos;
	
	public Grupo(String nom, Ciclo c, int curso, int numAl){
		this.nombre=nom;
		this.ciclo=c;
		this.curso= curso;
		this.numAlumn=numAl;
		
	}
	public String Nom(){
		return this.nombre;
	}
	

}
