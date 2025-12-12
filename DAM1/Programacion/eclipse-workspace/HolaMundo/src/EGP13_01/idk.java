package EGP13_01;

public class idk {

	public static void main(String[] args) {
		Modulo programacion = new Modulo("Programacion", 8, 1, false);
		Modulo bases = new Modulo("Bases de datos", 6, 1, false);
		Modulo Sist = new Modulo("Sistemas informáticos", 6, 1, false);
		Modulo fund = new Modulo("Fundamentos de programacion", 2, 1, true);
		Modulo progPhy = new Modulo("Programacion en Phyton", 8, 2, false);
	
		Ciclo c1= new Ciclo("DAM", 2);
		c1.anyadeModulo(programacion);
		c1.anyadeModulo(progPhy);
		c1.anyadeModulo(fund);
		c1.anyadeModulo(Sist);
		c1.anyadeModulo(bases);
		
		
		Grupo g1 = new Grupo("DAM1",c1,1,28);
		
		Alumno A1= new Alumno("Juan", "Perez", 19);
		
		Profesor p1= new Profesor("Alvin", "De la Concepcion",  "Informática");
		
		
		A1.mostrar();
		
	}

}
