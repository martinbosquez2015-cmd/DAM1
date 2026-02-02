package MEdiCOS;
import java.util.ArrayList;
public class Especialidad {
	private String nombre;
	private ArrayList <Medico> medicos= new ArrayList<>();
	
	public Especialidad(String nombre){
		this.nombre=nombre;
	}
	
	public void addMedico(Medico m) {
		medicos.add(m);
	}
}
