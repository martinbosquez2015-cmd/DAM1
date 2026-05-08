package pokemon;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Mani {

	public static void main(String[] args) {
		Pokemon pikachu = new Pokemon("Pikachu", 25, "Eléctrico");
		Pokemon butterfee = new Pokemon("Butterfree",12,  "Bicho", "Volador");
		Pokemon newpikachu = new Pokemon("Pikachu", 25, "Eléctrico");
		Pokemon newnewpikachu = pikachu;
		Pokemon p1= new Pokemon("Charmander", 1010 , "Fuego","volador");
		Pokemon p2= new Pokemon("Bulbasur", 1014, "Planta");
		Pokemon p3 = new Pokemon("Ivysaur", 1015, "Planta");
		Pokemon pokemon1 = new Pokemon( "Bulbasaur",8, "Planta");
		Pokemon pokemon2 = new Pokemon( "Pidgeot",6, "Volador", "Fuego");
		Pokemon pokemon3 = new Pokemon( "Ivysaur",2, "Planta");
		ArrayList<Pokemon> lista = new ArrayList <>(List.of(p1,p2,pikachu,pokemon1,p3,butterfee,pokemon2,pokemon3));;
		Collections.sort(lista);
		System.out.println(pikachu);
		System.out.println(butterfee);
		System.out.println(lista);

	}

}
