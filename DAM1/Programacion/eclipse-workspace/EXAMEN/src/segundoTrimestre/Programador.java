package segundoTrimestre;

class Programador extends Empleado{
	private boolean java;
	private boolean python;
	
	public Programador(String n, int salario, boolean j, boolean p) {
		super(n, salario);
		this.java=j;
		this.python=j;
		
		
	}
	public void calcularSalario(int s) {
		if(this.java==true)
			s+=200;
		else if(this.python==true)
			s+=200;
	this.setSalario(s);	
	
	}
	
	
}
