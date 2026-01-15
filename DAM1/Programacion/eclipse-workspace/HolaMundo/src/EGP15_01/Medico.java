package EGP15_01;

class Medico extends Persona{
	private String especialidad;
	private String colegiado;
	private CentroMedico centro;
			
	public Medico(String fname, String lname, String esp, String colegiado, CentroMedico centro) {
		super(fname,lname);
		this.especialidad=esp;
		this.colegiado=colegiado;
		centro.addMedico(this);
		this.centro=centro;
	}
	
	public void changeCenter(CentroMedico cm2) {
		this.centro.chanceCenter(cm2, this);
	}
	public void mostrar() {
		System.out.printf("Datos del médico:\n - Nombre: %s %s\n - Colegiado: %s\n - Especialidad: %s\nCentro Médico: %s\n\n", this.nombre, this.apellidos, this.colegiado, this.especialidad, this.centro.getName());
	}
}
