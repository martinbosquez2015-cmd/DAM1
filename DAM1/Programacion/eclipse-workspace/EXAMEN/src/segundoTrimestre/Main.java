package segundoTrimestre;

public class Main {

	public static void main(String[] args) {
		Programador p1= new Programador("Armando Paredes", 1500, true, false);
		Programador p2= new Programador("Andres Galvéz", 1300, true, false);
		Programador p4= new Programador("Juan Carlos Bodoque", 1700, true, false);
		Programador p5= new Programador("Tulio Triviño", 1100, true, false);
		Programador p6= new Programador("Balon bon bola", 1200, true, false);
		Programador p7= new Programador("German Garmendia", 1700, true, false);
		Programador p8= new Programador("Demetrio Imedio", 1700, true, false);
		Programador p9= new Programador("Germán Ivela", 1400, true, false);
		Programador p10= new Programador("Benito Camelas", 1300, true, false);
		
		JefeProyecto j1= new JefeProyecto("Larry Capija", 2500);
		JefeProyecto j2= new JefeProyecto("Rosa Melano", 2500);
		JefeProyecto j3= new JefeProyecto("Pablo Emlio Escobar Gavidia", 2500);
		JefeProyecto j4= new JefeProyecto("Darkar Alcatriz", 2500);
		
		Proyecto pr1= new Proyecto("Destruir a todos los gatitos de internet", j3);
		pr1.setDev(p8);
		pr1.mostrar();
		pr1.setJefe(j1);
		pr1.mostrar();
		pr1.setlimite(3);
		pr1.setDev(p7);
		pr1.mostrar();
		pr1.setDev(p7);
		pr1.setDev(p6);
		pr1.setDev(p4);
		
		
		Proyecto pr2= new Proyecto("idk", j1);
		
		j1.mostrar();
		p1.mostrar();
		

	}

}
