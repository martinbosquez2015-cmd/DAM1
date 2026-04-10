package TaboadaMartin_Examen1Trimestre3;
import java.io.Serializable;
import java.util.ArrayList;


public class Personaje implements Serializable{
	private String nombre;
	private String anime;
	private static ArrayList<Personaje> personajes=new ArrayList<>();
	
	public Personaje(String nombre, String anime) {
		this.nombre=nombre;
		this.anime = anime;
		personajes.add(this);
	}
	public void mostrar() {
		System.out.printf(" %s (%s)\n", this.nombre, this.anime);
	}
	public static ArrayList<Personaje> getLista() {
		return personajes;
	}
}
