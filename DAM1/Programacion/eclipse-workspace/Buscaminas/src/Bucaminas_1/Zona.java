package Bucaminas_1;
import java.util.ArrayList;
public class Zona {
	private ArrayList<Casilla> area= new ArrayList<>();
	private static ArrayList<Zona> zonas = new ArrayList<>();
	public Zona(Casilla casilla) {
		this.area.add(casilla);
		this.zonas.add(this);
	}
	
	public static Zona crearZona(Casilla c) {
		return new Zona(c);
	}
	
	public void setCasilla(Casilla casilla) {
		area.add(casilla);
	}
}
