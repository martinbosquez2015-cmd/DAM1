package segundoTrimestre;
import java.util.ArrayList;
abstract class Empleado {
	protected String nombre;
	protected int codigo;
	protected int salarioBase;
	protected static ArrayList<Empleado> maya = new ArrayList<>();
	
	public Empleado(String n,int salario){
		this.nombre=n;
		this.salarioBase=salario;
		maya.add(this);
		this.codigo=generarCodigo();
		
	}
	
	public static int generarCodigo() {
		return maya.size();
	}
	
	public String getNombre() {
		return this.nombre;
	}
	public void setSalario(int s) {
		this.salarioBase=s;
	}
	public void mostrar() {
		System.out.println("-----------------------------------------");
		System.out.printf("%s\nCódigo EMP-%03d\nSalario: %d\n",this.nombre,this.codigo, this.salarioBase);
	}
}
