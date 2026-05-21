package TaboadaMartin_Examen2Trimestre3;

public class Empleado implements Categoria, Comparable<Empleado>{
	final static int VALOR_FRONTERA = 2500;
	private static int id_general = 1;
	private int id_empleado;
	private String nombre;
	private double salario;
	private double bono;
	
	
	public Empleado(String nombre, double salario, double bono) {
		this.id_empleado = id_general;
		autoincrementar();
		this.nombre=nombre;
		this.salario=salario;
		this.bono=bono;
	}
	
	
	public static void autoincrementar() {
		id_general+=1;
	};
	
	@Override
	public String categorizar() {
		String categoria="";
		if (this.salario<VALOR_FRONTERA) {
			categoria="Junior";
		}
		else {
			categoria = "Senior";
		}
		return categoria;
	};
	
	@Override
	public String toString() {
		String linea= "";
		linea += "Empleado número "+this.id_empleado+":"+this.nombre+" ("+categorizar()+")\nSalario mensual: "+this.salario+"€\nSalario con bono: "+this.bono;
		return linea;
	}
	
	@Override
	public int compareTo(Empleado otro) {
		int devolver = 0;
		if(this.salario>otro.salario)
			devolver-=1;
		else if(this.salario<otro.salario)
			devolver=1;
		else if(this.salario==otro.salario) {
			if(this.bono==otro.bono) {
				if(this.id_empleado>otro.id_empleado)
					devolver=1;
				else if(this.id_empleado<otro.id_empleado)
					devolver-=1;
			}
			else if(this.bono>otro.bono)
				devolver-=1;
			else if(this.bono<otro.bono)
				devolver=1;
		}
			
		
		return devolver;
	}
	
}
