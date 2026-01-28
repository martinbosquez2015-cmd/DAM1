package segundoTrimestre;
import java.util.ArrayList;
public class Proyecto {
	private String nombre;
	private JefeProyecto jefe;
	private int codigoP;
	private int limitDevs=-1;
	private ArrayList<Programador> desarrolladores=new ArrayList<>();;
	private static ArrayList<Proyecto> proyectos=new ArrayList<>();;
	public Proyecto(String n, JefeProyecto j, int limite) {
		this.nombre=n;
		this.jefe=j;
		this.limitDevs=limite;
		proyectos.add(this);
		this.codigoP=generarCodigo();
		
		
	}
	
	public Proyecto(String n, JefeProyecto j) {
		this.nombre=n;
		this.jefe=j;
		proyectos.add(this);
		this.codigoP=generarCodigo();

	}
	
	public static int generarCodigo() {
		return proyectos.size();
	}
	
	public void setlimite(int n) {
		if (this.limitDevs!=-1) 
			System.out.printf("Error: el límite ya está impuesto para este proyecto, y es %d\n", this.limitDevs);
		else {
			this.limitDevs=n;
			System.out.printf("%d desarrolladores asignados al proyecto PRO-%03d\n", this.limitDevs, this.codigoP);
		}
	}
	
	public void setJefe(JefeProyecto j) {
		this.jefe=j;
		System.out.printf("El Jefe de Proyecto PRO-%03d ha cambiado. Ahora es %s\n", this.codigoP, j.getNombre());
	}
	
	public void setDev(Programador p) {
		if (desarrolladores.size()==this.limitDevs) {
			System.out.printf("Error: El proyecto PRO-%03d ya tiene la plantilla llena\n", this.codigoP);
		}
		else if(this.limitDevs==-1){
			System.out.printf("Error: El proyecto PRO-%03d aún no tiene asignado un número de desarrolladores\n", this.codigoP);
			
		}
		else {
			if(desarrolladores.contains(p))
				System.out.printf("Programador %s ya esta asignado en el proyecto PRO-%03d\n", p.getNombre(),this.codigoP);
			else {
			System.out.printf("Colocando a %s en el proyecto PRO-%03d\n", p.getNombre(),this.codigoP);
			desarrolladores.add(p);
			 }
		}
	}
	
	
	public void mostrar() {
		System.out.println("-----------------------------------------");
		System.out.printf("Proyecto: PRO-%03d\n%s\nJefe de Proyectos: %s\n", this.codigoP, this.nombre, this.jefe.getNombre());
		if(this.limitDevs!=-1) {
			System.out.printf("Desarrolladores asignados: %d\n", this.limitDevs);
		}
		System.out.println("-----------------------------------------");
	}
}
