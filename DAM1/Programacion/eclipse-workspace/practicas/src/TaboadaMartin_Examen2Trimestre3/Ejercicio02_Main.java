package TaboadaMartin_Examen2Trimestre3;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Ejercicio02_Main {

	public static void main(String[] args) {
		Empleado e1 = new Empleado("Leonardo Di Caprio", 1500.3, 48.59);
		Empleado e2 = new Empleado("Leonardo Di Caprio", 1500.3, 48.59);
		Empleado e3 = new Empleado("Pepito grillo",2500, 88.6);
		Empleado juan = new Empleado("Juan Perez", 36050.5,105.36);
		Empleado juanNo = new Empleado("Juan no Perez",1500, 58);
		
		ArrayList <Empleado>empleados =new ArrayList<>(List.of(e1,e2,e3,juan,juanNo));
		Collections.sort(empleados);
		for(Empleado e:empleados) {
			System.out.println(e.toString());
		}
		

	}

}
