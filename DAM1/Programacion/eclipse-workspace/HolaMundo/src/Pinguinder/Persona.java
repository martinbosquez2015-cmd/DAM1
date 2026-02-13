package Pinguinder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

abstract class Persona {
	protected String nombre;
	protected LocalDate fechaNacimiento;
	protected int edadMinima=18;
	protected int edadMaxima= 200;
	protected int queBusco;//0- no me importa, 1- hombres, 2- mujereh,
	
	public Persona(String nombre,String nacimiento, int busco) {
		this.nombre =  nombre;
		this.queBusco = busco;
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		this.fechaNacimiento = LocalDate.parse(nacimiento, formato);
	}
	
	public Persona(String nombre,String nacimiento, int busco, int minimo, int maximo) {
		this(nombre, nacimiento, busco);
		if(minimo >18) {
			this.edadMinima = minimo;
			this.edadMaxima = maximo;
		}
	}
}
