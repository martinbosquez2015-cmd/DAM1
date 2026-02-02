package MEdiCOS;

public class Medico {
	public Medico(Especialidad espe, String nombre) {
		super(nombre);
		espe.addMedico(this);
	}
	
}
