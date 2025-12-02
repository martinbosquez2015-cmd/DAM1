
package pokemon;


public class poo2 {

	public static void main(String[] args) {
		
		Pokemon p1= new Pokemon("Charmander", 1010 , "Fuego","volador");
		Pokemon p2= new Pokemon("Bulbasur", 1014, "Planta");
		Pokemon p3 = new Pokemon("Ivysaur", 1015, "Planta");
		p1.mostrar();
		
		p2.mostrar();
		p2.setEvolucion(p3);
		p2 = p2.evoluciona();
		p2.mostrar();
		p1.evoluciona();
		p1.mostrar();
		p3.mostrar();
		p1.combateContra(p3);
		
		
	}

}
