package EGP13_01;

public class Ciclo {
	private Modulo[] primero= new Modulo[8];
	private Modulo[] segundo= new Modulo[8];
	private String nombre;
	private String[] grados= {"Grado Medio", "Grado Superior"};
	private String grado;
	
	private int nomModulosPrimero=0;
	private int nomModulosSegundo=0;
	
	
	public Ciclo(String nom, int n){
		this.nombre=nom;
		this.grado=grados[n-1];
		
	}
	public String Nom(){
		return this.nombre;
	}
	public void anyadeModulo(Modulo m) {
		if(m.getCurso()==1) {
			primero[this.nomModulosPrimero]=m;
			nomModulosPrimero++;
		}
		else {
			segundo[this.nomModulosSegundo]=m;
			nomModulosSegundo++;
		}
	}
}
