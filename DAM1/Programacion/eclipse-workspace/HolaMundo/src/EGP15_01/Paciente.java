package EGP15_01;

class Paciente extends Persona{
	private String dni;
	private int tel;
	private CentroMedico centro;
	
	
	public Paciente(String fname, String lname, String dni, int tel, CentroMedico centro) {
		super(fname, lname);
		this.dni=dni;
		this.tel=tel;
		this.centro=centro;
		centro.addPaciente(this);
	}
	
	public void changeCenter(CentroMedico cm2) {
		this.centro.chanceCenter(cm2, this);
		this.centro= cm2;
	}
	
	public void mostrar() {
		System.out.printf("Datos del paciente:\n - Nombre: %s %s\n - DNI: %s\n - Numero de telefono: %d \nCentro medico: %s\n\n\n",  this.nombre, this.apellidos, this.dni, this.tel, this.centro.getName());
	}
}
