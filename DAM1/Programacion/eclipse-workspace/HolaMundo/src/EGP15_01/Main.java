package EGP15_01;

public class Main {

	public static void main(String[] args) {
		CentroMedico cm1= new CentroMedico("Gregorio MArañon", "CM-0001");
		CentroMedico cm2= new CentroMedico("Beata", "CM-0002");
		CentroMedico cm3= new CentroMedico("RAmón y Cajañ", "CM-0003");
		
		Paciente p1= new Paciente("Juan Ramón", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p2= new Paciente("Juan", "Díaz", "46068658N", 608553440, cm1);
		Paciente p3= new Paciente("Pepe", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p4= new Paciente("Ramón", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p5= new Paciente("Carlos", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p6= new Paciente("REynaldo", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p7= new Paciente("Andres", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p8= new Paciente("María", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p9= new Paciente("Marta", "Jiménez Díaz", "46068652N", 608553410, cm1);
		Paciente p10= new Paciente("Jimena", "Jiménez Díaz", "46068652N", 608553410, cm1);
		
		Medico m1 = new Medico ("Juan Martin", "Robles Landa", "Neurología", "000001", cm1);
		Medico m2 = new Medico("Ana Lucia", "Gomez Perez", "Cardiología", "000002", cm2);
		Medico m3 = new Medico("Carlos Alberto", "Hernandez Ruiz", "Pediatría", "000003", cm3);
		Medico m4 = new Medico("Maria Fernanda", "Lopez Castro", "Ginecología", "000004", cm1);
		Medico m5 = new Medico("Luis Eduardo", "Martinez Soto", "Traumatología", "000005", cm2);
		Medico m6 = new Medico("Paola Andrea", "Ramirez Flores", "Dermatología", "000006", cm3);
		Medico m7 = new Medico("Jorge Ivan", "Salinas Cruz", "Psiquiatría", "000007", cm1);
		
		
		cm1.listarMedicos();
		System.out.println();
		System.out.println();
		cm3.listarMedicos();
		
		m1.changeCenter(cm3);
		
		cm1.listarMedicos();
		System.out.println();
		System.out.println();
		cm3.listarMedicos();
		
		cm1.listarPacientes();

		
	}

}
